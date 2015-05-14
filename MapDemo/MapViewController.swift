//
//  MapViewController.swift
//  MapDemo
//
//  Created by Julian Tejera on 5/14/15.
//  Copyright (c) 2015 Julian Tejera. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView?.delegate = self
        }
    }
    
    var locationManager: CLLocationManager? {
        didSet {
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    var keyword: String? {
        didSet {
            self.title = keyword
        }
    }
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = CLLocationManager()
    }
    
    @IBAction func refresh(sender: UIBarButtonItem) {
        self.mapView.removeAnnotations(self.places)
        self.places.removeAll(keepCapacity: false)
        performSearchRequest(self.mapView.region)
    }
    
    
    func performSearchRequest(region: MKCoordinateRegion) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.keyword ?? "Restaurant"
        request.region = region
        let localSearch = MKLocalSearch(request: request)
        localSearch.startWithCompletionHandler { (response: MKLocalSearchResponse!, error: NSError!) -> Void in
            if let error = error {
                println(error.localizedDescription)
                
            } else if let mapItems = response?.mapItems as? [MKMapItem] {
                self.places = mapItems.filter({ $0.url != nil }).map { Place(mapItem: $0)}
                self.mapView.addAnnotations(self.places)
            }
        }
    }
    
    // MARK: Map View Delegate
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        var region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 20000, 20000)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = false
        performSearchRequest(mapView.region)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var pin = mapView.dequeueReusableAnnotationViewWithIdentifier("Pin") as? MKPinAnnotationView
        if pin == nil {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        
        pin?.annotation = annotation
        pin?.animatesDrop = true
        pin?.canShowCallout = true
        pin?.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIView

        return pin!
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        // Load images here
    }
    
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if let place = view.annotation as? Place {
            self.performSegueWithIdentifier("WebSegue", sender: place)
        }
    }
    
    // MARK: Location Manager Delegate
    

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse || status == CLAuthorizationStatus.AuthorizedAlways {
            self.mapView.showsUserLocation = true
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WebSegue" {
            if let controller = segue.destinationViewController as? WebViewController, place = sender as? Place, url = place.mapItem.url {
                controller.title = place.title
                controller.url = url
            }
        }
    }
}
