//
//  SalesCategoryRouter.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesCategoryRouterProtocol {
    func backAction()
    func openSalesCategoryNext(model: SliderModelSales, categoryName: String)
}

class SalesCategoryRouter: SalesCategoryRouterProtocol {
    var viewController: SalesCategoryController!
    
    init(viewController: SalesCategoryController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openSalesCategoryNext(model: SliderModelSales, categoryName: String) {
        let vc = viewController.getControllerInfoBlock(controller: .salesCategoryNext) as! SalesCategoryNextController
        vc.model = model
        vc.headerLabelText = categoryName
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
