//
//  DBTabbarController.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class DBTabbarController: UITabBarController {
    
    
    // @IBOutlet weak var myTabBar: UITabBar?
    
    static var newInstance: DBTabbarController? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? DBTabbarController
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItems()
    }
    
    
    func setTabBarItems(){

        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "tab1")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#C4C4C4"))
        myTabBarItem1.selectedImage = UIImage(named: "tab1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppNavBackColor)
        myTabBarItem1.title = "Home"
        myTabBarItem1.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)


        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "createacc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#C4C4C4"))
        myTabBarItem2.selectedImage = UIImage(named: "createacc")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppNavBackColor)
        myTabBarItem2.title = "My Booking"
        myTabBarItem2.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)


        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "tab3")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#C4C4C4"))
        myTabBarItem3.selectedImage = UIImage(named: "tab3")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppNavBackColor)
        myTabBarItem3.title = "My Account"
        myTabBarItem3.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)



    }
    
//    func setTabBarItems() {
//        if let tabBarItems = self.tabBar.items {
//            for (index, item) in tabBarItems.enumerated() {
//                if let image = UIImage(named: "tab\(index + 1)") {
//                    item.image = image.withRenderingMode(.alwaysOriginal).withTintColor(.AppNavBackColor)
//                    item.selectedImage = image.withRenderingMode(.alwaysOriginal)
//
////                    if let selectedImage = UIImage(named: "tabselected") {
////                        item.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
////                    }
//
//                    item.title = ["Home", "My Booking", "My Account"][index]
//
//                    // Adjust the image insets to position the image and text correctly
//                    item.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
//                }
//            }
//        }
//    }




    
    
    
}
