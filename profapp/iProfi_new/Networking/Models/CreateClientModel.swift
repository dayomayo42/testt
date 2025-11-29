//
//  CreateClientModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.10.2020.
//

import Foundation

// MARK: - CreateClientModel
struct CreateClientModel: Codable {
    var name, midname, lastname, phone: String?
    var email, gender, birth, note: String?
    var image: String?
}

struct CreateClientModelV3: Codable {
    var clients: [CreateClientModel?]
}
