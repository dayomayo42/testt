//
//  LiveJournalRouter.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation

protocol LiveJournalRouterProtocol {
    func backAction()
    func openLiveJJournalDetail(model: SliderLJ)
    func openList(model: [LiveJournalList], state: LiveJournalListType)
}

class LiveJournalRouter: LiveJournalRouterProtocol {
    var viewController: LiveJournalController!
    
    init(viewController: LiveJournalController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openList(model: [LiveJournalList], state: LiveJournalListType) {
        let vc = viewController.getControllerInfoBlock(controller: .liveJournalList) as! LiveJournalListController
        vc.hidesBottomBarWhenPushed = true
        vc.model = model
        vc.state = state
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openLiveJJournalDetail(model: SliderLJ) {
        let vc = viewController.getControllerInfoBlock(controller: .liveJournalDetail) as! LiveJournalDetailController
        vc.hidesBottomBarWhenPushed = true
        vc.model = model
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
