//
//  ContactMapInteractor.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol ContactMapInteractorLogic {}

protocol ContactMapDataStore {}

final class ContactMapInteractor: ContactMapDataStore {
    // MARK: - Public Properties
    var presenter: ContactMapPresenterLogic

    // MARK: - Initializers
    init(presenter: ContactMapPresenterLogic) {
      self.presenter = presenter
    }
}

extension ContactMapInteractor: ContactMapInteractorLogic {  }
