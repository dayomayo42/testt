//
//  JoinToCourseModel.swift
//  iProfi_new
//
//  Created by violy on 23.08.2022.
//

import Foundation

struct JoinCourseModel: Codable {
    let id: Int?
    let name, lastname, phone: String?
  

    enum CodingKeys: String, CodingKey {
        case id = "course_id"
        case name, lastname, phone
    }
}
