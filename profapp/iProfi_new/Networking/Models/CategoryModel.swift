//
//  CategoryModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.10.2020.
//

import Foundation

// MARK: - CategoryModel
struct CategoryModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Category]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Category
struct Category: Codable {
    var id: Int?
    var name: String?
}
