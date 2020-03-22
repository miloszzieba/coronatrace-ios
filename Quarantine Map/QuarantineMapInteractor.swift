//
//  QuarantineMapInteractor.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol QuarantineMapInteractorLogic {}

protocol QuarantineMapDataStore {}

final class QuarantineMapInteractor: QuarantineMapDataStore {
    // MARK: - Public Properties
    var presenter: QuarantineMapPresenterLogic

    // MARK: - Initializers
    init(presenter: QuarantineMapPresenterLogic) {
      self.presenter = presenter
    }
}

extension QuarantineMapInteractor: QuarantineMapInteractorLogic {  }
