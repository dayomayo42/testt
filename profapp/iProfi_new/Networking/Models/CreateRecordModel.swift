//
//  CreateRecordModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import Foundation

// MARK: - CreateRecordModel
struct CreateRecordModel: Codable {
    var client: [Client]?
    var expandables: [Product]?
    var services: [Service]?
    var price, discount, duration: Int?
    var date, note: String?
    var reminder: Int?
    var reminderClient: Int?

    enum CodingKeys: String, CodingKey {
        case client = "clients"
        case expandables, services, price, discount, duration, date, note, reminder, reminderClient
    }
}

// MARK: - CreateRecordModelV4
struct CreateRecordModelV4: Codable {
    var client: [ClientShort]?
    var expandables: [ProductShort]?
    var services: [Service]?
    var price, discount, duration: Int?
    var date, note: String?
    var reminder: Int?
    var reminderClient: Int?

    enum CodingKeys: String, CodingKey {
        case client = "clients"
        case expandables, services, price, discount, duration, date, note, reminder, reminderClient
    }
}

// MARK: - Expandable
struct ProductRecord: Codable {
    var id, count: Int?
}

struct ClientShort: Codable {
    var clientID: Int?
    
    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
    }
}
