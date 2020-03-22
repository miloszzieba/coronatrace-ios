//
//  LocationRequestPresenter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol LocationRequestPresenterLogic {
    func locationServicesEnabled()
}

final class LocationRequestPresenter {
    // MARK: - Private Properties
    private weak var viewController: LocationRequestViewControllerLogic?

    // MARK: - Initializers
    init(viewController: LocationRequestViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension LocationRequestPresenter: LocationRequestPresenterLogic {
    func locationServicesEnabled() {
        viewController?.locationServicesEnabled()
    }
}
