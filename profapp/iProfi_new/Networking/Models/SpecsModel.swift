//
//  SpecsModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 24.10.2020.
//

import Foundation

// MARK: - SpecsModel
struct SpecsModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Spec]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Spec: Codable, Equatable {
    var id: Int?
    var name: String?
    var checked: Int?
}
