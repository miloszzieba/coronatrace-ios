//
//  DBLocationWorker.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 19/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import Foundation

protocol DBLocationWorkerProtocol: AnyObject {
    func list() -> [DBLocationModel]
    func save(object: DBLocationModel)
    func remove(object: DBLocationModel)
}

final class DBLocationWorker: DatabaseWorker<DBLocationModel> {
    static let shared: DBLocationWorkerProtocol = DBLocationWorker()
    
    private override init() { }
}

extension DBLocationWorker: DBLocationWorkerProtocol { }
