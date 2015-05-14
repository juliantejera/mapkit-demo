//
//  File.swift
//  MapDemo
//
//  Created by Julian Tejera on 5/14/15.
//  Copyright (c) 2015 Julian Tejera. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation {
    var mapItem: MKMapItem
    var title: String? {
        return mapItem.name
    }
    var subtitle: String? {
        return mapItem.url?.absoluteString
    }
    var coordinate: CLLocationCoordinate2D {
        get {
            return mapItem.placemark.coordinate
        }
    }
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
        super.init()
    }
}