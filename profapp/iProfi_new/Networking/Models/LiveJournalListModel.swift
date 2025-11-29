//
//  LiveJournalListModel.swift
//  iProfi_new
//
//  Created by violy on 18.08.2022.
//

import Foundation

struct LiveJournalListModel: Codable {
    let success: Bool?
    let message: String?
    let data: [LiveJournalList]?
}

// MARK: - DataClass
struct LiveJournalList: Codable {
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
