//
//  MapView.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var annotations : [MKPointAnnotation]
    @Binding var selectedPlace : MKPointAnnotation?
    @Binding var showingPlaceDetails : Bool

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if annotations.count != view.annotations.count {
            view.removeAnnotation(view.annotations as! MKAnnotation)
            view.addAnnotation(annotations as! MKAnnotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator : NSObject, MKMapViewDelegate {
        var parent : MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView , viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "PlaceMarker"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if(annotationView == nil ){
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            }else{
                annotationView?.annotation = annotation
            }
             return annotationView
        }
    }

}
