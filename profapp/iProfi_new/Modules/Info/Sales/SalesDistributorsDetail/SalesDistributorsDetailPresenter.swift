//
//  SalesDistributorsDetailPresenter.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation

protocol SalesDistributorsDetailPresenterProtocol {
    var router: SalesDistributorsDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func setLikeDislike()
    func openUrl(urlString: String)
    func openWebParthner(urlString: String)
}

class SalesDistributorsDetailPresenter: SalesDistributorsDetailPresenterProtocol {
    
    var router: SalesDistributorsDetailRouterProtocol!
    var interactor: SalesDistributorsDetailInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func setLikeDislike()  {
        interactor.setLikeDislike()
    }
    
    func openWebParthner(urlString: String) {
        router.openWebParthner(urlString: urlString)
    }
    
    func openUrl(urlString: String) {
        router.openUrl(urlString: urlString)
    }
}
