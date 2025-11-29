//
//  CreateSupplierModel.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
// MARK: - CreateSupplierModel
struct CreateSupplierModel: Codable {
    var name, phone, email, address: String?
    var createSupplierModelDescription: String?

    enum CodingKeys: String, CodingKey {
        case name, phone, email, address
        case createSupplierModelDescription = "description"
    }
}
