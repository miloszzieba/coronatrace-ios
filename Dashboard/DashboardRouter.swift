//
//  DashboardRouter.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

typealias DashboardRouterType = DashboardRouterProtocol & DashboardDataPassing

@objc protocol DashboardRouterProtocol {}

protocol DashboardDataPassing {
    var dataStore: DashboardDataStore? { get }
}

final class DashboardRouter: DashboardDataPassing {
    weak var viewController: DashboardViewController?
    var dataStore: DashboardDataStore?
    
    init(viewController: DashboardViewController?, dataStore: DashboardDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension DashboardRouter: DashboardRouterProtocol {}
