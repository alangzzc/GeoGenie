//
//  MapVC.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/30/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var countryMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latlng      = (countryDictionary["latlng"]! as? [Double])!
        let lat         = latlng[0]
        let lng         = latlng[1]
        let area        = countryDictionary["area"] as! Double
        let population  = countryDictionary["population"] as! Double
        var factorDelta = area / 10000
        
        if factorDelta > 100 {
            factorDelta = 100
        } else if factorDelta < 1 {
            factorDelta = 1
        }
        
        // Will use UK based location as default
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = lng
        let latDelta: CLLocationDegrees = factorDelta
        let lonDelta: CLLocationDegrees = factorDelta
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        countryMap.setRegion(region, animated: true)
        
        // below is how we add Annotations to our Map
        let annotation = MKPointAnnotation()
        
        annotation.title = countryDictionary["name"] as? String
        annotation.subtitle = "Area: \(area.withCommas()) Population: \(population.withCommas())"
        annotation.coordinate = location
        countryMap.addAnnotation(annotation)
        
        // How to recognize a long press in your app
        let uiLongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(gestureRecognizer:)))
        uiLongPressGestureRecognizer.minimumPressDuration = 2 // in seconds
        countryMap.addGestureRecognizer(uiLongPressGestureRecognizer)
        
    }
    
    @objc func longPress(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: self.countryMap)
        let coordinate = countryMap.convert(touchPoint, toCoordinateFrom: self.countryMap)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "New place"
        annotation.subtitle = "Planning to go here"
        countryMap.addAnnotation(annotation)
    }
}
