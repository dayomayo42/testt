//
//  SphereModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 14.09.2020.
//

import Foundation

// MARK: - SphereResponseModel
struct SphereResponseModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [SphereModel]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

struct SphereModel: Codable {
    let id: Int?
    let name: String?
}
