//
//  ProfileModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 20.10.2020.
//

import Foundation

// MARK: - RegisterResponseModel
struct ProfileModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: UserModel?
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - RegisterUser
struct UserModel: Codable {
    var id, sphereID: Int?
    var name, midname, lastname, image: String?
    var email, phone, vk, fb, instagram: String?
    var city, address: String?
    var onlineRecord: Int?
    var siteLink: String?
    var about, timezone: String?
    var isNew: Int?
    var currency, currencySymbol: String?
    var isFirstSubscription: Int?
    var platform: String?
    var notifications: Bool?
    var reminderClient: Bool?
    var sphere: Spec?
    var specs: [Spec]?
    var subscription: MySubscribtion?
    var trialExp: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case sphereID = "sphere_id"
        case name, midname, lastname, image, email, phone, vk, fb
        case instagram = "in"
        case city, address
        case onlineRecord = "online_record"
        case siteLink = "site_link"
        case about, timezone
        case isNew = "is_new"
        case currency
        case currencySymbol = "currency_symbol"
        case isFirstSubscription = "is_first_subscription"
        case platform, notifications, reminderClient, sphere, specs, subscription
        case trialExp = "trial_exp"
    }
}


