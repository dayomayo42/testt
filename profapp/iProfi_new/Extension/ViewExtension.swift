//
//  ViewExtension.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit

enum VerticalLocation: String {
    case bottom
    case top
}

enum ViewSide {
    case left, right, top, bottom, none
}

extension UIView {
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    func addShadow(location: VerticalLocation, color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6654711174), opacity: Float = 0.3, radius: CGFloat = 10.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 5), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: 5), color: color, opacity: opacity, radius: radius)
        }
    }

    func addBlackShadow(location: VerticalLocation, color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4501183712), opacity: Float = 0.5, radius: CGFloat = 10.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 5), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: 5), color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }

    @discardableResult
    func fromNib<T: UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(NSLayoutConstraint(item: contentView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: contentView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))

        addConstraints(constraints)
        return contentView
    }

    var isActiveBorder: Bool {
        get {
            let active = self.isActiveBorder
            return active
        }
        set(newValue) {
            if newValue {
                layer.borderColor = #colorLiteral(red: 0, green: 0.4710169435, blue: 1, alpha: 1)
            } else {
                layer.borderColor = #colorLiteral(red: 0.8978094459, green: 0.9220479131, blue: 0.943356812, alpha: 1)
            }
        }
    }
}
