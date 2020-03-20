//
//  LocationWorker.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 17/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import Foundation
import UIKit.UIApplication
import CoreLocation

protocol LocationWorkerProtocol: AnyObject {
    typealias BackgroundFetchResponse = ((LocationModel?, Error?) -> ())
    
    var delegate: LocationWorkerDelegate? { get set }
    
    func requestAuthorization()
    func backgroundFetchRequest(response: BackgroundFetchResponse?)
}

protocol LocationWorkerDelegate: AnyObject {
    func locationWorker(_ worker: LocationWorker, didChangeAuthorization isAuthorized: Bool)
    func locationWorker(_ worker: LocationWorker, didUpdateLocation location: LocationModel)
}

extension LocationWorkerDelegate {
    func locationWorker(_ worker: LocationWorker, didChangeAuthorization isAuthorized: Bool) { }
}

final class LocationWorker: NSObject, LocationWorkerProtocol {
    private enum Constants {
        static let minimumAccuracy: CLLocationAccuracy = 50.0
        static let backgroundFetchRequestTimeout: TimeInterval = 10.0
        static let newLocationThrottle: TimeInterval = 60.0 * 5.0
    }
    
    enum LocationWorkerError: Error {
        case backgroundFetchTimeout
    }
    
    // MARK: - Public Properties
    static let shared = LocationWorker()
    
    weak var delegate: LocationWorkerDelegate?
    var locationDatabase: DBLocationWorkerProtocol?
    
    // MARK: - Private Properties
    private let locationManager = CLLocationManager()
    
    private var backgroundFetchResponse: BackgroundFetchResponse?
    private var backgroundFetchRequestTimeoutTimer: Timer?
    
    // MARK: - Initializers
    override init() {
        super.init()
        
        setup()
    }
    
    // MARK: - Public Methods
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func backgroundFetchRequest(response: BackgroundFetchResponse?) {
        backgroundFetchResponse = response

        backgroundFetchRequestTimeoutTimer = Timer.scheduledTimer(
            timeInterval: Constants.backgroundFetchRequestTimeout,
            target: self,
            selector: #selector(backgroundFetchRequestTimeout),
            userInfo: nil,
            repeats: false)
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationWorker: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            delegate?.locationWorker(self, didChangeAuthorization: true)
            manager.startUpdatingLocation()
        case .denied, .restricted:
            delegate?.locationWorker(self, didChangeAuthorization: false)
        default:
            return
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        let validLocations = locations.filter { isLocationValid($0) }
        
        validLocations.forEach { location in
            let locationModel = LocationModel(location: location)
            
            save(location: locationModel)
            delegate?.locationWorker(self, didUpdateLocation: locationModel)
            backgroundFetchResponse?(locationModel, nil)
        }
        
        backgroundFetchResponse = nil
    }
}

// MARK: - Private Methods
private extension LocationWorker {
    func setup() {
        setupLocationManager()
        setupSystemLifecycleObservers()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.startUpdatingLocation()
    }
    
    func setupSystemLifecycleObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }
    
    @objc func appMovedToBackground() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    @objc func appMovedToForeground() {
        locationManager.startUpdatingLocation()
    }
    
    @objc func backgroundFetchRequestTimeout(_ timer: Timer) {
        backgroundFetchResponse?(nil, LocationWorkerError.backgroundFetchTimeout)
        backgroundFetchResponse = nil
        
        timer.invalidate()
        backgroundFetchRequestTimeoutTimer = nil
    }
    
    func isLocationValid(_ location: CLLocation) -> Bool {
        location.verticalAccuracy < Constants.minimumAccuracy && location.horizontalAccuracy < Constants.minimumAccuracy
    }
    
    func save(location: LocationModel) {
        let locations = locationDatabase?.list().sorted()
        
        guard locations?.isEmpty == false else {
            locationDatabase?.save(object: location)
            return
        }
        
        guard let lastSavedLocation = locations?.last,
            Date().timeIntervalSince1970 - lastSavedLocation.timestamp > Constants.newLocationThrottle else {
            return
        }
        
        locationDatabase?.save(object: location)
    }
}
