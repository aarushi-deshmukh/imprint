import UIKit

class Main: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewControllers = self.viewControllers {
            viewControllers[0].tabBarItem.title = "Explore"
            viewControllers[0].tabBarItem.image = UIImage(systemName: "map")
            
            viewControllers[1].tabBarItem.title = "Discover"
            viewControllers[1].tabBarItem.image = UIImage(systemName: "magnifyingglass")
            
            viewControllers[2].tabBarItem.title = "Profile"
            viewControllers[2].tabBarItem.image = UIImage(systemName: "person")
            
        }
    }
}
