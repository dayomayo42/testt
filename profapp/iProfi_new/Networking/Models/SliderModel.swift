//
//  sliderModel.swift
//  iProfi_new
//
//  Created by violy on 17.08.2022.
//

import Foundation

struct SliderModel: Codable {
    let success: Bool?
    var data: [SlideModel]?
}


struct SlideModel: Codable {
    let image: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case image, name
    }
}

