//
//  ButtonExtnsion.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.09.2020.
//

import Foundation
import UIKit

extension UIButton {
    var isActive: Bool {
        get {
            let active = self.isActive
            return active
        }
        set(newValue) {
            if newValue {
                setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                backgroundColor = UIColor(named: "appBlue")
                isEnabled = true
                isUserInteractionEnabled = true
            } else {
                setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                backgroundColor = #colorLiteral(red: 0.7853352427, green: 0.7799058557, blue: 0.8017501235, alpha: 1)
                isEnabled = false
                isUserInteractionEnabled = false
            }
        }
    }
}
