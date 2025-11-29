//
//  StudyDetailRouter.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation

protocol StudyDetailRouterProtocol {
    func backAction()
}

class StudyDetailRouter: StudyDetailRouterProtocol {
    var viewController: StudyDetailController!
    
    init(viewController: StudyDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
