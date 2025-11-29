//
//  ClientModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.10.2020.
//

import Foundation
// MARK: - ClientModel
struct ClientModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Client]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

struct ClietDetailModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: Client?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Client: Codable {
    var id: Int?
    var image, name, midname, lastname: String?
    var phone, email, gender, birth: String?
    var note: String?
    var status: Int?
    var records: [Records]?
    var debconsumptions: [Debconsumption]?
    var blocked, waited: Bool?
    var debt: Int?
}

struct Debconsumption: Codable {
    var id, discount, count: Int?
    var dateOut: String?
    var paid, priceOut: Int?
    var products: [StockProduct]?
    var debt: Int?

    enum CodingKeys: String, CodingKey {
        case id, discount, count
        case dateOut = "created_at"
        case paid
        case priceOut = "price_out"
        case products
    }
}
