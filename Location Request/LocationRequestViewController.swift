//
//  LocationRequestViewController.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol LocationRequestViewControllerLogic: AnyObject {
    func locationServicesEnabled()
}

final class LocationRequestViewController: UIViewController {
    // MARK: - Public Properties
    var interactor: LocationRequestInteractorLogic?
    var router: LocationRequestRouterType?
    
    // MARK: - View Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.interactor?.requestLocationAuthorization()
        }
    }
}

extension LocationRequestViewController: LocationRequestViewControllerLogic {
    func locationServicesEnabled() {
        router?.navigateToMap()
    }
}
