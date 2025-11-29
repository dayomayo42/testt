//
//  SubscribtionModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.03.2021.
//

import Foundation
import CryptoKit

// MARK: - SubscribtionModel
struct SubscriptionModel: Codable {
    let success: Bool?
    let statusCode: Int?
    let message: String?
    let data: [Subscription]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}


// MARK: - Datum
struct Subscription: Codable {
    let name, key: String?
    let id, duration, total, economy, price: Int?
    let datumDescription: [String]?
    var subs: [Sub]?
    
    func convertDescriptionToString() -> String? {
        var returnString = ""
        for index in 0...((datumDescription?.count ?? 0) - 1) {
         returnString += "• \(datumDescription?[index] ?? "")"
            returnString += index < ((datumDescription?.count ?? 0) - 1) ? "\n" : ""
        }
        return returnString
    }
    
    enum CodingKeys: String, CodingKey {
        case name, key
        case datumDescription = "description"
        case subs
        case id, duration, total, economy, price
    }
}

struct Sub: Codable {
    let id, duration, total, economy: Int?
    let price: Int?
}

