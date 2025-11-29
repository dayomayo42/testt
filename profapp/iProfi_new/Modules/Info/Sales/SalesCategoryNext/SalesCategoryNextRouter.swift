//
//  SalesCategoryNextRouterCell.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesCategoryNextRouterProtocol {
    func backAction()
    func openSales(model: SliderSales)
}

class SalesCategoryNextRouter: SalesCategoryNextRouterProtocol {
    var viewController: SalesCategoryNextController!
    
    init(viewController: SalesCategoryNextController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openSales(model: SliderSales) {
        let vc = viewController.getControllerInfoBlock(controller: .salesDistributorsDetail) as! SalesDistributorsDetailController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
