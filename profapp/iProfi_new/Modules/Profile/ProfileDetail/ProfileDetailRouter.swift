//
//  ProfileDetailRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 23.10.2020.
//

import Foundation
import UIKit

protocol ProfileDetailRouterProtocol: class {
    func backAction()
    func openSpheres(sphereList: [SphereModel], onSelect: @escaping ((SphereModel)->()))
}

class ProfileDetailRouter: ProfileDetailRouterProtocol {
    weak var viewController: ProfileDetailController!
    
    init(viewController: ProfileDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openSpheres(sphereList: [SphereModel], onSelect: @escaping ((SphereModel)->())) {
        let vc = viewController.getController(controller: .regsphere) as! RegSphereController
        vc.sphereList = sphereList
        vc.onSelect = onSelect
        vc.shouldHideNavigaion = false
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}


