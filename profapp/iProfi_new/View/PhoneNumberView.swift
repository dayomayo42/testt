//
//  PhoneNumberView.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.04.2022.
//

import Foundation
import PhoneNumberKit
class PhoneNumberView: PhoneNumberTextField {
    override var defaultRegion: String {
            get {
                return "RU"
            }
            set {} // exists for backward compatibility
        }
    
    func setup() {
        PhoneNumberKit.CountryCodePicker.commonCountryCodes = ["RU","KZ","BY", "UA", "LV", "LT", "EE", "SK", "CZ", "KG", "AM", "DE", "IL"]
        self.withExamplePlaceholder = true
        self.withFlag = true
        self.withDefaultPickerUI = true
        self.withPrefix = true
    }
}
