//
//  DashboardConfigurator.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol DashboardConfiguratorProtocol {
    func configureDashboardModule() -> UIViewController?
}

final class DashboardConfigurator: DashboardConfiguratorProtocol {
    func configureDashboardModule() -> UIViewController? {
        let dashboard = R.storyboard.dashboard.dashboardViewController()
        let presenter = DashboardPresenter(viewController: dashboard)
        let interactor = DashboardInteractor(presenter: presenter)
        let router = DashboardRouter(viewController: dashboard, dataStore: interactor)
        
        dashboard?.interactor = interactor
        dashboard?.router = router
        
        return dashboard
    }
}
