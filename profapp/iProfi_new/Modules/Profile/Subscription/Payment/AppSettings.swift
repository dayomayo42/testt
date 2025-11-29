//
//  AppSettings.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.04.2022.
//

import Foundation
import TinkoffASDKCore
class AppSetting {
    
    private let keySBP = "SettingKeySBP"
    private let keyShowEmailField = "SettingKeyShowEmailField"
    private let keyKindForAlertView = "KindForAlertView"
    private let keyAddCardCheckType = "AddCardChekType"
    private let keyLanguageId = "LanguageId"
    
    /// Система быстрых платежей
    var paySBP: Bool = false {
        didSet {
            UserDefaults.standard.set(paySBP, forKey: keySBP)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// Показыть на форме оплаты поле для ввода email для отправки чека
    var showEmailField: Bool = false {
        didSet {
            UserDefaults.standard.set(showEmailField, forKey: keyShowEmailField)
            UserDefaults.standard.synchronize()
        }
    }
    
    var Acquiring: Bool = false {
        didSet {
            UserDefaults.standard.set(Acquiring, forKey: keyKindForAlertView)
            UserDefaults.standard.synchronize()
        }
    }
    
    var addCardChekType: PaymentCardCheckType = .no {
        didSet {
            UserDefaults.standard.set(addCardChekType.rawValue, forKey: keyAddCardCheckType)
            UserDefaults.standard.synchronize()
        }
    }
    
    var languageId: String? {
        didSet {
            UserDefaults.standard.set(languageId, forKey: keyLanguageId)
            UserDefaults.standard.synchronize()
        }
    }
    
    static let shared = AppSetting()
    
    init() {
        let usd = UserDefaults.standard
        
        self.paySBP = usd.bool(forKey: keySBP)
        self.showEmailField = usd.bool(forKey: keyShowEmailField)
        self.Acquiring = usd.bool(forKey: keyKindForAlertView)
        if let value = usd.value(forKey: keyAddCardCheckType) as? String {
            self.addCardChekType = PaymentCardCheckType.init(rawValue: value)
        }
        
        self.languageId = usd.string(forKey: keyLanguageId)
    }
    
}
