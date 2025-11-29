//
//  ServerService.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit

protocol ServerServiceProtocol: class {
    func openUrl(with urlString: String)
}

class ServerService: ServerServiceProtocol {
    func openUrl(with urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
