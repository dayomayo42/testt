//
//  MyStudyRouter.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation

protocol MyStudyRouterProtocol {
    func backAction()
    func openStudyDetail(model: SliderStudy)
}

class MyStudyRouter: MyStudyRouterProtocol {
    var viewController: MyStudyController!
    
    init(viewController: MyStudyController) {
        self.viewController = viewController
    }
    
    func openStudyDetail(model: SliderStudy) {
        let vc = viewController.getControllerInfoBlock(controller: .studyDetail) as! StudyDetailController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
