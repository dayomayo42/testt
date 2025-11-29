//
//  SendCallModel.swift
//  iProfi_new
//
//  Created by violy on 05.12.2023.
//

import Foundation

struct SendCallModel: Codable {
    let success: Bool?
    let callID: String?
    let confirmNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case callID = "call_id"
        case confirmNumber = "confirmation_number"
    }
}
