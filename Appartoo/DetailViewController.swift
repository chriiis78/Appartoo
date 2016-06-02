//
//  DetailViewController.swift
//  Appartoo
//
//  Created by chris 78 on 02/06/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailMapView: MKMapView!
    
    var bar: Bar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let bar = bar
        {
            //navigationItem.title = bar.name
            var annotations = [MKAnnotation]()
            nameLabel.text = bar.name
            tagLabel.text = bar.tag
            addressLabel.text = bar.address
            photoImageView.image = load_image(bar.image_URL)
            let latitude = CLLocationDegrees(bar.latitude)
            let longitude = CLLocationDegrees(bar.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2.0, regionRadius * 2.0)
            detailMapView.setRegion(coordinateRegion, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = nameLabel.text
            annotation.subtitle = addressLabel.text
            annotations.append(annotation)
            detailMapView.addAnnotation(annotation)
        }
    }
    
    func load_image(urlString: String) -> UIImage?
    {
        if let url = NSURL(string: urlString)
        {
            if let data = NSData(contentsOfURL: url)
            {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

}
