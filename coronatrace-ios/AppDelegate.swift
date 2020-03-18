//
//  AppDelegate.swift
//  coronatrace-ios
//
//  Created by Patryk Mieszała on 17/03/2020.
//  Copyright © 2020 Coronatrace. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainRouter: MainRouter?
    
    let locationWorker: LocationWorkerProtocol = LocationWorker.shared
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let main = MainConfigurator().configureMainModule(with: window)
        
        self.mainRouter = main
        self.window = window
        
        application.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        
        return true
    }
    
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        locationWorker.backgroundFetchRequest { locationModel, error in
            guard let locationModel = locationModel else {
                if let error = error {
                    print(error)
                    completionHandler(.failed)
                } else {
                    completionHandler(.noData)
                }
                return
            }
            
            // TODO: - Handle received model
            print(locationModel)
            completionHandler(.newData)
        }
    }
}
