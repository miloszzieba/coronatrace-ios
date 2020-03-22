//
//  ToSInteractor.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol ToSInteractorLogic {}

protocol ToSDataStore {}

final class ToSInteractor: ToSDataStore {
    // MARK: - Public Properties
    var presenter: ToSPresenterLogic

    // MARK: - Initializers
    init(presenter: ToSPresenterLogic) {
      self.presenter = presenter
    }
}

extension ToSInteractor: ToSInteractorLogic {  }
