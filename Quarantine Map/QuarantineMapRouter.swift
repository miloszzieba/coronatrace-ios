//
//  QuarantineMapRouter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

typealias QuarantineMapRouterType = QuarantineMapRouterProtocol & QuarantineMapDataPassing

@objc protocol QuarantineMapRouterProtocol {
    func navigateToReport()
    func presentContact()
}

protocol QuarantineMapDataPassing {
    var dataStore: QuarantineMapDataStore { get }
}

final class QuarantineMapRouter: QuarantineMapDataPassing {
    // MARK: - Public Properties
    weak var viewController: QuarantineMapViewController?
    var dataStore: QuarantineMapDataStore

    // MARK: - Initializers
    init(viewController: QuarantineMapViewController?, dataStore: QuarantineMapDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension QuarantineMapRouter: QuarantineMapRouterProtocol {
    func navigateToReport() {
        let vc = ReportConfigurator.configureReportModule()
        viewController?.present(vc, animated: true)
    }
    
    func presentContact() {
        let vc = ContactMapConfigurator.configureContactMapModule()
        viewController?.present(vc, animated: true)
    }
}
