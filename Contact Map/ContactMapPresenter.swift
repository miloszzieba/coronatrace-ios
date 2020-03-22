//
//  ContactMapPresenter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol ContactMapPresenterLogic {}

final class ContactMapPresenter {
    // MARK: - Private Properties
    private weak var viewController: ContactMapViewControllerLogic?

    // MARK: - Initializers
    init(viewController: ContactMapViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension ContactMapPresenter: ContactMapPresenterLogic {}
