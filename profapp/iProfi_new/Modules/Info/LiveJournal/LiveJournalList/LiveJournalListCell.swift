//
//  LiveJournalListCell.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation
import UIKit

class LiveJournalListCell: UITableViewCell {
    
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var newImageViewPlate: UIView!
    @IBOutlet weak var titleLabelPlate: UIView!
    @IBOutlet weak var descTextViewPlate: UIView!
    @IBOutlet weak var dateLabelpPlate: UIView!
    
    
    func configure(imageUrl: String, title: String?, desc: String?, date: [String], type: LiveJournalListType) {
        
        switch type {
        case .news:
            descTextViewPlate.isHidden = true
            let convertedDate = date[0].convertDate(to: 6)
            dateLabel.text = convertedDate
            
        case .article:
            descTextViewPlate.isHidden = true
            let convertedDate = date[0].convertDate(to: 6)
            dateLabel.text = convertedDate
            
        case .exhibition:
            descTextViewPlate.isHidden = false
            if date.count > 1 {
                let convertedDate = date[0].convertDate(to: 7).prefix(2)
                let convertedDate2 = date[1].convertDate(to: 7)
                dateLabel.text = "\(convertedDate) - \(convertedDate2)"
            } else {
                dateLabel.text = ""
            }
        }
        
        if let url = URL(string: imageUrl) {
            newImageView.af_setImage(withURL: url)
        }
        
        descTextView.textContainer.lineBreakMode = .byTruncatingTail
        descTextView.textContainer.maximumNumberOfLines = 6
        
        gradientView.isHidden = title?.count ?? 0 == 0
        
        titleLabel.text = title
        descTextView.text = desc
    }
    
    override func awakeFromNib() {
        descTextView.textContainerInset.left = -4
        newImageView.contentMode = .scaleAspectFill
    }
}
