//
//  PhotoModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.10.2020.
//

import Foundation
// MARK: - PhotoModel
struct PhotoModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: Photo?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct Photo: Codable {
    var url: String?
}
