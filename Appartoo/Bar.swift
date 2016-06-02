//
//  Bar.swift
//  Appartoo
//
//  Created by chris 78 on 01/06/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

import UIKit

class Bar
{
    // MARK: Properties
    
    var name: String
    var tag: String
    var address: String
    var photo: UIImage?
    var image_URL: String
    var latitude: Double
    var longitude: Double
    
    // MARK: Initialization
    
    init(name: String, tag: String, address: String, photo: UIImage?, image_URL: String, latitude: Double, longitude: Double)
    {
        self.name = name
        self.tag = tag
        self.address = address
        self.photo = photo
        self.image_URL = image_URL
        self.latitude = latitude
        self.longitude = longitude
    }
}
