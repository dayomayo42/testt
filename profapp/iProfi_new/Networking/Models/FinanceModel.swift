//
//  FinanceModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
// MARK: - FinanceModel
struct FinanceModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Finance]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct Finance: Codable {
    var id: Int?
    var price: Int?
    var date: String?
    var name: String?
    var elems: [Finance]?
    
    enum CodingKeys: String, CodingKey {
        case price
        case date = "created_at"
        case id, name
        case elems = "items"
    }
}
//
//struct FinanceItem: Codable {
//    var name: String?
//    var price: Int?
//}
