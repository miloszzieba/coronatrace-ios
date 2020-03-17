//
//  DashboardPresenter.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol DashboardPresenterLogic {}

final class DashboardPresenter {
    private weak var viewController: DashboardViewControllerLogic?
    
    init(viewController: DashboardViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension DashboardPresenter: DashboardPresenterLogic {}
