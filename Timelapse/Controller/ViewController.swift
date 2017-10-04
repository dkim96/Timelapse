
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
    var counter = 0
    
    var spanMultiplierAdd: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("-", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(changeSpanAdd), for: .touchUpInside)
        return button
    }()
    
    var spanMultiplierSub: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("+", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(changeSpanSub), for: .touchUpInside)
        return button
    }()
    
    let addPhoto: UIButton = {
        let playButton  = UIButton(type: .custom)
        playButton.setImage(UIImage(named: "Plus"), for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        playButton.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return playButton
    }()
    
    let myStoryandGlobal: UIButton = {
        let playButton  = UIButton(type: .custom)
        playButton.setImage(UIImage(named: "mystory.global"), for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        //playButton.addTarget(self, action: nil, for: .touchUpInside)
        return playButton
    }()
    
    let longPressView: SpringButton = {
        let playButton  = SpringButton(type: .custom)
        playButton.setImage(UIImage(named: "longpresstemp"), for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        //playButton.ishidden = false
        //playButton.addTarget(self, action: nil, for: .touchUpInside)
        return playButton
    }()
    
    var multiPin1: SpringButton = {
        let playButton  = SpringButton(type: .custom)
        //playButton.setImage(UIImage(named: "longpresstemp"), for: .normal)
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        //playButton.addTarget(self, action: nil, for: .touchUpInside)
        return playButton
    }()
    var multiPin2: SpringButton = {
        let playButton  = SpringButton(type: .custom)
        //playButton.setImage(UIImage(named: "longpresstemp"), for: .normal)
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        //playButton.addTarget(self, action: nil, for: .touchUpInside)
        return playButton
    }()
    var multiPin3: SpringButton = {
        let playButton  = SpringButton(type: .custom)
        //playButton.setImage(UIImage(named: "longpresstemp"), for: .normal)
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        //playButton.addTarget(self, action: nil, for: .touchUpInside)
        return playButton
    }()
    var multiPin4: SpringButton = {
        let playButton  = SpringButton(type: .custom)
        //playButton.setImage(UIImage(named: "longpresstemp"), for: .normal)
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        //playButton.addTarget(self, action: nil, for: .touchUpInside)
        return playButton
    }()
    var multiPin5: SpringButton = {
        let playButton  = SpringButton(type: .custom)
        //playButton.setImage(UIImage(named: "longpresstemp"), for: .normal)
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        //playButton.addTarget(self, action: nil, for: .touchUpInside)
        return playButton
    }()
    var multiPin6: SpringButton = {
        let playButton  = SpringButton(type: .custom)
        //playButton.setImage(UIImage(named: "longpresstemp"), for: .normal)
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.contentMode = .scaleAspectFill
        //playButton.addTarget(self, action: nil, for: .touchUpInside)
        return playButton
    }()
    
    //let uilpgr: UILongPressGestureRecognizer = {
    //   let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(action))
    // uilpgr.minimumPressDuration = 0.5
    //return uilpgr
    // }()
    
    var bubbles = [Bubble]()
    var images = [UIImage]()
    var groups = [[Int]]()
    var distances = [[Double]]()
    
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
        uilpgr.minimumPressDuration = 0.2
        mapView.addGestureRecognizer(uilpgr)
        mapView.delegate = self
        
        setupNavBar() // sets up top navigation bar
        
        //adds the + button
        view.addSubview(addPhoto)
        setupAddPhoto()
        
        view.addSubview(myStoryandGlobal)
        setupMyStoryandGlobal()
        
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
        isColliding(curSpan: mapView.region.span.latitudeDelta)
        view.addSubview(spanMultiplierAdd)
        view.addSubview(spanMultiplierSub)
        setupSpanMult()
    }
    
    func fetchUser() {
        FIRDatabase.database().reference().child("bubbles").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let bubble = Bubble(dictionary: dictionary)
                bubble.id = snapshot.key
                self.bubbles.append(bubble)
                
                let messagesRef = FIRDatabase.database().reference().child("users").child(bubble.fromId!).child("profileImageUrl")
                messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    guard let photoLink = snapshot.value else {return}
                    self.displayBubbles(bubble: bubble, url: photoLink as! String)
                    
                    
                }, withCancel: nil)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    //self.tableView.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    func displayBubbles(bubble : Bubble, url : String){
        // access img and loc and display as pin
        
        //var image: UIImage!
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        let image: UIImage = UIImage(data: data!)!
        images.append(image)
        let watermarkImage = UIImage.roundedRectImageFromImage(image: image, imageSize: CGSize(width: 50, height: 50), cornerRadius: CGFloat(20))
        let backgroundImage = UIImage(named: "bluepin")

        UIGraphicsBeginImageContextWithOptions(backgroundImage!.size, false, 0.0)
        backgroundImage!.draw(in: CGRect(x: 0.0, y: 0.0, width: 58, height: 58))
        watermarkImage.draw(in: CGRect(x: 3.8, y: 3.6, width: 49, height: 49))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        var annotationView:MKPinAnnotationView!
        //let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(action))
        //uilpgr.minimumPressDuration = 0.5
        //var touchPoint = gestureRecognizer.location(in: self.mapView)
        var newCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(bubble.latitude!, bubble.longitude!)
        var pointAnnoation:CustomPointAnnotation!
        pointAnnoation = CustomPointAnnotation()
        pointAnnoation.title = bubble.id
        pointAnnoation.subtitle = String(counter)
        counter = counter + 1
        pointAnnoation.pinCustomImageName = "pin"
        pointAnnoation.coordinate = newCoordinate
        pointAnnoation.customUIImage = result
        annotationView = MKPinAnnotationView(annotation: pointAnnoation, reuseIdentifier: "pin")
        //annotationView.addGestureRecognizer(uilpgr)
        self.mapView.addAnnotation(annotationView.annotation!)
    }
    
    func isColliding(curSpan: Double) {
        groups.removeAll()
        if(bubbles.count < 2) {return}
        for i in 0...bubbles.count-2 {
            for j in i+1...bubbles.count-1{
                let long = pow(bubbles[i].longitude! - bubbles[j].longitude!, 2)
                let lat = pow(bubbles[i].latitude! - bubbles[j].latitude!, 2)
                let distance = sqrt(long + lat)
                if(distance < curSpan/20){ // curSpan/10 is touching distance
                    // intersection found
                    //print(i, j, "intersect!")
                    sortGroups(i: i, j: j)
                    
                }
            }
        }
    }
    
    func sortGroups(i: Int, j: Int) // given two bubbles, assign them to a pair or make new
    {
        if(groups.count == 0){
            groups.append([i,j])
            let avgLong = (bubbles[i].longitude! + bubbles[j].longitude!)/2
            let avgLat = (bubbles[i].latitude! + bubbles[j].latitude!)/2
            distances.append([avgLong,avgLat])
            return
        }
        for a in 0...groups.count-1{
            let output = Array(Set([i,j]).intersection(Set(groups[a]))) //find common elements
            //print(groups[a])
            if(output.count == 0){// no common elements
                if(a == groups.count-1)
                {
                groups.append([i,j])
                let avgLong = (bubbles[i].longitude! + bubbles[j].longitude!)/2
                let avgLat = (bubbles[i].latitude! + bubbles[j].latitude!)/2
                distances.append([avgLong,avgLat])
                return
                }
            }
            if(output.count == 1){// search for other
                if(output[0] == i){
                    groups[a].append(j)
                }
                else{
                    groups[a].append(i)
                }
                return
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}

