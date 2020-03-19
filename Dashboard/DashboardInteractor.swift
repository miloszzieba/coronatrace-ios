//
//  DashboardInteractor.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

@objc protocol DashboardInteractorLogic {
    func refresh()
}
protocol DashboardDataStore {}

final class DashboardInteractor: DashboardDataStore {
    private var presenter: DashboardPresenterLogic?
    private var locationDatabase: DBLocationWorkerProtocol
    private var locationWorker: LocationWorkerProtocol
    
    private var locations: [LocationModel] = [] {
        didSet {
            presenter?.reloadLocationList(with: locations)
        }
    }
    
    init(presenter: DashboardPresenterLogic,
         locationDatabase: DBLocationWorkerProtocol,
         locationWorker: LocationWorkerProtocol) {
        self.presenter = presenter
        self.locationDatabase = locationDatabase
        self.locationWorker = locationWorker
        locationWorker.delegate = self
    }
}

extension DashboardInteractor: DashboardInteractorLogic {
    func refresh() {
        reloadLocations()
    }
}

extension DashboardInteractor: LocationWorkerDelegate {
    func locationWorker(_ worker: LocationWorker, didUpdateLocation location: LocationModel) {
        reloadLocations()
    }
}

private extension DashboardInteractor {
    func reloadLocations() {
        self.locations = self.locationDatabase.list()
    }
}
