//
//  OrderIDSub.swift
//  iProfi_new
//
//  Created by violy on 07.07.2022.
//

import Foundation

struct GetSubOrderIdModel: Codable {
    let success: Bool?
    let status: Int?
    let data: SubInfo?
}

// MARK: - DataClass
struct SubInfo: Codable {
    let orderID: String?
    let subID: Int?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case subID = "sub_id"
    }
}
