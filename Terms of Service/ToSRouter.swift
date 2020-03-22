//
//  ToSRouter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

typealias ToSRouterType = ToSRouterProtocol & ToSDataPassing

@objc protocol ToSRouterProtocol {
    func navigateToLocationRequest()
}

protocol ToSDataPassing {
    var dataStore: ToSDataStore { get }
}

final class ToSRouter: ToSDataPassing {
    // MARK: - Public Properties
    weak var viewController: ToSViewController?
    var dataStore: ToSDataStore

    // MARK: - Initializers
    init(viewController: ToSViewController?, dataStore: ToSDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension ToSRouter: ToSRouterProtocol {
    func navigateToLocationRequest() {
        let vc = LocationRequestConfigurator.configureLocationRequestModule()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
