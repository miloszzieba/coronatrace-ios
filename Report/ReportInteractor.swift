//
//  ReportInteractor.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol ReportInteractorLogic {}

protocol ReportDataStore {}

final class ReportInteractor: ReportDataStore {
    // MARK: - Public Properties
    var presenter: ReportPresenterLogic

    // MARK: - Initializers
    init(presenter: ReportPresenterLogic) {
      self.presenter = presenter
    }
}

extension ReportInteractor: ReportInteractorLogic {  }
