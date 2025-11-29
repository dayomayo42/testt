//
//  SupplierModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
// MARK: - SupplierModel
struct SupplierModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Supplier]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Supplier: Codable {
    var id: Int?
    var name, phone, email, address: String?
    var desc: String?

    enum CodingKeys: String, CodingKey {
        case id, name, phone, email, address
        case desc = "description"
    }
}
