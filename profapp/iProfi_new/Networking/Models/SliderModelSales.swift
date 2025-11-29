//
//  SliderModelSales.swift
//  iProfi_new
//
//  Created by violy on 19.08.2022.
//

import Foundation

// MARK: - Welcome
struct SliderModelSales: Codable {
    let success: Bool?
    let message: String?
    var data: [SliderSales?]
}

// MARK: - Datum
struct SliderSales: Codable {
    let id: Int?
    let name, shortDescription, datumDescription: String?
    var liked, price, specID: Int?
    let companyID: Int?
    let type: String?
    let url, image: String?
    let spec: Spec?
    let company: Company?
    let promocode: Promocode?
    let category: SalesCategory?

    enum CodingKeys: String, CodingKey {
        case id, name
        case shortDescription = "short_description"
        case datumDescription = "description"
        case liked, price
        case specID = "spec_id"
        case companyID = "company_id"
        case type, url, image, spec, company, promocode, category
    }
}

struct Promocode: Codable {
    let id, shareID: Int?
    let title: String?
    let discount: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case shareID = "share_id"
        case title, discount
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct SalesCategory: Codable {
    let id: Int?
    let title: String?
}
