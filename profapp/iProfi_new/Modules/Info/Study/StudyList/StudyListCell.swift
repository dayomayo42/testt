//
//  StudyListCell.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation
import UIKit
import AlamofireImage

class StudyListCell: UITableViewCell {
    @IBOutlet weak var studyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var studyId: Int?
    @IBOutlet weak var gradienView: GradientView!
    
    func configure(title: String?, imageUrl: String, id: Int) {
        
        gradienView.isHidden = title?.count ?? 0 == 0
        
        titleLabel.text = title ?? ""
        studyId = id
        if let imageUrl = URL(string: imageUrl) {
            studyImageView.contentMode = .scaleAspectFill
            studyImageView.af_setImage(withURL: imageUrl)
        }
    }
}
