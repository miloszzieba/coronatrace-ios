//
//  LocationRequestConfigurator.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import UIKit

public protocol LocationRequestConfiguratorProtocol {
    static func configureLocationRequestModule() -> UIViewController
}

public enum LocationRequestConfigurator: LocationRequestConfiguratorProtocol {
    public static func configureLocationRequestModule() -> UIViewController {
        let viewController: LocationRequestViewController = LocationRequestViewController(nib: R.nib.locationRequestViewController)

        let presenter = LocationRequestPresenter(viewController: viewController)
        let interactor = LocationRequestInteractor(presenter: presenter)
        let router = LocationRequestRouter(viewController: viewController, dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
