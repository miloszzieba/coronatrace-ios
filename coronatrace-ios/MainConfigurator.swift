//
//  MainConfigurator.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol MainConfiguratorProtocol {
    func configureMainModule(with window: UIWindow?) -> MainRouter
}

final class MainConfigurator: MainConfiguratorProtocol {
    func configureMainModule(with window: UIWindow?) -> MainRouter {
        let router = MainRouter(window: window)
        window?.makeKeyAndVisible()
        
        return router
    }
}
