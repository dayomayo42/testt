//
//  SliderModelStudy.swift
//  iProfi_new
//
//  Created by violy on 19.08.2022.
//

import Foundation

// MARK: - Welcome
struct SliderModelStudy: Codable {
    let success: Bool?
    let message: String?
    var data: [SliderStudy]?
}

// MARK: - Datum
struct SliderStudy: Codable {
    let id, specID, companyID: Int?
    let type: String?
    let image: String?
    var subscribed: Bool?
    let name, datumDescription: String?
    let url: String?
    let spec: Spec?
    let company: Company?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case subscribed 
        case specID = "spec_id"
        case companyID = "company_id"
        case type, image, name
        case datumDescription = "description"
        case url
        case spec, company, price
    }
}

struct MyStudyModelList: Codable {
    let success: Bool?
    let statusCode: Int?
    let message: String?
    let data: [SliderStudy]?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct MyStudyList: Codable {
    let id: Int?
    let name: String?
    let courses: [SliderStudy]?
}
