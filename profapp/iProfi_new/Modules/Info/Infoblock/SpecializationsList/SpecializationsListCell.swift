//
//  SpecializationsListCell.swift
//  iProfi_new
//
//  Created by violy on 10.08.2022.
//

import UIKit

class SpecializationsListCell: UITableViewCell {
    
    @IBOutlet weak var checkBoxView: UIImageView!
    @IBOutlet weak var specializationName: UILabel!
    var isCheckBoxSelected: Int = 0
    
    func configure(specName: String?, isSelected: Int) {
        guard let specName = specName else { return }
        swithCheckBoxState(isSelected: isSelected)
        specializationName.text = specName
    }
    
    func swithCheckBoxState(isSelected: Int) {
        if isSelected == 1 {
            checkBoxView.image = UIImage(named: "checked")
            checkBoxView.borderWidthV = 0
            checkBoxView.borderColorV = .clear
            checkBoxView.cornerRadiusV = 0
        } else {
            checkBoxView.image = nil
            checkBoxView.borderWidthV = 1
            checkBoxView.borderColorV = .lightGray
            checkBoxView.cornerRadiusV = 4
        }
        isCheckBoxSelected = isSelected
    }
}
