//
//  StudyListPresenter.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation

protocol StudyListPresenterProtocol {
    var router: StudyListRouterProtocol! { get set }
    func configureView()
    func backAction()
    func goToStudy(model: SliderStudy)
    func getStudy(id: Int)
}

class StudyListPresenter: StudyListPresenterProtocol {
    var router: StudyListRouterProtocol!
    var interactor: StudyListInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func goToStudy(model: SliderStudy) {
        router.goToStudy(model: model)
    }
    
    func getStudy(id: Int) {
        interactor.getStudy(id: id)
    }
}
