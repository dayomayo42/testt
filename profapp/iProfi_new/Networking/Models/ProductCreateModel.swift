//
//  ProductCreateModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 22.10.2020.
//

import Foundation
// MARK: - ProductCreateModel
struct ProductCreateModel: Codable {
    var expcategoryID: Int?
    var name, brand, productCreateModelDescription: String?
    var price: Int?

    enum CodingKeys: String, CodingKey {
        case expcategoryID = "expcategory_id"
        case name, brand
        case productCreateModelDescription = "description"
        case price
    }
}
