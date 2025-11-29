//
//  TabBarController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 30.09.2020.
//

import UIKit

class TabBarController: UITabBarController {
    var type = ""
    
    @IBInspectable var defaultIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
        if type == "notification" {
            self.selectedIndex = 3
            Settings.opennotification = true
        } else if type == "recordClient" {
            self.selectedIndex = 3
            Settings.openNotice = true
        }
    }
}


