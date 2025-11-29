//
//  AnswerQuestModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
// MARK: - AnswerQuestModel
struct AnswerQuestModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: [AnswerQuest]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct AnswerQuest: Codable {
    var id: Int?
    var name, datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
    }
}
