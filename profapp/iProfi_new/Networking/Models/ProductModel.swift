//
//  ProductModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 22.10.2020.
//

import Foundation

// MARK: - ProductModel
struct ProductModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Product]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Product: Codable, Hashable {
    var id, expcategoryID: Int?
    var name, brand, datumDescription: String?
    var price: Int?
    var pivot: ProductShort?

    enum CodingKeys: String, CodingKey {
        case id
        case expcategoryID = "expcategory_id"
        case name, brand
        case datumDescription = "description"
        case price, pivot
    }
}

struct ProductShort: Codable, Hashable {
    var id, count: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "expandable_id"
        case count
    }
}
