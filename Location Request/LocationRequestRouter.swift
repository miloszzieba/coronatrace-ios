//
//  LocationRequestRouter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

typealias LocationRequestRouterType = LocationRequestRouterProtocol & LocationRequestDataPassing

@objc protocol LocationRequestRouterProtocol {
    func navigateToMap()
}

protocol LocationRequestDataPassing {
    var dataStore: LocationRequestDataStore { get }
}

final class LocationRequestRouter: LocationRequestDataPassing {
    // MARK: - Public Properties
    weak var viewController: LocationRequestViewController?
    var dataStore: LocationRequestDataStore

    // MARK: - Initializers
    init(viewController: LocationRequestViewController?, dataStore: LocationRequestDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension LocationRequestRouter: LocationRequestRouterProtocol {
    func navigateToMap() {
        let vc = QuarantineMapConfigurator.configureQuarantineMapModule()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
