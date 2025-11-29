//
//  SaleCategory.swift
//  iProfi_new
//
//  Created by violy on 24.08.2022.
//

import Foundation

// MARK: - Welcome
struct SaleCategoryModel: Codable {
    let success: Bool?
    let message: String?
    var data: [SaleCategory]
}

// MARK: - Datum
struct SaleCategory: Codable {
    let id: Int
    let title: String
}
