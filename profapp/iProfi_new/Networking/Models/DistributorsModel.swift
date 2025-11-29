//
//  DistributorsModel.swift
//  iProfi_new
//
//  Created by violy on 22.08.2022.
//

import Foundation

struct DistributorsModel: Codable {
    let success: Bool?
    let message: String?
    var data: [Distributors]?
}

// MARK: - Datum
struct Distributors: Codable {
    let id: Int?
    let name: String?
    let image, url: String?
}
