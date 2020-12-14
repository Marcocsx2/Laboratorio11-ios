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
    
    var contActualizaciones: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        ubicacion.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            ubicacion.startUpdatingLocation()
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: {(timer) in
                if let coord = self.ubicacion.location?.coordinate {
                    let pin = MKPointAnnotation()
                    pin.coordinate = coord
                    let randomLat = (Double(arc4random_uniform(200))-100.0)/5000.0
                    let randomLon = (Double(arc4random_uniform(200))-100.0)/5000.0
                    pin.coordinate.longitude += randomLon
                    pin.coordinate.latitude += randomLat
                    self.mapView.addAnnotation(pin)
                }
            })
        } else {
            ubicacion.requestWhenInUseAuthorization()
        }
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (contActualizaciones < 1){
            let region = MKCoordinateRegion(center: ubicacion.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            contActualizaciones += 1
            print("ubicacion actualizada")
        } else {
            ubicacion.stopUpdatingLocation()
        }
        
    }
    
    
    @IBAction func centrarTapped(_ sender: Any) {
        if let coord = ubicacion.location?.coordinate{
            let region = MKCoordinateRegion(center: coord, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            contActualizaciones += 1
        }
    }
    

}

