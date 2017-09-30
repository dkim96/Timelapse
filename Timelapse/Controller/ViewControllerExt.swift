//
//  ViewControllerExt.swift
//  Timelapse
//
//  Created by Daniel Kim on 9/28/17.
//  Copyright © 2017 dk. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

extension ViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //if(locationRepeat){
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
       // print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationRepeat = false
        myLatitude = locValue.latitude
        myLongitude = locValue.longitude
        xaddphotoController.getCoordinates(lat: locValue.latitude, lon: locValue.longitude)
        xaddphotoController.imgLat = myLatitude
        xaddphotoController.imgLon = myLongitude
    }
    
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    func handleAddPhoto() {
        let addPhotoController = AddPhotoController()
        let navController = UINavigationController(rootViewController: addPhotoController)
        present(navController, animated: true, completion: nil)
    }
    
    
    func setupNavBar(){
        // NAVBAR SETUP
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: 180))
        self.view.addSubview(navBar);
        
        let navItem = UINavigationItem(title: "Timelapse");
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let logo = UIImage(named: "tl")
        let imageView = UIImageView(image:logo)
        navItem.titleView = imageView
        navBar.layer.zPosition = 3
        
        let searchx = UIImage(named: "search")
        let imageView2 = UIImageView(image:searchx)
        let doneItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "search"), style: .plain, target: nil, action: "selector")
        doneItem.tintColor = UIColor.black
        navItem.rightBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        //print("?")
        if(gestureRecognizer.state == UIGestureRecognizerState.began) //YASSSS
        {
            var annotationView:MKPinAnnotationView!
            var touchPoint = gestureRecognizer.location(in: self.mapView)
            var newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            
            var pointAnnoation:CustomPointAnnotation!
            pointAnnoation = CustomPointAnnotation()
            pointAnnoation.pinCustomImageName = "pin"
            pointAnnoation.coordinate = newCoordinate
            pointAnnoation.customUIImage = UIImage(named: "pin")
            annotationView = MKPinAnnotationView(annotation: pointAnnoation, reuseIdentifier: "pin")
            self.mapView.addAnnotation(annotationView.annotation!)
            //zoomToFitMapAnnotations(aMapView: mapView)
        }
    }
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        let reuseIdentifier = "pin"
        
        var v = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if v == nil {
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            v!.canShowCallout = false // title subtitle show
        }
        else {
            v!.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! CustomPointAnnotation
        v!.image = customPointAnnotation.customUIImage
        print("VIMAGE: \(v!.image)")
        
        if annotation is MKUserLocation{
            return nil
        }
        return v
    }
    
    func setupAddPhoto() {
        //need x, y, width, height constraints
        addPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 140).isActive = true
        addPhoto.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        //addPhoto.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //addPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func zoomToFitMapAnnotations(aMapView: MKMapView) {
        if aMapView.annotations.count == 0 {
            return
        }
        var topLeftCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        topLeftCoord.latitude = -90
        topLeftCoord.longitude = 180
        var bottomRightCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        bottomRightCoord.latitude = 90
        bottomRightCoord.longitude = -180
        for annotation: MKAnnotation in mapView.annotations as! [MKAnnotation]{
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude)
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude)
        }
        
        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        
        var span1 = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 3
        var span2 = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 3
        print("\(span1) and \(span2)")
        if(span1 <= 180 && span2 <= 180)
        {
            region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 3
            region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 3
        }
        else{
            region.span.latitudeDelta = 180
            region.span.longitudeDelta = 180
        }
        region = aMapView.regionThatFits(region)
        mapView.setRegion(region, animated: true)
    }
    
}
