//
//  TabBarController.swift
//  Instagram
//
//  Created by 今村俊博 on 2020/02/05.
//  Copyright © 2020 toshihiro.imamura. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        self.tabBar.barTintColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ImageSelectViewController {
            // ImageSelectViewControllerは、タブ切り替えではなくモーダル画面遷移する
            let imageSelectViewController = storyboard!.instantiateViewController(withIdentifier: "ImageSelect")
            present(imageSelectViewController, animated: true)
            return false
        } else {
            // その他のViewControllerは通常のタブ切り替えを実施
            return true
        }
    }
}
