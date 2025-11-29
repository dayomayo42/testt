//
//  StockProductModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import Foundation
// MARK: - StockProductModel
struct StockProductModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [StockProduct]?
    var link: String?

    enum CodingKeys: String, CodingKey {
        case success, link
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct StockProduct: Codable {
    var id, dealerID: Int?
    var dealer: Supplier?
    var image, name: String?
    var discount, priceIn, priceOut, count: Int?
    var productDescription: String?

    enum CodingKeys: String, CodingKey {
        case id
        case dealerID = "dealer_id"
        case image, name
        case priceIn = "price_in"
        case priceOut = "price_out"
        case count
        case productDescription = "description"
        case dealer
        case discount
    }
}
