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
    
    // MARK: - Public Properties
    let latitude: LocationDegrees
    let longitude: LocationDegrees
    let timestamp: TimeInterval
    
    // MARK: - Initializers
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.timestamp = location.timestamp.timeIntervalSince1970
    }
}
