//
//  Artwork.swift
//  PVHNext
//
//  Created by Jose on 4/31/20.
//  Copyright © 2020 PVH. All rights reserved.
//

import Foundation
import MapKit
//The storage of MkMapView object information
class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate

    super.init()
  }
//Returns the selected String
  var subtitle: String? {
    return locationName
  }
}
