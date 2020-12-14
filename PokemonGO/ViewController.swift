//
//  ViewController.swift
//  PokemonGO
//
//  Created by Marco Vizcarra on 12/10/20.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var ubicacion = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        ubicacion.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            ubicacion.startUpdatingLocation()
        } else {
            ubicacion.requestWhenInUseAuthorization()
        }
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: ubicacion.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        print("ubicacion actualizada")
    }


}

