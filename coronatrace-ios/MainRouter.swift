//
//  MainRouter.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

@objc protocol MainRouterProtocol {}

final class MainRouter {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        showDashboard()
    }
}

extension MainRouter: MainRouterProtocol {}

private extension MainRouter {
    func showDashboard() {
        let dashboard = DashboardConfigurator().configureDashboardModule()
        window?.rootViewController = dashboard
    }
}
