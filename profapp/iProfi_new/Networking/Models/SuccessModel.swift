//
//  SuccessModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 19.10.2020.
//

import Foundation
// MARK: - SuccessModel
struct SuccessModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var debug: Bool?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, debug
    }
}
