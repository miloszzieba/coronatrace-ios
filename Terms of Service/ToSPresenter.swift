//
//  ToSPresenter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol ToSPresenterLogic {}

final class ToSPresenter {
    // MARK: - Private Properties
    private weak var viewController: ToSViewControllerLogic?

    // MARK: - Initializers
    init(viewController: ToSViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension ToSPresenter: ToSPresenterLogic {}
