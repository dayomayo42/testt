//
//  StockArrivalModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.12.2020.
//

import Foundation

// MARK: - StockArrivalModel
struct StockArrivalModel: Codable {
    var data: [StockArrival]?
}

// MARK: - Datum
struct StockArrival: Codable {
    var product, dealer: ArrivalSimple?
    var priceIn: Int?
    var dateIn: String?
    var count: Int?

    enum CodingKeys: String, CodingKey {
        case product, dealer
        case priceIn = "price_in"
        case dateIn = "date_in"
        case count
    }
}

// MARK: - Dealer
struct ArrivalSimple: Codable {
    var id: Int?
}
