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

protocol LocationWorkerProtocol {
    typealias BackgroundFetchResponse = ((LocationModel?, Error?) -> ())
    
    var delegate: LocationWorkerDelegate? { get set }
    
    func requestAuthorization()
    func backgroundFetchRequest(response: BackgroundFetchResponse?)
}

protocol LocationWorkerDelegate: class {
    func locationWorker(_ worker: LocationWorker, didChangeAuthorization isAuthorized: Bool)
    func locationWorker(_ worker: LocationWorker, didUpdateLocation location: LocationModel)
}

final class LocationWorker: NSObject, LocationWorkerProtocol {
    private enum Constants {
        static let minimumAccuracy: CLLocationAccuracy = 50.0
        static let backgroundFetchRequestTimeout: TimeInterval = 10.0
    }
    
    enum LocationWorkerError: Error {
        case backgroundFetchTimeout
    }
    
    // MARK: - Public Properties
    static let shared = LocationWorker()
    
    weak var delegate: LocationWorkerDelegate?
    
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
    
    // MARK: - Private Methods
    private func setup() {        
        setupLocationManager()
        setupSystemLifecycleObservers()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.startUpdatingLocation()
    }
    
    private func setupSystemLifecycleObservers() {
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
    
    @objc private func appMovedToBackground() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    @objc private func appMovedToForeground() {
        locationManager.startUpdatingLocation()
    }
    
    @objc private func backgroundFetchRequestTimeout(_ timer: Timer) {
        backgroundFetchResponse?(nil, LocationWorkerError.backgroundFetchTimeout)
        backgroundFetchResponse = nil
        
        timer.invalidate()
        backgroundFetchRequestTimeoutTimer = nil
    }
}

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
            delegate?.locationWorker(self, didUpdateLocation: locationModel)
            backgroundFetchResponse?(locationModel, nil)
        }
        
        backgroundFetchResponse = nil
    }
    
    private func isLocationValid(_ location: CLLocation) -> Bool {
        location.verticalAccuracy < Constants.minimumAccuracy && location.horizontalAccuracy < Constants.minimumAccuracy
    }
}
