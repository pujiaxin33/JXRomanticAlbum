//
//  RALocationViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/19.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import MapKit

class RALocationViewController: UIViewController {
    var mapView: MKMapView!
    var location: CLLocation?
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "照片位置"

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        mapView = MKMapView()
        mapView.delegate = self
        if #available(iOS 11.0, *) {
            mapView.register(MKPinAnnotationView.classForCoder(), forAnnotationViewWithReuseIdentifier: "annotation")
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }

        geocoder.reverseGeocodeLocation(location!) { (placeMarks, error) in
            if error == nil {
                let place = placeMarks?.first

                let point = MKPointAnnotation()
                point.coordinate = self.location!.coordinate
                point.title = (place?.addressDictionary?["FormattedAddressLines"] as? [String])?.first
                self.mapView.addAnnotation(point)
                self.mapView.selectAnnotation(point, animated: true)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        mapView.setRegion(MKCoordinateRegion(center: location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
    }


}


extension RALocationViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
////        if view == nil {
////            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
////        }
//        view.canShowCallout = true
//        return view
//    }
}
