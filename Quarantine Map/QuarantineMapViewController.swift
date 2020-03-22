//
//  QuarantineMapViewController.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 21/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit
import MapKit

protocol QuarantineMapViewControllerLogic: AnyObject {}

final class QuarantineMapViewController: UIViewController {
    // MARK: - ibOutlets
    @IBOutlet private weak var mapContainerView: UIView!
    @IBOutlet private weak var map: MKMapView!
    
    // MARK: - ibActions
    @IBAction private func report(_ sender: Any) {
        router?.navigateToReport()
    }
    
    // MARK: - Public Properties
    var interactor: QuarantineMapInteractorLogic?
    var router: QuarantineMapRouterType?
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.setHidesBackButton(true, animated: false)
        addAnnotations()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.router?.presentContact()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mapContainerView.layer.cornerRadius = 8.0
        map.layer.cornerRadius = 8.0
    }
}

extension QuarantineMapViewController: QuarantineMapViewControllerLogic {}

extension QuarantineMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.systemRed.withAlphaComponent(0.5)
        return renderer
    }
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }

        if let customPointAnnotation = annotation as? InfectionAnnotation {
            annotationView?.image = customPointAnnotation.image
        }

        return annotationView
    }
}

private extension QuarantineMapViewController {
    func addAnnotations() {
        Infections.allCases.forEach { infection in
            let annotation = InfectionAnnotation(count: infection.infectionsCount)
            annotation.coordinate = infection.location.coordinate
            map.addAnnotation(annotation)
            
            let overlay = MKCircle(center: infection.location.coordinate, radius: infection.radius)
            map.addOverlay(overlay)
        }
        
        map.showAnnotations(map.annotations, animated: false)
    }
}

final class InfectionAnnotation: MKPointAnnotation {
    let image: UIImage?
    
    init(count: Int) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        label.textAlignment = .center
        label.text = "\(count)"
        label.font = R.font.baloo2Bold(size: 24.0)
        label.textColor = R.color.fontPrimary()
        
        self.image = UIImage.imageWithLabel(label: label)
    }
}
