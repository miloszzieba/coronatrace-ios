//
//  LocationRequestInteractor.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol LocationRequestInteractorLogic {
    func requestLocationAuthorization()
}

protocol LocationRequestDataStore {}

final class LocationRequestInteractor: LocationRequestDataStore {
    // MARK: - Public Properties
    var presenter: LocationRequestPresenterLogic

    // MARK: - Private Properties
    private let locationWorker: LocationWorkerProtocol
    
    // MARK: - Initializers
    init(presenter: LocationRequestPresenterLogic,
         locationWorker: LocationWorkerProtocol = LocationWorker.shared) {
        self.presenter = presenter
        self.locationWorker = locationWorker
        locationWorker.delegate = self
    }
}

extension LocationRequestInteractor: LocationRequestInteractorLogic {
    func requestLocationAuthorization() {
        locationWorker.requestAuthorization()
    }
}

extension LocationRequestInteractor: LocationWorkerDelegate {
    func locationWorker(_ worker: LocationWorker, didUpdateLocation location: LocationModel) {  }
    
    func locationWorker(_ worker: LocationWorker, didChangeAuthorization isAuthorized: Bool) {
        if isAuthorized {
            presenter.locationServicesEnabled()
        } else {
            // TODO: - Handle
        }
    }
}
