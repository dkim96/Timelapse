//
//  NewMessageController.swift
//  gameofchats
//
//  Created by Brian Voong on 6/29/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UITableViewController {
    
    let cellId = "cellId"
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        setupNavBar()
        fetchUser()
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
    func setupNavBar(){
        // NAVBAR SETUP
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: 180))
        self.view.addSubview(navBar);
        
        let navItem = UINavigationItem(title: "Notifications");
        //navItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        //let logo = UIImage(named: "tl")
        //let imageView = UIImageView(image:logo)
        //navItem.titleView = imageView
        navBar.layer.zPosition = 3
        
        //let searchx = UIImage(named: "search")
        //let imageView2 = UIImageView(image:searchx)
        //let doneItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "search"), style: .plain, target: nil, action: "selector")
        //doneItem.tintColor = UIColor.black
        //navItem.rightBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //fetchUser()
    }
    
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                user.id = snapshot.key
                self.users.append(user)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
                //                user.name = dictionary["name"]
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
   // var messagesController: ViewController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Dismiss completed")
            let user = self.users[indexPath.row]
            let profileViewController = ProfileViewController()
            self.present(profileViewController, animated: true, completion: nil)
            //tableView.deselectRow(at: indexPath, animated: true)
            //self.messagesController?.showChatControllerForUser(user)
            
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
}








