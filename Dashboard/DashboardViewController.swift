//
//  DashboardViewController.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol DashboardViewControllerLogic: AnyObject {}

final class DashboardViewController: UIViewController {
    var interactor: DashboardInteractorLogic?
    var router: DashboardRouterType?
}

extension DashboardViewController: DashboardViewControllerLogic {}
