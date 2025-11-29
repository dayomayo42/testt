//
//  InfoblockRouter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit
import SVProgressHUD

protocol InfoblockRouterProtocol: class {
    func openSpeczList(model: [Spec])
    func openStudy(slides: SliderModelStudy)
    func openSales(slides: SliderModelSales)
    func openLiveJournal(slides: SliderModelLJ)
    func openProfileDetail(userModel: UserModel)
    func openSlideSale(model: SliderSales)
    func openSlideStudy(model: SliderStudy)
    func openUrl(urlString: String)
    func openWebParthner(urlString: String)
}

class InfoblockRouter: InfoblockRouterProtocol {
    weak var viewController: InfoblockController!
    
    init(viewController: InfoblockController) {
        self.viewController = viewController
    }
    
    func openSpeczList(model: [Spec]) {
        let vc = viewController.getControllerInfoBlock(controller: .specializationsList) as! SpecializationsListController
        vc.userModel = viewController.userModel
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openStudy(slides: SliderModelStudy) {
        let vc = viewController.getControllerInfoBlock(controller: .study) as! StudyViewController
        vc.slides = slides
        print(slides)
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSales(slides: SliderModelSales) {
        let vc = viewController.getControllerInfoBlock(controller: .sales) as! SalesController
        vc.slides = slides
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openLiveJournal(slides: SliderModelLJ) {
        let vc = viewController.getControllerInfoBlock(controller: .liveJournal) as! LiveJournalController
        vc.slides = slides
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openProfileDetail(userModel: UserModel) {
        let vc = viewController.getControllerProfile(controller: .profiledetail) as! ProfileDetailController
        vc.userModel = userModel
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSlideSale(model: SliderSales) {
        
        let vc = viewController.getControllerInfoBlock(controller: .salesDistributorsDetail) as! SalesDistributorsDetailController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSlideStudy(model: SliderStudy) {
        let vc = viewController.getControllerInfoBlock(controller: .studyDetail) as! StudyDetailController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
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
            }
        }
    }
}
