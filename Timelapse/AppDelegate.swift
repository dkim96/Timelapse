

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRAnalyticsConfiguration.sharedInstance().setAnalyticsCollectionEnabled(false)
        FIRApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        setupTabBar()
        window?.makeKeyAndVisible()
        //window?.rootViewController = UINavigationController(rootViewController: ViewController())
        
        return true
    }
    
    func setupTabBar(){ // Bottom Bar options/windows
        // Set up the first View Controller
        let vc1 = TrendViewController()
        //vc1.view.backgroundColor = UIColor.orange
        //vc1.tabBarItem.title = "Trending"
        vc1.tabBarItem.image = UIImage(named: "stats")
        
        // Set up the second View Controller
        let vc2 = SearchViewController()
        //vc2.view.backgroundColor = UIColor.red
        //vc2.tabBarItem.title = "Search"
        vc2.tabBarItem.image = UIImage(named: "search")
        
        let vc3 = ViewController()
        //vc3.view.backgroundColor = UIColor.blue
        //vc3.tabBarItem.title = "World"
        vc3.tabBarItem.image = UIImage(named: "world")
        
        // Set up the second View Controller
        let vc4 = NotifViewController()
        //vc4.view.backgroundColor = UIColor.yellow
        //vc4.tabBarItem.title = "Notif"
        vc4.tabBarItem.image = UIImage(named: "activity")
        
        let vc5 = ProfileViewController()
        //vc1.view.backgroundColor = UIColor.green
        //vc5.tabBarItem.title = "Profile"
        vc5.tabBarItem.image = UIImage(named: "profile")

        // Set up the Tab Bar Controller to have two tabs
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [vc1, vc2, vc3, vc4, vc5]
        // Make the Tab Bar Controller the root view controller
        window?.rootViewController = tabBarController
        tabBarController.selectedIndex = 2 // Chooses middle tab
        

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

