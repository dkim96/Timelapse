
import UIKit
import Firebase

class PhotoViewController: UIViewController, UINavigationControllerDelegate {
    
    //give the bubble
    var photoId = String()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "Home")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: 180))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Photo");
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))
        //let logo = UIImage(named: "tl")
        //let imageView = UIImageView(image:logo)
        //navItem.titleView = imageView
        navBar.layer.zPosition = 3
        navBar.setItems([navItem], animated: false);
        
        
        print(photoId)
        
        fetchUser()
        
        view.addSubview(profileImageView)
        
        setupProfileImageView()
    }
    
    
    func setupProfileImageView() {
        //need x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func fetchUser() {
        
        let messagesRef = FIRDatabase.database().reference().child("bubbles").child(photoId)
       messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let bubble = Bubble(dictionary: dictionary)
                let url = URL(string: bubble.imageUrl!)
                let data = try? Data(contentsOf: url!)
                let image: UIImage = UIImage(data: data!)!
                self.profileImageView.image = image
            
            }
            
        }, withCancel: nil)
        
    }
    
    
    
    //override var preferredStatusBarStyle : UIStatusBarStyle {
    //  return .Content
    //}
    
}









