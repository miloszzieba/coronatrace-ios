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
    
    private lazy var locationWorker: LocationWorkerProtocol = {
        let worker = LocationWorker.shared
        worker.locationDatabase = DBLocationWorker.shared
        
        return worker
    }()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let main = MainConfigurator().configureMainModule(with: window)
        
        self.mainRouter = main
        self.window = window
        
        application.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        
        //This line below is temporary here, until we figure out flow for authorization request
        locationWorker.requestAuthorization()
        
        return true
    }
    
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        locationWorker.backgroundFetchRequest { locationModel, error in
            guard locationModel != nil else {
                if let error = error {
                    print(error)
                    completionHandler(.failed)
                } else {
                    completionHandler(.noData)
                }
                return
            }
            
            completionHandler(.newData)
        }
    }
}
