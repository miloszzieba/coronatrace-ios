//
//  ReportConfigurator.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import UIKit

public protocol ReportConfiguratorProtocol {
    static func configureReportModule() -> UIViewController
}

public enum ReportConfigurator: ReportConfiguratorProtocol {
    public static func configureReportModule() -> UIViewController {
        let viewController: ReportViewController = ReportViewController(nib: R.nib.reportViewController)

        let presenter = ReportPresenter(viewController: viewController)
        let interactor = ReportInteractor(presenter: presenter)
        let router = ReportRouter(viewController: viewController, dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
