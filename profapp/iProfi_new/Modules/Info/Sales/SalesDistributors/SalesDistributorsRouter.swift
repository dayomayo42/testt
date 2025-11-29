//
//  SaleDistributorsRouter.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesDistributorsRouterProtocol {
    func backAction()
    func openSalesCategoryNext(model: SliderModelSales)
}

class SalesDistributorsRouter: SalesDistributorsRouterProtocol {
    var viewController: SalesDistributorsController!
    
    init(viewController: SalesDistributorsController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openSalesCategoryNext(model: SliderModelSales) {
        let vc = viewController.getControllerInfoBlock(controller: .salesCategoryNext) as! SalesCategoryNextController
        vc.model = model
        vc.headerLabelText = model.data[0]?.company?.name ?? ""
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
