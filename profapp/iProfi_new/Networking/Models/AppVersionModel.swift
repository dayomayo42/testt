//
//  AppVersionModel.swift
//  iProfi_new
//
//  Created by violy on 19.01.2023.
//

import Foundation

struct AppVersionModel: Codable {
    let success: Bool?
    let data: AppVersion?
}

struct AppVersion: Codable {
    let ios: IosVersion?
}

struct IosVersion: Codable {
    let currentVersion, minVersion: String?
}
