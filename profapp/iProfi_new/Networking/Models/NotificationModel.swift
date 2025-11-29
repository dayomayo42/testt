//
//  NotificationModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.12.2020.
//

import Foundation
// MARK: - NotificationModel
struct NotificationModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Notification]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Notification: Codable {
    var id: Int?
    var title, text: String?
    var confirmed: Int?
    var record: Records?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, text, confirmed, record
        case createdAt = "created_at"
    }
}
