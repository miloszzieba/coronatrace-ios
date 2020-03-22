//
//  ReportPresenter.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol ReportPresenterLogic {}

final class ReportPresenter {
    // MARK: - Private Properties
    private weak var viewController: ReportViewControllerLogic?

    // MARK: - Initializers
    init(viewController: ReportViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension ReportPresenter: ReportPresenterLogic {}
