//
//  ViewController.swift
//  Appartoo
//
//  Created by chris 78 on 30/05/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

import UIKit
import MapKit

let initialLocation = CLLocation(latitude: 48.860033826521, longitude: 2.3508920416641)
let regionRadius: CLLocationDistance = 1000

class ViewController: UIViewController, MKMapViewDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad()
    {
        var annotations = [MKAnnotation]()
        let locations = parseJSON()
        super.viewDidLoad()
        centerMapOnLocation(initialLocation)
        mapView.delegate = self
        for dictionary in locations! {
            let latitude = CLLocationDegrees(dictionary["latitude"] as! Double)
            let longitude = CLLocationDegrees(dictionary["longitude"] as! Double)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let name = dictionary["name"] as! String
            //let image_URL = dictionary["image_URL"] as! String
            let address = dictionary["address"] as! String
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(name)"
            annotation.subtitle = address
            annotations.append(annotation)
            mapView.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        let reuseIdentifier = "pin"
        var pin = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier) as? MKPinAnnotationView
        if pin == nil
        {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pin!.pinTintColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
            pin!.canShowCallout = true
            //pin!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else
        {
            pin!.annotation = annotation
        }
        return pin
    }
    
    func parseJSON() -> [[String: AnyObject]]?
    {
        if let asset = NSDataAsset(name: "Data", bundle: NSBundle.mainBundle())
        {
            var names = [String]()
            
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(asset.data, options: .AllowFragments)
                
                if let bars = json["bars"] as? [[String: AnyObject]]
                {
                    for bar in bars
                    {
                        if let name = bar["name"] as? String
                        {
                            names.append(name)
                        }
                    }
                    return bars
                }
            }
            catch
            {
                print("error serializing JSON: \(error)")
            }
        }
        return nil
    }
}