//
//  SliderModelMain.swift
//  iProfi_new
//
//  Created by violy on 19.08.2022.
//

import Foundation

// MARK: - Welcome
struct SliderModelMain: Codable {
    let success: Bool?
    let data: [SliderMain]?
}

// MARK: - Datum
struct SliderMain: Codable {
    let id: Int?
    let name: String?
    let shortDescription: String?
    let datumDescription: String?
    let liked, price: Int?
    let specID: Int?
    let companyID: Int?
    let type: String?
    let url: String?
    let image: String?
    let spec: Spec?
    let company: Company?
    let promocode: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case shortDescription = "short_description"
        case datumDescription = "description"
        case liked, price
        case specID = "spec_id"
        case companyID = "company_id"
        case type, url, image, spec, company, promocode 
    }
}



struct Company: Codable {
    let id: Int?
    let name: String?
    let image: String?
}
