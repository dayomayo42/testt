//
//  ClientNotifModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.09.2021.
//

import Foundation
struct ClientNotifModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [ClientNotif]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

struct ClientNotif: Codable {
    var item: Records?
    var time: String?
}
