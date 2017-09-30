
import UIKit
import Firebase
import MapKit
import CoreLocation



class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let xaddphotoController = AddPhotoController()
    var myLatitude = Double()
    var myLongitude = Double()
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    var locationRepeat = true
    
    let addPhoto: UIButton = {
        let playButton  = UIButton(type: .custom)
        playButton.setImage(UIImage(named: "Plus"), for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        playButton.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return playButton
    }()
    var bubbles = [Bubble]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height - 90
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = false
        
        let location = CLLocationCoordinate2D(latitude: 34.0693641733695, longitude: -118.454776341206)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        let region = MKCoordinateRegion (center:  location,span: span)
        
        mapView.setRegion(region, animated: true)
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        view.addSubview(mapView)
        self.view.bringSubview(toFront: addPhoto);
        addPhoto.layer.zPosition = 2
        mapView.layer.zPosition = 1
        
        // Handling no user
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        // UILPGR- long press for action
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(action))
        uilpgr.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(uilpgr)
        mapView.delegate = self

        setupNavBar() // sets up top navigation bar
        
        //adds the + button
        view.addSubview(addPhoto)
        setupAddPhoto()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        fetchUser()
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotationView: MKAnnotationView) {
        print("clicked annot")
        mapView.deselectAnnotation(annotationView.annotation, animated: false)
        print(annotationView.annotation?.title)
        
        let photoviewController = PhotoViewController()
        photoviewController.photoId = ((annotationView.annotation?.title)!)!
        present(photoviewController, animated: true, completion: nil)
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect annotationView: MKAnnotationView) {
        print("deselected annot")
        
    }
    
    func displayBubbles(bubble : Bubble, url : String){
        // access img and loc and display as pin
        
        //var image: UIImage!
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        let image: UIImage = UIImage(data: data!)!
        
        let backgroundImage = UIImage(named: "bluepin")
        let watermarkImage = UIImage.roundedRectImageFromImage(image: image, imageSize: CGSize(width: 50, height: 50), cornerRadius: CGFloat(20))
        UIGraphicsBeginImageContextWithOptions(backgroundImage!.size, false, 0.0)
        backgroundImage!.draw(in: CGRect(x: 0.0, y: 0.0, width: 58, height: 58))
        watermarkImage.draw(in: CGRect(x: 3.8, y: 3.6, width: 49, height: 49))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        var annotationView:MKPinAnnotationView!
        //var touchPoint = gestureRecognizer.location(in: self.mapView)
        var newCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(bubble.latitude!, bubble.longitude!)
        var pointAnnoation:CustomPointAnnotation!
        pointAnnoation = CustomPointAnnotation()
        pointAnnoation.title = bubble.id
        pointAnnoation.pinCustomImageName = "pin"
        pointAnnoation.coordinate = newCoordinate
        pointAnnoation.customUIImage = result
        annotationView = MKPinAnnotationView(annotation: pointAnnoation, reuseIdentifier: "pin")
        self.mapView.addAnnotation(annotationView.annotation!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func fetchUser() {
        FIRDatabase.database().reference().child("bubbles").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let bubble = Bubble(dictionary: dictionary)
                bubble.id = snapshot.key
                self.bubbles.append(bubble)
                print(bubble.fromId)
                
                let messagesRef = FIRDatabase.database().reference().child("users").child(bubble.fromId!).child("profileImageUrl")
                messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    guard let photoLink = snapshot.value else {return}
                    print(photoLink)
                    self.displayBubbles(bubble: bubble, url: photoLink as! String)
                    
                    
                    
                }, withCancel: nil)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    //self.tableView.reloadData()
                })
                print(self.bubbles)
            }
            
        }, withCancel: nil)
    }
    
}

