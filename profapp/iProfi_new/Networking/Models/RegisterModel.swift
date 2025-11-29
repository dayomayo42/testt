//
//  RegisterModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 20.10.2020.
//

import Foundation

// MARK: - RegisterModel
struct RegisterModel: Codable {
    var phone, name, pushToken, password: String?
    var sphereId: Int?
    
    enum CodingKeys: String, CodingKey {
        case phone, name, password
        case sphereId = "sphere_id"
        case pushToken = "push_token"
    }
}


// MARK: - RegisterResponseModel
struct RegisterResponseModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: RegisterResponse?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - RegisterResponse
struct RegisterResponse: Codable {
    var token, type: String?
    var user: ShortUser?
}

struct ShortUser: Codable {
    var id, sphereID: Int?
    var name, email: String?
    var midname: String?
    var lastname: String?
    var address: String?
    var notifications: Bool?
    var reminderClient: Bool?
    var subscription: MySubscribtion?
    var trialExp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case sphereID = "sphere_id"
        case name, email, midname, lastname, address, subscription, notifications, reminderClient
        case trialExp = "trial_exp"
    }
}
