//
//  StudyListRouter.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation

protocol StudyListRouterProtocol {
    func backAction()
    func goToStudy(model: SliderStudy)
}

class StudyListRouter: StudyListRouterProtocol {
    var viewController: StudyListController!
    
    init(viewController: StudyListController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func goToStudy(model: SliderStudy) {
        let vc = viewController.getControllerInfoBlock(controller: .studyDetail) as! StudyDetailController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
