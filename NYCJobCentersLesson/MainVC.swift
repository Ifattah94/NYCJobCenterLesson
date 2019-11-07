//
//  MainVC.swift
//  NYCJobCentersLesson
//
//  Created by C4Q on 11/6/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainVC: UIViewController {
   //MARK: Properties
    
    private let locationManager = CLLocationManager()
    private let boroughs = ["Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island"]
    private let initialLocation = CLLocationCoordinate2D(latitude: 40.742054, longitude: -73.769417)
    
    //MARK: UI Objects
    lazy var mapView: MKMapView = {
       let mv = MKMapView()
        mv.showsUserLocation = true
        //mv.setCenter(self.initialLocation, animated: true)
        let region = MKCoordinateRegion(center: self.initialLocation, latitudinalMeters: 15000, longitudinalMeters: 15000)
        mv.setRegion(region, animated: true)
        mv.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mv)
        return mv
    }()
    
    lazy var boroughSegControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: self.boroughs)
        sc.apportionsSegmentWidthsByContent = true
        sc.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sc)
        return sc
    }()
    
    
   
    

    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupMapView()
        locationManager.delegate = self
        view.backgroundColor = .white

     
    }
    
    

    //MARK: Private methods
    

    private func requestLocationAndAuthorizeIfNeeded() {
           switch CLLocationManager.authorizationStatus() {
           case .authorizedWhenInUse, .authorizedAlways:
               locationManager.requestLocation()
           default:
               locationManager.requestWhenInUseAuthorization()
           }
       }
    
    //MARK: constraint functions
    
    
    private func setupSegmentedControl() {
        NSLayoutConstraint.activate([self.boroughSegControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        self.boroughSegControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.boroughSegControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    self.boroughSegControl.heightAnchor.constraint(equalToConstant: 55)])
    }
    private func setupMapView() {
        NSLayoutConstraint.activate([mapView.topAnchor.constraint(equalTo: boroughSegControl.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    

}


//MARK: CLLocationManagerDelegate
extension MainVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("New locations \(locations)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occurred: \(error)")
    }
 
}
