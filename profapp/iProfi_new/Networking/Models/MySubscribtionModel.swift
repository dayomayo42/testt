//
//  MySubscribtionModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.03.2021.
//

import Foundation

// MARK: - MySubscribtionModel
struct MySubscribtionModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [MySubscribtion]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct MySubscribtion: Codable {
    var id: Int?
    var identifier: Int?
    var provider, expTime, createdAt: String?
    var type: Subscription?
    var trial: Int?

    enum CodingKeys: String, CodingKey {
        case id, provider, identifier
        case expTime = "exp_time"
        case createdAt = "created_at"
        case trial = "is_trial"
        case type
    }
}
