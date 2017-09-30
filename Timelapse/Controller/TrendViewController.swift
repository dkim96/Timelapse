
import UIKit
import Firebase

class TrendViewController: UIViewController {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Home")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileImageView)

        setupProfileImageView()
    }

    
    func setupProfileImageView() {
        //need x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

}








