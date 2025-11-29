//
//  StudyDetailPresenter.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation

protocol StudyDetailPresenterProtocol {
    var router: StudyDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func postJoinCourse(model: JoinCourseModel)
}

class StudyDetailPresenter: StudyDetailPresenterProtocol {
    
    var router: StudyDetailRouterProtocol!
    var interactor: StudyDetailInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func postJoinCourse(model: JoinCourseModel) {
        interactor.postJoinCourse(model: model)
    }
}
