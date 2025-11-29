//
//  StockConsumptionModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.12.2020.
//

import Foundation
// MARK: - StockConsumptionModel
struct StockConsumptionModel: Codable {
    var data: [StockConsumption]?
}

// MARK: - Datum
struct StockConsumption: Codable {
    var product, client: ArrivalSimple?
    var dateOut: String?
    var priceOut, discount, paid, count: Int?

    enum CodingKeys: String, CodingKey {
        case product, client
        case dateOut = "date_out"
        case priceOut = "price_out"
        case discount, paid, count
    }
}
