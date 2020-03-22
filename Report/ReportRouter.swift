//
//  ReportRouter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

typealias ReportRouterType = ReportRouterProtocol & ReportDataPassing

@objc protocol ReportRouterProtocol {}

protocol ReportDataPassing {
    var dataStore: ReportDataStore { get }
}

final class ReportRouter: ReportDataPassing {
    // MARK: - Public Properties
    weak var viewController: ReportViewController?
    var dataStore: ReportDataStore

    // MARK: - Initializers
    init(viewController: ReportViewController?, dataStore: ReportDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension ReportRouter: ReportRouterProtocol {}
