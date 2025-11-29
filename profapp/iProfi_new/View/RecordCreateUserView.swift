//
//  RecordUserView.swift
//  iProfi_new
//
//  Created by violy on 27.02.2023.
//

import Foundation
import UIKit
import AlamofireImage

class RecordCreateUserView: UIView {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAvatarImagView: UIImageView!
    
    public init(name: String, avatar: String) {
        super.init(frame: CGRect.zero)
        commonInit()
        configure(name: name, avatar: avatar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        fromNib()
    }
    
    func configure(name: String, avatar: String) {
        userNameLabel.text = name
        if let url = URL(string: avatar) {
            userAvatarImagView.af.setImage(withURL: url)
        }
    }
}
