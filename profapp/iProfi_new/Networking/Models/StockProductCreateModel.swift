//
//  StockProductCreateModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.11.2020.
//

import Foundation
// MARK: - StockProductCreateModel
struct StockProductCreateModel: Codable {
    let name: String
    let dealerID, priceIn, priceOut: Int
    let stockProductCreateModelDescription, image: String

    enum CodingKeys: String, CodingKey {
        case name
        case dealerID = "dealer_id"
        case priceIn = "price_in"
        case priceOut = "price_out"
        case stockProductCreateModelDescription = "description"
        case image
    }
}
