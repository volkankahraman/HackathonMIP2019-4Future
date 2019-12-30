//
//  MapViewController.swift
//  Hackathon
//
//  Created by Alperen Aysel on 28.12.2019.
//  Copyright © 2019 Alperen Aysel. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var currComp: Company?

    @IBOutlet weak var ourMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let la = currComp!.latitude
        let lo = currComp!.longitude
        print(la, lo)
        let initialLocation = CLLocationCoordinate2D(latitude: lo, longitude: la)
//        centerMapOnLocation(location: initialLocation)
        let regionRadius: CLLocationDistance = 1000.0
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        ourMap.setRegion(region, animated: true)
        ourMap.delegate = self

    }
    

    

}
extension MapViewController: MKMapViewDelegate {
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("rendiring")
    }
}
