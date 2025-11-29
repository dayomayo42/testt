//
//  NotificationsSettingsModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.12.2020.
//

import Foundation
// MARK: - NotificationSettingsModel
struct NotificationSettingsModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [NotificationSettings]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct NotificationSettings: Codable {
    var type: String?
    var enabled: Bool?
    var text: String?
    var remindAfter: Int?

    enum CodingKeys: String, CodingKey {
        case type, enabled, text
        case remindAfter = "remind_after"
    }
}

struct NotificationSettingsPost: Codable {
    var reminders: [NotificationSettings]?

    enum CodingKeys: String, CodingKey {
        case reminders
    }
}
