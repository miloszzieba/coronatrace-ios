//
//  DatabaseStorable.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 19/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import Foundation

protocol DatabaseStorable {
    associatedtype Model: DBModel
    
    func toDBModel() -> Model
    
    init(dbModel: Model)
}
