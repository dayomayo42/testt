//
//  SortedProductModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation
// MARK: - SotedProductModel
struct SortedProductModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [SortedProduct]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct SortedProduct: Codable {
    var id: Int?
    var name: String?
    var expandables: [Product]?
}
