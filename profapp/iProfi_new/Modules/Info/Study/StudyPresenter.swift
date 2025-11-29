//
//  StudyPresenter.swift
//  iProfi_new
//
//  Created by violy on 11.08.2022.
//

import Foundation

protocol StudyPresenterProtocol {
    var router: StudyRouterProtocol! { get set }
    func configureView()
    func backAction()
    func initSlider(with slides: SliderModel)
    func goToStudyList(model: SliderModelStudy, headerName: String)
    func goToMyStudy(model: [SliderStudy])
    func getStudyList(way: String)
    func openStudySlider(model: SliderStudy)
    func getMyStudyList()
    func getDistributorsStuff(id: Int)
}

class StudyPresenter: StudyPresenterProtocol {
    var router: StudyRouterProtocol!
    var interactor: StudyInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func initSlider(with slides: SliderModel) {
        interactor.initSlider(with: slides)
    }
    
    func backAction() {
        router.backAction()
    }
    
    func goToStudyList(model: SliderModelStudy, headerName: String) {
        router.goToStudyList(model: model, headerName: headerName)
    }
    
    func goToMyStudy(model: [SliderStudy]) {
        router.goToMyStudy(model: model)
    }
    
    func getStudyList(way: String) {
        interactor.getStudyList(way: way)
    }
    
    func openStudySlider(model: SliderStudy) {
        router.openStudySlider(model: model)
    }
    
    func getMyStudyList() {
        interactor.getMyStudyList()
    }
    
    func getDistributorsStuff(id: Int) {
        interactor.getDistributorsStuff(id: id)
    }
}
