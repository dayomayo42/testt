//
//  TabBarExtension.swift
//  iProfi_new
//
//  Created by violy on 29.12.2022.
//

import Foundation
import UIKit

extension UITabBarController {
    
    func removeRedDot() {
        for subview in self.tabBar.subviews {
            if let subview = subview as? UIView {
                if subview.tag == 666 {
                    subview.removeFromSuperview()
                    break
                }
            }
        }
    }
    
    func addRedDotAtTabBarItemIndex(index: Int) {
        for subview in self.tabBar.subviews {

            if let subview = subview as? UIView {
                if subview.tag == 666 {
                    subview.removeFromSuperview()
                    break
                }
            }
        }

        let RedDotRadius: CGFloat = 4
        let RedDotDiameter = RedDotRadius * 2

        let TopMargin:CGFloat = 5

        let TabBarItemCount = CGFloat(self.tabBar.items!.count)

        let screenSize = UIScreen.main.bounds
        let HalfItemWidth = (screenSize.width) / (TabBarItemCount * 2)

        let xOffset = HalfItemWidth * CGFloat(index * 2 + 1)

        let imageHalfWidth: CGFloat = (self.tabBar.items![index] as! UITabBarItem).selectedImage!.size.width / 2

        let redDot = UIView(frame: CGRect(x: xOffset + imageHalfWidth , y: TopMargin, width: RedDotDiameter, height: RedDotDiameter))

        redDot.tag = 666
        redDot.backgroundColor = UIColor.red
        redDot.layer.cornerRadius = RedDotRadius

        self.tabBar.addSubview(redDot)
    }
    
}
