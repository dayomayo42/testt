//
//  UITextview.swift
//  iProfi_new
//
//  Created by violy on 03.10.2022.
//

import Foundation
import UIKit

extension UITextView {

    func addHyperLinksToText(originalText: String, hyperLinks: [String: String], font: UIFont) {
        
        
    let attributedOriginalText = NSMutableAttributedString(string: originalText)
        
    for (hyperLink, urlString) in hyperLinks {
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSRange(location: 0, length: attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: font, range: fullRange)
    }
    
    self.linkTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.black
    ]
    self.attributedText = attributedOriginalText
  }
}
