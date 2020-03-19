//
//  DBLocationWorker.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 19/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import Foundation

protocol DBLocationWorkerProtocol: AnyObject {
    func list() -> [LocationModel]
    func save(object: LocationModel)
    func remove(object: LocationModel)
}

final class DBLocationWorker: DatabaseWorker<LocationModel> {
    static let shared: DBLocationWorkerProtocol = DBLocationWorker()
    
    private override init() { }
}

extension DBLocationWorker: DBLocationWorkerProtocol { }
