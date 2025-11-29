//
//  StockOrderModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.12.2020.
//

import Foundation

// MARK: - StockOrderModel

struct StockOrderModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [StockOrder]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum

struct StockOrder: Codable {
    var id: Int?
    var products: [StockProduct]?
    var createdAt: String?
    var paid, priceOut: Int?
    var client: Client?
    var debt: Int?

    enum CodingKeys: String, CodingKey {
        case id, products
        case createdAt = "created_at"
        case paid
        case priceOut = "price_out"
        case client
    }
}
