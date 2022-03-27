//
//  ViewController.swift
//  Get Location
//
//  Created by Zhehui Yang on 3/18/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var lblLatitude: UILabel!
    
    @IBOutlet weak var lblLongitude: UILabel!
    
    
    @IBOutlet weak var lblAddress: UILabel!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // when anything happen, the location manager will handle
        locationManager.delegate = self
                 

        locationManager.requestWhenInUseAuthorization()//ask user for the permission

                 

        //47.62475249322104, -122.33490231922748 location iphone location

        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }


    @IBAction func getLocation(_ sender: Any) {
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //if I fail to get the location
        print("Error in getting location \(error.localizedDescription)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //where the location is
             
            // give an array of location
            guard let location = locations.last else{return}

             

            let lat = location.coordinate.latitude

            let lng = location.coordinate.longitude

             

            print(lat)

            print(lng)

            lblLatitude.text = "Latitude : \(lat)"

            lblLongitude.text = "Longitude :\(lng)"

            getAddress(location: location)

             

        }

    func startSignificationChange(){

        if CLLocationManager.significantLocationChangeMonitoringAvailable(){

            locationManager.startMonitoringSignificantLocationChanges()

            locationManager.startUpdatingLocation()



        }

    }
    func getAddress(location : CLLocation){//input is a location

        //take a location and decode it, and give the address
        let clGeocoder = CLGeocoder()
        //decode and return an array of places and error
        clGeocoder.reverseGeocodeLocation(location) { placeMarks, error in


           

           if error != nil {

              self.lblAddress.text = "Unable to get Address"

              return

           }


           guard let place = placeMarks?[0] else{return}



           var address = ""

           if place.name != nil {


               address += place.name! + ","

           }

          if place.locality != nil {

              address += place.locality! + ","

          }

          if place.subLocality != nil {

              address += place.subLocality! + ","

          }

          if place.postalCode != nil {

              address += place.postalCode! + ","

          }

          if place.country != nil {

              address += place.country! + ","

          }

          if place.region != nil {

              print("Region : \(String(describing: place.region))")

          }

          print(address)

          self.lblAddress.text = address

        }

    }
}
    
    

