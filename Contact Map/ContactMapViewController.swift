//
//  ContactMapViewController.swift
//  coronatrace-ios
//
//  Created by Lukasz Lech on 22/03/2020.
//  Copyright (c) 2020 Coronatrace. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol ContactMapViewControllerLogic: AnyObject {}

final class ContactMapViewController: UIViewController {
    // MARK: - ibOutlets
    @IBOutlet private weak var mapContainer: UIView!
    @IBOutlet private weak var map: MKMapView!
    
    // MARK: - Public Properties
    var interactor: ContactMapInteractorLogic?
    var router: ContactMapRouterType?
    
    // MARK: - Private Properties
    private var route1: MKPolyline?
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        
        let sourceLocation1 = CLLocationCoordinate2D(latitude: 51.0999499, longitude: 17.0225655)
        let destinationLocation1 = CLLocationCoordinate2D(latitude: 51.0989438, longitude: 17.0251453)
        addRoutes(from: sourceLocation1, to: destinationLocation1, isFirst: true)
        
        let sourceLocation2 = CLLocationCoordinate2D(latitude: 51.0977807, longitude: 17.02272)
        let destinationLocation2 = CLLocationCoordinate2D(latitude: 51.0989438, longitude: 17.0251453)
        addRoutes(from: sourceLocation2, to: destinationLocation2, isFirst: false)
        
        let overlay = MKCircle(center: destinationLocation2, radius: 30.0)
        map.addOverlay(overlay)
        
        map.setRegion(MKCoordinateRegion(center: destinationLocation1, latitudinalMeters: 500, longitudinalMeters: 500), animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.setHidesBackButton(true, animated: false)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mapContainer.layer.cornerRadius = 8.0
        map.layer.cornerRadius = 8.0
    }
}

extension ContactMapViewController: ContactMapViewControllerLogic {}
extension ContactMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.systemRed.withAlphaComponent(0.5)
            
            return renderer
        } else {
            let renderer = MKPolylineRenderer(overlay: overlay)
            if let overlay = overlay as? MKPolyline {
             renderer.strokeColor = route1 == overlay ? UIColor.systemGreen : UIColor.systemBlue
            } else {
             renderer.strokeColor = UIColor.systemBlue
            }
            renderer.lineWidth = 4.0
            
            return renderer
        }
    }
}

private extension ContactMapViewController {
    func addRoutes(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, isFirst: Bool) {
        let sourcePlacemark = MKPlacemark(coordinate: from, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: to, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { [weak self] (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            if isFirst {
                self?.route1 = route.polyline
            }
            self?.map.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
        }
    }
}
