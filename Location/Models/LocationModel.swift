//
//  LocationModel.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 17/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationModel {
    typealias LocationDegrees = Double
    typealias LocationAccuracy = Double
    
    // MARK: - Public Properties
    let latitude: LocationDegrees
    let longitude: LocationDegrees
    let timestamp: TimeInterval
    let horizontalAccuracy: LocationAccuracy
    let verticalAccuracy: LocationAccuracy
    
    // MARK: - Initializers
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.timestamp = location.timestamp.timeIntervalSince1970
        self.horizontalAccuracy = location.horizontalAccuracy
        self.verticalAccuracy = location.verticalAccuracy
    }
}

extension LocationModel: DatabaseStorable {
    init(dbModel: DBLocationModel) {
        self.latitude = dbModel.latitude
        self.longitude = dbModel.longitude
        self.timestamp = dbModel.timestamp
        self.horizontalAccuracy = dbModel.horizontalAccuracy
        self.verticalAccuracy = dbModel.verticalAccuracy
    }
    
    func toDBModel() -> DBLocationModel {
        DBLocationModel(location: self)
    }
}

extension LocationModel: Hashable {  }
