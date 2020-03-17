//
//  DashboardInteractor.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol DashboardInteractorLogic {}
protocol DashboardDataStore {}

final class DashboardInteractor: DashboardDataStore {
    private var presenter: DashboardPresenterLogic?
    //var worker: DashboardWorker?
    
    init(presenter: DashboardPresenterLogic) {
        self.presenter = presenter
    }
}

extension DashboardInteractor: DashboardInteractorLogic {}
