//
//  LocationWorker.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 17/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationWorkerDelegate: class {
    func locationWorker(_ worker: LocationWorker, didChangeAuthorization isAuthorized: Bool)
    func locationWorker(_ worker: LocationWorker, didUpdateLocation location: LocationModel)
}

final class LocationWorker: NSObject {
    // MARK: - Public Properties
    weak var delegate: LocationWorkerDelegate?
    
    // MARK: - Private Properties
    private let locationManager = CLLocationManager()
    
    // MARK: - Initializers
    override init() {
        super.init()
        
        setup()
    }
    
    // MARK: - Public Methods
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.startMonitoringSignificantLocationChanges()
    }
}

extension LocationWorker: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            delegate?.locationWorker(self, didChangeAuthorization: true)
            manager.startMonitoringSignificantLocationChanges()
        case .denied, .restricted:
            delegate?.locationWorker(self, didChangeAuthorization: false)
        default:
            return
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        locations.forEach { location in
            let locationModel = LocationModel(location: location)
            delegate?.locationWorker(self, didUpdateLocation: locationModel)
        }
    }
}
