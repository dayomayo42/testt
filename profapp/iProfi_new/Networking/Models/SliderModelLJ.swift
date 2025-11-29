//
//  SliderModelLJ.swift
//  iProfi_new
//
//  Created by violy on 19.08.2022.
//

import Foundation

// MARK: - Welcome
struct SliderModelLJ: Codable {
    let success: Bool?
    let message: String? 
    let data: [SliderLJ]?
}

// MARK: - Datum
struct SliderLJ: Codable {
    let id, specID: Int?
    let name, body: String?
    let image: String?
    let address, type, createdAt, updatedAt: String?
    let url: String?
    let dates: [DateElement]?

    enum CodingKeys: String, CodingKey {
        case id
        case specID = "spec_id"
        case name, body, image, address, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url, dates
    }
}

// MARK: - DateElement
struct DateElement: Codable {
    let id, liveJournalID: Int
    let date: String
    let parentDateID: Int?
    let dateTill: DateTill?

    enum CodingKeys: String, CodingKey {
            case id
            case liveJournalID = "live_journal_id"
            case date
            case parentDateID = "parent_date_id"
            case dateTill = "date_till"
    }
}

struct DateTill: Codable {
    let id, liveJournalID: Int
    let date: String
    let parentDateID: Int?

    enum CodingKeys: String, CodingKey {
            case id
            case liveJournalID = "live_journal_id"
            case date
            case parentDateID = "parent_date_id"
    }
}
