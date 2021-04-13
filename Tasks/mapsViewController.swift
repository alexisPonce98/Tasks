
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
        let coord = CLLocationCoordinate2D(latitude: lon!, longitude: lat!)
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
