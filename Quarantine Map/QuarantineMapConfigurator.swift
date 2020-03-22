//
//  QuarantineMapConfigurator.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import UIKit

public protocol QuarantineMapConfiguratorProtocol {
    static func configureQuarantineMapModule() -> UIViewController
}

public enum QuarantineMapConfigurator: QuarantineMapConfiguratorProtocol {
    public static func configureQuarantineMapModule() -> UIViewController {
        let viewController: QuarantineMapViewController = QuarantineMapViewController(nib: R.nib.quarantineMapViewController)

        let presenter = QuarantineMapPresenter(viewController: viewController)
        let interactor = QuarantineMapInteractor(presenter: presenter)
        let router = QuarantineMapRouter(viewController: viewController, dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
