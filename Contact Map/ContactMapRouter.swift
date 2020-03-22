//
//  ContactMapRouter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

typealias ContactMapRouterType = ContactMapRouterProtocol & ContactMapDataPassing

@objc protocol ContactMapRouterProtocol {}

protocol ContactMapDataPassing {
    var dataStore: ContactMapDataStore { get }
}

final class ContactMapRouter: ContactMapDataPassing {
    // MARK: - Public Properties
    weak var viewController: ContactMapViewController?
    var dataStore: ContactMapDataStore

    // MARK: - Initializers
    init(viewController: ContactMapViewController?, dataStore: ContactMapDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension ContactMapRouter: ContactMapRouterProtocol {}
