//
//  DashboardPresenter.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol DashboardPresenterLogic {
    func reloadLocationList(with locations: [LocationModel])
}

final class DashboardPresenter {
    private weak var viewController: DashboardViewControllerLogic?
    
    init(viewController: DashboardViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension DashboardPresenter: DashboardPresenterLogic {
    func reloadLocationList(with locations: [LocationModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, LocationModel>()
        snapshot.appendSections([""])
        snapshot.appendItems(locations)
        
        viewController?.reloadList(snapshot: snapshot)
    }
}
