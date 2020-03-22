//
//  ToSViewController.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol ToSViewControllerLogic: AnyObject {}

final class ToSViewController: UIViewController {
    // MARK: ibOutlets
    @IBOutlet private weak var textView: UITextView!
    
    // MARK: Actions
    @IBAction private func accept(_ sender: Any) {
        router?.navigateToLocationRequest()
    }
    
    // MARK: - Public Properties
    var interactor: ToSInteractorLogic?
    var router: ToSRouterType?
    
    // MARK: - View Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textView.layer.cornerRadius = 8.0
    }
}

extension ToSViewController: ToSViewControllerLogic {}
