//
//  QuarantineMapPresenter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol QuarantineMapPresenterLogic {}

final class QuarantineMapPresenter {
    // MARK: - Private Properties
    private weak var viewController: QuarantineMapViewControllerLogic?

    // MARK: - Initializers
    init(viewController: QuarantineMapViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension QuarantineMapPresenter: QuarantineMapPresenterLogic {}
