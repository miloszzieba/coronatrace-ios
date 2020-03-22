//
//  ToSConfigurator.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import UIKit

public protocol ToSConfiguratorProtocol {
    static func configureToSModule() -> UIViewController
}

public enum ToSConfigurator: ToSConfiguratorProtocol {
    public static func configureToSModule() -> UIViewController {
        let viewController: ToSViewController = ToSViewController(nib: R.nib.toSViewController)

        let presenter = ToSPresenter(viewController: viewController)
        let interactor = ToSInteractor(presenter: presenter)
        let router = ToSRouter(viewController: viewController, dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
