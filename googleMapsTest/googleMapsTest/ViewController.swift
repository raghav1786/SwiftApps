//
//  ViewController.swift
//  googleMapsTest
//
//  Created by RAGHAV SHARMA on 27/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController,GMSMapViewDelegate {
    @IBOutlet var mapView : GMSMapView?
    let states = [
      
        State(name: "Sydney", long: -33.86, lat: 151.20, snipet: "Australia"),
        State(name: "Melbourne", long: -37.81, lat: 144.96, snipet: "Australia")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView?.delegate = self
        let posbtn: UIButton = .systemButton(with: .add, target: self, action: nil)
        posbtn.frame = CGRect(x: self.view.frame.maxX - 50, y:self.view.frame.maxY - 500, width: 48, height: 48)
        let btn: UIButton = .systemButton(with: .remove, target: self, action: nil)
        btn.frame = CGRect(x: self.view.frame.maxX - 50, y:self.view.frame.maxY - 470, width: 48, height: 48)

        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true

        mapView?.padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
        self.mapView?.addSubview(posbtn)
        self.mapView?.addSubview(btn)
        let markerImage = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        let markerView = UIImageView(image: markerImage)
        let camera = GMSCameraPosition.camera(withLatitude:-33.86, longitude: 151.20, zoom: 6.0)
        mapView?.camera = camera
        mapView?.animate(to: camera)
        mapView?.settings.compassButton = true
      for state in states {
        
          let state_marker = GMSMarker()
          state_marker.position = CLLocationCoordinate2D(latitude: state.long, longitude: state.lat)
        state_marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.2)
          state_marker.snippet = "Hey, this is \(state.name)"
     //   state_marker.iconView = markerView
        state_marker.icon = self.imageWithImage(image: UIImage(named: "home")!, scaledToSize: CGSize(width: 30.0, height: 30.0))
        state_marker.iconView?.backgroundColor = .white
          state_marker.map = mapView
        
      }
        
        
  }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        newImage.withTintColor(.blue)
        return newImage
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {

        guard let lat = mapView.myLocation?.coordinate.latitude,
            let lng = mapView.myLocation?.coordinate.longitude else { return false }

        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 9.0)
        mapView.animate(to: camera)

        return true

    }
}


struct State {
    let name: String
    let long: CLLocationDegrees
    let lat: CLLocationDegrees
    let snipet : String
}
