//
//  LiveJournalDetailRouter.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation
import UIKit
import SVProgressHUD

protocol LiveJournalDetailRouterProtocol {
    func backAction()
    func openUrl(urlString: String)
    func openWebParthner(urlString: String)
}

class LiveJournalDetailRouter: LiveJournalDetailRouterProtocol {
    var viewController: LiveJournalDetailController!
    
    init(viewController: LiveJournalDetailController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openWebParthner(urlString: String) {
        let vc = viewController.getControllerInfoBlock(controller: .webParthner) as! WebParthnerController
        vc.link = urlString
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openUrl(urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                SVProgressHUD.showDismissableError(withStatus: "Текущую ссылку невозможно открыть")
            }
        } else {
            SVProgressHUD.showDismissableError(withStatus: "Текущую ссылку невозможно открыть")
        }
    }
}
