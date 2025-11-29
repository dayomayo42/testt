//
//  StudyRouter.swift
//  iProfi_new
//
//  Created by violy on 11.08.2022.
//

import Foundation
import UIKit

protocol StudyRouterProtocol {
    func backAction()
    func goToStudyList(model: SliderModelStudy, headerName: String)
    func goToMyStudy(model: [SliderStudy])
    func openStudySlider(model: SliderStudy)
}

class StudyRouter: StudyRouterProtocol {
    var viewController: StudyViewController!
    
    init(viewController: StudyViewController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func goToStudyList(model: SliderModelStudy, headerName: String) {
        let vc = viewController.getControllerInfoBlock(controller: .studyList) as! StudyListController
        vc.model = model
        vc.headerName = headerName
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToMyStudy(model: [SliderStudy]) {
        let vc = viewController.getControllerInfoBlock(controller: .myStudy) as! MyStudyController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openStudySlider(model: SliderStudy) {
        let vc = viewController.getControllerInfoBlock(controller: .studyDetail) as! StudyDetailController
        vc.model = model
        vc.delegate = viewController
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
