//
//  ServiceModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.10.2020.
//

import Foundation

// MARK: - ServiceModel
struct ServiceModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Service]?
    var link: String?

    enum CodingKeys: String, CodingKey {
        case success, link
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Service: Codable {
    var id: Int?
    var name: String?
    var price: Int?
    var duration: Int?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, duration
    }
}
