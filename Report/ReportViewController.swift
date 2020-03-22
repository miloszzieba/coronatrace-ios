//
//  ReportViewController.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit

protocol ReportViewControllerLogic: AnyObject {}

final class ReportViewController: UIViewController {
    // MARK: - ibOutlets
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var image: UIImageView!
    
    // MARK: - ibActions
    @IBAction private func send(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Public Properties
    var interactor: ReportInteractorLogic?
    var router: ReportRouterType?
    
    // MARK: - Private Properties
    private var imagePicker: ImagePicker?
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapRecognizer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageContainerView.layer.cornerRadius = 8.0
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
    }
}

extension ReportViewController: ReportViewControllerLogic {}

private extension ReportViewController {
    func setupTapRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        imageContainerView.addGestureRecognizer(recognizer)
    }
    
    @objc func choosePhoto() {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.imagePicker = imagePicker
        imagePicker.present(from: view)
    }
}

extension ReportViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.image.image = image
    }
}
