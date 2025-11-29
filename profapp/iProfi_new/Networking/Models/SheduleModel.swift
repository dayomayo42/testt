//
//  SheduleModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.11.2020.
//

import Foundation

struct SheduleRespModel: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: SheduleModel?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - SheduleModel
struct SheduleModel: Codable {
    var datatimes: [ShaduleTimes]?
    var weekends: [String]?
    var exists: [String]?
}

// MARK: - Datatime
struct ShaduleTimes: Codable {
    var day: Int?
    var beginTime, endTime: String?
    var breakTimes: [String] = []
    var availableTimes: [String] = []

    enum CodingKeys: String, CodingKey {
        case day
        case beginTime = "begin_time"
        case endTime = "end_time"
        case breakTimes = "break_times"
        case availableTimes = "available_times"
    }
}
