//
//  ContactMapConfigurator.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import UIKit

public protocol ContactMapConfiguratorProtocol {
    static func configureContactMapModule() -> UIViewController
}

public enum ContactMapConfigurator: ContactMapConfiguratorProtocol {
    public static func configureContactMapModule() -> UIViewController {
        let viewController: ContactMapViewController = ContactMapViewController(nib: R.nib.contactMapViewController)

        let presenter = ContactMapPresenter(viewController: viewController)
        let interactor = ContactMapInteractor(presenter: presenter)
        let router = ContactMapRouter(viewController: viewController, dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
