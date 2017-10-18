
import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    let overlayView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "overlay")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    var moreB: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "more"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    var followB: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "follow"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(changeSpanSub), for: .touchUpInside)
        return button
    }()
    
    let subMenuView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sub menu")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let imagesView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "images")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameField : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.text = "username"
        lb.textColor = UIColor.white
        lb.numberOfLines = 1
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        return lb
    }()
    
    let captionField : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.text = "caption"
        lb.textColor = UIColor.gray
        lb.numberOfLines = 1
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        return lb
    }()
    
    let postField : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.text = "999"
        lb.textColor = UIColor.white
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 18)
        return lb
    }()
    
    let npostField : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.text = "Posts"
        lb.textColor = UIColor.gray
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 12)
        return lb
    }()
    
    let followerField : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.text = "999"
        lb.textColor = UIColor.white
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 18)
        return lb
    }()
    
    let nfollowerField : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.text = "Followers"
        lb.textColor = UIColor.gray
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 12)
        return lb
    }()
    
    let followingField : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.text = "999"
        lb.textColor = UIColor.white
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 18)
        return lb
    }()
    
    let nfollowingField : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.text = "Following"
        lb.textColor = UIColor.gray
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 12)
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        
        
        
        view.backgroundColor = UIColor.white
        view.addSubview(backgroundView)
        view.addSubview(overlayView)
        view.addSubview(nameField)
        view.addSubview(captionField)
        view.addSubview(moreB)
        view.addSubview(followB)
        view.addSubview(subMenuView)
        view.addSubview(avatarView)
        view.addSubview(imagesView)
        view.addSubview(postField)
        view.addSubview(npostField)
        view.addSubview(followerField)
        view.addSubview(followingField)
        view.addSubview(nfollowerField)
        view.addSubview(nfollowingField)
        
        setupOverlay()
    }
    
    func setupOverlay() {
        overlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        overlayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        moreB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        moreB.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 35).isActive = true
        
        followB.rightAnchor.constraint(equalTo: view.rightAnchor, constant : -15).isActive = true
        followB.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 35).isActive = true
        
        subMenuView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subMenuView.topAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: 15).isActive = true
        
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 30).isActive = true
        
        imagesView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imagesView.topAnchor.constraint(equalTo: subMenuView.bottomAnchor, constant: 15).isActive = true
        
        NSLayoutConstraint.activate([
            nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameField.topAnchor.constraint(equalTo: avatarView.bottomAnchor),
            nameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            nameField.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            captionField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captionField.topAnchor.constraint(equalTo: nameField.bottomAnchor),
            captionField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            captionField.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            postField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            postField.topAnchor.constraint(equalTo: captionField.bottomAnchor, constant: 10),
            postField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            postField.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            npostField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            npostField.topAnchor.constraint(equalTo: postField.bottomAnchor, constant: 0),
            npostField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            npostField.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            followerField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            followerField.topAnchor.constraint(equalTo: captionField.bottomAnchor, constant: 10),
            followerField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            followerField.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            nfollowerField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nfollowerField.topAnchor.constraint(equalTo: followerField.bottomAnchor, constant: 0),
            nfollowerField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            nfollowerField.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            followingField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 110),
            followingField.topAnchor.constraint(equalTo: captionField.bottomAnchor, constant: 10),
            followingField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            followingField.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            nfollowingField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 110),
            nfollowingField.topAnchor.constraint(equalTo: followingField.bottomAnchor, constant: 0),
            nfollowingField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            nfollowingField.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}








