
//  mapsViewController.swift
//  Tasks
//
//  Created by  on 4/8/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class mapsViewController: UIViewController, CLLocationManagerDelegate {
    var manager = CLLocationManager()
    var userLoation:CLLocation?
    
    @IBOutlet weak var mapType: UISegmentedControl!
    
    @IBOutlet weak var searchFor: UITextField!
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLoation = locations[0]
        self.showLocation()
        
    }
    func showLocation(){
        let lon = userLoation?.coordinate.longitude
        let lat = userLoation?.coordinate.latitude
        let coord = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: coord, span: span)
        self.map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coord
        annotation.title = "My Location"
        annotation.subtitle = "Long: \(lon!) Lat: \(lat!)"
        self.map.addAnnotation(annotation)
    }
    
    @IBAction func changeMap(_ sender: Any) {
        switch self.mapType!.selectedSegmentIndex {
        case 0:
            map.mapType = .standard
        case 1:
            map.mapType = .hybrid
        default:
            map.mapType = .satellite
        }
    }
    
    
    @IBAction func search(_ sender: Any) {
        let annote = self.map.annotations
        self.map.removeAnnotations(annote)
        let request = MKLocalSearch.Request()
        if let x = self.searchFor.text{
            request.naturalLanguageQuery = x
        }
        request.region = self.map.region
        request.resultTypes = .pointOfInterest
        var local = MKLocalSearch(request: request)
        local.start{(response, error) in
            if error != nil{
                print("There was an error searching for the palce with: \(error!.localizedDescription)")
            }
            var matchingItems = response?.mapItems
            for i in 1...matchingItems!.count-1{
                var annot = MKPointAnnotation()
                annot.coordinate = matchingItems![i].placemark.coordinate
                annot.title = matchingItems![i].placemark.name
                self.map.addAnnotation(annot)
            }
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
