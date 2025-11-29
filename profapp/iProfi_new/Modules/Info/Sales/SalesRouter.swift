//
//  SalesRouter.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesRouterProtocol {
    func backAction()
    func openSalesCategory(model: SaleCategoryModel)
    func openSalesDistributors(model: DistributorsModel)
    func openFavouriteDetail()
    func openSale(model: SliderSales)
    func openDistibutor(model: SliderModelSales, categoryName: String)
}

class SalesRouter: SalesRouterProtocol {
    var viewController: SalesController!
    
    init(viewController: SalesController) {
        self.viewController = viewController
    }
    
    func backAction() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func openSalesCategory(model: SaleCategoryModel) {
        let vc = viewController.getControllerInfoBlock(controller: .salesCategory) as! SalesCategoryController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSalesDistributors(model: DistributorsModel) {
        let vc = viewController.getControllerInfoBlock(controller: .salesDistributors) as! SalesDistributorsController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openFavouriteDetail() {
        let vc = viewController.getControllerInfoBlock(controller: .salesCategoryDetail)
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSale(model: SliderSales) {
        let vc = viewController.getControllerInfoBlock(controller: .salesDistributorsDetail) as! SalesDistributorsDetailController
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDistibutor(model: SliderModelSales, categoryName: String) {
        let vc = viewController.getControllerInfoBlock(controller: .salesCategoryNext) as! SalesCategoryNextController
        vc.headerLabelText = categoryName
        vc.model = model
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
