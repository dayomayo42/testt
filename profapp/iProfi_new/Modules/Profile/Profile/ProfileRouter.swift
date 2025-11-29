//
//  ProfileRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//
import Foundation
import UIKit

protocol ProfileRouterProtocol: class {
}

class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: ProfileController!

    init(viewController: ProfileController) {
        self.viewController = viewController
    }
}

