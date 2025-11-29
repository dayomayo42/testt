//
//  SpecializationsListRouter.swift
//  iProfi_new
//
//  Created by violy on 28.07.2022.
//

import Foundation

protocol SpecializationsListRouterProtocol {
    func backAction()
    func openProfileDetail(userModel: UserModel)
}

class SpecializationsListRouter: SpecializationsListRouterProtocol {
    var viewController: SpecializationsListController!
    
    init(viewController: SpecializationsListController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openProfileDetail(userModel: UserModel) {
        let vc = viewController.getControllerProfile(controller: .profiledetail) as! ProfileDetailController
        vc.userModel = userModel
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
