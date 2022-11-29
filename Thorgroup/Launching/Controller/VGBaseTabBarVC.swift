//
//  VGBaseTabBarVC.swift
//  Thorgroup
//
//  Created by apple on 2022/11/9.
//

import UIKit


class VGBaseTabBarVC: UITabBarController {

    override func viewDidLoad() {
         barItemConfig()
         systemRemindStyle()
    }
    
    func barItemConfig(){
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor(0x666666)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor(0x666666)], for: .selected)
        tabBar.tintColor = UIColor(0x666666)
    }
    
    func systemRemindStyle(){
        let v1 = UINavigationController.init(rootViewController: ViewController())
        let v2 = UINavigationController.init(rootViewController: ProfileViewController())
        let v3 = UINavigationController.init(rootViewController: VGPageVC())
        let v4 = UINavigationController.init(rootViewController: ViewController())
        
        v1.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(named: "home_tab_unsel"), selectedImage: UIImage(named: "home_tab_sel")!.withRenderingMode(.alwaysOriginal))
        v2.tabBarItem = UITabBarItem.init(title: "Category", image: UIImage(named: "category_tab_unsel"), selectedImage: UIImage(named: "category_tab_sel")!.withRenderingMode(.alwaysOriginal))
        v3.tabBarItem = UITabBarItem.init(title: "Cart", image: UIImage(named: "cart_tab_unsel"), selectedImage: UIImage(named: "cart_tab_sel")!.withRenderingMode(.alwaysOriginal))
        v4.tabBarItem = UITabBarItem.init(title: "Me", image: UIImage(named: "mine_tab_unsel"), selectedImage: UIImage(named: "mine_tab_sel")!.withRenderingMode(.alwaysOriginal))

        v1.tabBarItem.badgeValue = "New"
        v2.tabBarItem.badgeValue = "99+"
        v3.tabBarItem.badgeValue = "1"
        v3.tabBarItem.badgeColor = .blue
        viewControllers = [v1, v2, v3, v4]
    }
    
    deinit {
        
    }
}
