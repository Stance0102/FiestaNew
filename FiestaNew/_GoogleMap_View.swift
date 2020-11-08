//
//  GoogleMap_View.swift
//  FiestaNew
//
//  Created by 李慶毅 on 2020/6/11.
//  Copyright © 2020 Li Ching Yi. All rights reserved.
//

import SwiftUI
import UIKit
import GoogleMaps

struct GoogleMap_View: UIViewRepresentable {
    @ObservedObject var locationManager = LocationManager()
    private let zoom: Float = 15.0
    
    // 2
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }
    
    // 3
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        //        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        //        mapView.camera = camera
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
    }
}
