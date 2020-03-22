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
        setupNavigationBar()
        
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

private extension AppDelegate {
    func setupNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
    }
}
