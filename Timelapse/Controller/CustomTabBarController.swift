import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        // Set up the Tab Bar Controller to have two tabs
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [vc1, vc2, vc3, vc4, vc5]
        // Make the Tab Bar Controller the root view controller
        window?.rootViewController = tabBarController
        tabBarController.selectedIndex = 2 // Chooses middle tab
        /////
 */
        
        
        let trendViewController = TrendViewController()
        let navigationController = UINavigationController(rootViewController: trendViewController)
        //navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "stats")
        
        let searchViewController = SearchViewController()
        let secondNavigationController = UINavigationController(rootViewController: searchViewController)
        //secondNavigationController.title = "Requests"
        secondNavigationController.tabBarItem.image = UIImage(named: "search")
        
        let viewController = ViewController()
        let thirdNavigationController = UINavigationController(rootViewController: viewController)
        //messengerNavigationController.title = "Messenger"
        thirdNavigationController.tabBarItem.image = UIImage(named: "world")
        
        let notifviewController = NotifViewController()
        let fourthNavigationController = UINavigationController(rootViewController: notifviewController)
        //messengerNavigationController.title = "Messenger"
        fourthNavigationController.tabBarItem.image = UIImage(named: "activity")
        
        let profviewController = ProfileViewController()
        let fifthNavigationController = UINavigationController(rootViewController: profviewController)
        //messengerNavigationController.title = "Messenger"
        fifthNavigationController.tabBarItem.image = UIImage(named: "profile")
        
        viewControllers = [navigationController, secondNavigationController, thirdNavigationController, fourthNavigationController, fifthNavigationController]
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        //topBorder.backgroundColor = UIColor.rgb(229, green: 231, blue: 235).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        self.selectedIndex = 2 // Chooses middle tab
        //self.selectedIndex
    }
}

