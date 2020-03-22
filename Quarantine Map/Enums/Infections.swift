//
//  Infections.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import Foundation
import CoreLocation

enum Infections {
    case czernica
    case dlugoleka
    case katyWroclawskie
    case mietkow
    case siechnice
    case sobotka
    
    var location: CLLocation {
        switch self {
        case .czernica:
            return CLLocation(latitude: 51.047, longitude: 17.238530)
        case .dlugoleka:
            return CLLocation(latitude: 51.180690, longitude: 17.194440)
        case .katyWroclawskie:
            return CLLocation(latitude: 51.031720, longitude: 16.767350)
        case .mietkow:
            return CLLocation(latitude: 50.973700, longitude: 16.649580)
        case .siechnice:
            return CLLocation(latitude: 51.033760, longitude: 17.147690)
        case .sobotka:
            return CLLocation(latitude: 50.8783215, longitude: 16.6540388)
        }
    }
    
    var infectionsCount: Int {
        switch self {
        case .czernica:
            return 13
        case .dlugoleka:
            return 42
        case .katyWroclawskie:
            return 27
        case .mietkow:
            return 3
        case .siechnice:
            return 19
        case .sobotka:
            return 3
        }
    }
    
    var radius: Double {
        switch infectionsCount {
        case ...13:
            return 2500
        case 14...30:
            return 3500
        default:
            return 4500
        }
    }
}

extension Infections: CaseIterable {  }
