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
    
    @objc func handleLogout() {
        
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
        let doneItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "search"), style: .plain, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector))
        doneItem.tintColor = UIColor.black
        navItem.rightBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
    }
    

    
    func setupAddPhoto() {
        //need x, y, width, height constraints
        addPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 140).isActive = true
        addPhoto.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        //addPhoto.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //addPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupSpanMult(){
        spanMultiplierAdd.centerXAnchor.constraint(equalTo: addPhoto.centerXAnchor).isActive = true
        spanMultiplierAdd.bottomAnchor.constraint(equalTo: addPhoto.topAnchor, constant: -10).isActive = true
        spanMultiplierAdd.widthAnchor.constraint(equalToConstant: 40).isActive = true
        spanMultiplierAdd.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        spanMultiplierSub.centerXAnchor.constraint(equalTo: addPhoto.centerXAnchor).isActive = true
        spanMultiplierSub.bottomAnchor.constraint(equalTo: spanMultiplierAdd.topAnchor, constant: -10).isActive = true
        spanMultiplierSub.widthAnchor.constraint(equalToConstant: 40).isActive = true
        spanMultiplierSub.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        spanMultiplierAdd.layer.zPosition = 4
        spanMultiplierSub.layer.zPosition = 4
    }
    
    func setupMyStoryandGlobal()
    {
        myStoryandGlobal.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myStoryandGlobal.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        myStoryandGlobal.layer.zPosition = 5
        //myStoryandGlobal.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //myStoryandGlobal.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
}
