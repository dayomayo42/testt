//
//  Authorizaion.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 19.10.2020.
//

import Foundation

struct Authorization {
    
    private static let kToken = "auth:token"
    private static let kUserName = "auth:userName"
    private static let kUserSName = "auth:userSName"
    private static let kUserLName = "auth:userLName"
    private static let kUserAddress = "auth:userAddress"
    private static let kEmail = "auth:email"
//    private static let kSubs = "auth:Subs"
    private static let kid = "auth:id"
    private static let kphone = "auth:phone"
    private static let kpass = "auth:pass"

    static var token: String? {
        set { UserDefaults.standard.set(newValue, forKey: kToken) }
        get { UserDefaults.standard.string(forKey: kToken) }
    }

    static var name: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserName) }
        get { UserDefaults.standard.string(forKey: kUserName) }
    }
    
    static var midname: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserSName) }
        get { UserDefaults.standard.string(forKey: kUserSName) }
    }
    
    static var lastame: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserLName) }
        get { UserDefaults.standard.string(forKey: kUserLName) }
    }
    
    static var useraddress: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserAddress) }
        get { UserDefaults.standard.string(forKey: kUserAddress) }
    }
    
//    static var subs: String? {
//        set { UserDefaults.standard.set(newValue, forKey: kSubs) }
//        get { "sklad_online_year" }//UserDefaults.standard.string(forKey: kSubs) }
//    }

    static var id: Int? {
        set { UserDefaults.standard.set(newValue, forKey: kid) }
        get { UserDefaults.standard.integer(forKey: kid) }
    }

    static var phone: String? {
        set { UserDefaults.standard.set(newValue, forKey: kphone) }
        get { UserDefaults.standard.string(forKey: kphone) }
    }

    static var pass: String? {
        set { UserDefaults.standard.set(newValue, forKey: kpass) }
        get { UserDefaults.standard.string(forKey: kpass) }
    }
    
    static var email: String? {
        set { UserDefaults.standard.set(newValue, forKey: kEmail) }
        get { UserDefaults.standard.string(forKey: kEmail) }
    }

    static var isAuthorized: Bool { token != nil && (token?.count ?? 0) > 0 }
}

struct Settings {
    
    private static let kcalendar = "settings:calendar"
    private static let kcurrency = "settings:currency"
    private static let kcurrencycym = "settings:currencycym"
    private static let konline = "settings:onlierecord"
    private static let knotif = "settings:opennotif"
    private static let ksubtype = "settings:subtype"
    private static let ksubid = "settings:ksubid"
    private static let konboard = "settings:onboard"
    private static let knotice = "settings:notice"
    private static let ktrialshowed = "settings:trialshowed"
    

    static var calendar: Bool? {
        set { UserDefaults.standard.set(newValue, forKey: kcalendar) }
        get { UserDefaults.standard.bool(forKey: kcalendar) }
    }

    static var currency: String? {
        set { UserDefaults.standard.set(newValue, forKey: kcurrency) }
        get { UserDefaults.standard.string(forKey: kcurrency) ?? "RUB" }
    }

    static var currencyCym: String? {
        set { UserDefaults.standard.set(newValue, forKey: kcurrencycym) }
        get { UserDefaults.standard.string(forKey: kcurrencycym) ?? "₽" }
    }

    static var onlinerecord: Int? {
        set { UserDefaults.standard.set(newValue, forKey: konline) }
        get { UserDefaults.standard.integer(forKey: konline) }
    }

    static var opennotification: Bool? {
        set { UserDefaults.standard.set(newValue, forKey: knotice) }
        get { UserDefaults.standard.bool(forKey: knotice) }
    }
    
    static var openNotice: Bool? {
        set { UserDefaults.standard.set(newValue, forKey: knotif) }
        get { UserDefaults.standard.bool(forKey: knotif) }
    }
    
    static var subType: String? {
        set { UserDefaults.standard.set(newValue, forKey: ksubtype) }
      //  get { " " }
        //get { "sklad_online_year" }
        get { UserDefaults.standard.string(forKey: ksubtype) }
    }
    
    static var subId: Int? {
        set { UserDefaults.standard.set(newValue, forKey: ksubid) }
        get { UserDefaults.standard.integer(forKey: ksubid) }
    }
    
    static var onboard: Bool? {
        set { UserDefaults.standard.set(newValue, forKey: konboard) }
        get { UserDefaults.standard.bool(forKey: konboard) }
    }
    
    static var subTrialShowed: [String: Bool]? {
        set { UserDefaults.standard.set(newValue, forKey: ktrialshowed) }
        get { UserDefaults.standard.object(forKey: ktrialshowed) as? [String: Bool] ?? [:] }
    }
    
    static var subTrialExp: String? = nil
    static var subTrial: Bool = false
}
