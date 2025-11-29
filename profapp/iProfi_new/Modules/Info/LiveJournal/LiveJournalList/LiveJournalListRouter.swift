//
//  LiveJournalListRouter.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation

protocol LiveJournalListRouterProtocol {
    func backAction()
    func openLiveJJournalDetail(model: SliderLJ)
}

class LiveJournalListRouter: LiveJournalListRouterProtocol {
    var viewController: LiveJournalListController!
    
    init(viewController: LiveJournalListController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openLiveJJournalDetail(model: SliderLJ) {
        let vc = viewController.getControllerInfoBlock(controller: .liveJournalDetail) as! LiveJournalDetailController
        vc.hidesBottomBarWhenPushed = true
        vc.model = model
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
