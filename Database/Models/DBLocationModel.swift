//
//  DBLocationModel.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 19/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import RealmSwift

class DBLocationModel: DBModel {
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var timestamp: Double = 0
    @objc dynamic var horizontalAccuracy: Double = 0
    @objc dynamic var verticalAccuracy: Double = 0
    
    convenience init(location: LocationModel) {
        self.init()
        latitude = location.latitude
        longitude = location.longitude
        timestamp = location.timestamp
        horizontalAccuracy = location.horizontalAccuracy
        verticalAccuracy = location.verticalAccuracy
    }
}
