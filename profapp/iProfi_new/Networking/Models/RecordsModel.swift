//
//  RecordsModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 20.10.2020.
//

import Foundation

// MARK: - RecordsModel
struct RecordsModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Records]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Records: Codable, Equatable {
    
    static func == (lhs: Records, rhs: Records) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id, userID, clientID, price: Int?
    var discount, duration: Int?
    var date, note, imageBefore: String?
    var reminder: Int?
    var reminderClient: Int?
    var imageAfter: String?
    var status: Int?
    var createdAt, updatedAt: String?
    var services: [Service]?
    var expandables: [Product]?
    var read: Bool?
    
    // Массив клиентов в зависимости от результатов парсинга, если обычные клиенты не распарсятся то подставятся из onlineClient
    var client: [Client]? {
        var returnValue: [Client]? = []
        if let onlineClient {
            returnValue?.append(onlineClient)
        }
        return clients?.count ?? 0 > 0 ? clients : returnValue
    }
    
    private var onlineClient: Client?
    private var clients: [Client]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case clientID = "client_id"
        case price, discount, duration, date, note, reminder
        case imageBefore = "image_before"
        case imageAfter = "image_after"
        case status, read
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case onlineClient = "client"
        case clients = "clients"
        case services, expandables, reminderClient
    }
}

struct RecordsModelV4: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [Records]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

struct RecordsModelV4Single: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: Records?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct RecordsV4: Codable {
    var id, userID, clientID, price: Int?
    var discount, duration: Int?
    var date, note, imageBefore: String?
    var reminder: Int?
    var reminderClient: Int?
    var imageAfter: String?
    var status: Int?
    var createdAt, updatedAt: String?
    var clients: [ClientShort]?
    var services: [Service]?
    var expandables: [ProductShort]?
    var read: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case clientID = "client_id"
        case price, discount, duration, date, note, reminder
        case imageBefore = "image_before"
        case imageAfter = "image_after"
        case status, read
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case clients, services, expandables, reminderClient
    }
}



