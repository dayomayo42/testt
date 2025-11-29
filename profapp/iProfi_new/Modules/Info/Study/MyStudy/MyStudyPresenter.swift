//
//  MyStudyPresenter.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation

protocol MyStudyPresenterProtocol {
    var router: MyStudyRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openStudyDetail(model: SliderStudy)
    func getStudy(id: Int) 
}

class MyStudyPresenter: MyStudyPresenterProtocol {
    var router: MyStudyRouterProtocol!
    var interactor: MyStudyInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openStudyDetail(model: SliderStudy) {
        router.openStudyDetail(model: model)
    }
    
    func getStudy(id: Int) {
        interactor.getStudy(id: id)
    }
}
