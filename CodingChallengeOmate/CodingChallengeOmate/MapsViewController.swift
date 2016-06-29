//
//  MapsViewController.swift
//  CodingChallengeOmate
//
//  Created by manpreet sandhu on 29/06/2016.
//  Copyright © 2016 ManpreetSandhu. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {

    // recieves longitude from countryViewController
    var _longitude = String()
    
    // recieves latitude from countryViewController
    var _latitude = String()
    
    // recieve title to annotation from coutryViewController
    var _titleToAnnotation = String()
    
    // recieves subtitle to annotation from countryViewController
    var _subTitleToAnnotation = String()
    
    
    // outlet to MapKit
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // sets location, span, region and annotation to a map
        Map.addAnnotation(createAnnotation())
        
    }
    
    func createAnnotation() -> MKPointAnnotation
    {
        // set location for the latitude and longitude provided by CountryViewController
        let location = CLLocationCoordinate2DMake(Double(_latitude)!, Double(_longitude)!)
        
        // to set the zoom level of the map when it will load
        let span = MKCoordinateSpan(latitudeDelta: 18, longitudeDelta: 18)
        
        // sets region using the location and span so that map focus the particular region when gets loaded
        let region = MKCoordinateRegion(center: location, span: span)
        
        // sets region to the mapkit
        Map.setRegion(region, animated: true)
        
        // annotation object to pin the region
        let annotation = MKPointAnnotation()
        
        // sets the title of the pin annotation
        annotation.title = _titleToAnnotation
        
        // sets subtitle of the annotation
        annotation.subtitle = _subTitleToAnnotation
        
        // defines location where pin has to set
        annotation.coordinate = location
        
        // return annotation so that it can be added to the map
        return annotation
    }
    
}
