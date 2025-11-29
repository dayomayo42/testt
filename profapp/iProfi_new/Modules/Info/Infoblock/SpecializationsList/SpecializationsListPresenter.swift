//
//  SpecializationsListPresenter.swift
//  iProfi_new
//
//  Created by violy on 28.07.2022.
//

import Foundation

protocol SpecializationsListPresenterProtocol {
    var router: SpecializationsListRouterProtocol! { get set }
    func configureView()
    func backAction()
    func postSpec(completion: @escaping () -> ())
    func openProfileDetail(userModel: UserModel)
    func checkIsSpecsExisted()
}

class SpecializationsListPresenter: SpecializationsListPresenterProtocol {
    var router: SpecializationsListRouterProtocol!
    var interactor: SpecializationsListInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openProfileDetail(userModel: UserModel) {
        router.openProfileDetail(userModel: userModel)
    }
    
    func postSpec(completion: @escaping () -> ()) {
        interactor.postSpec(completion: completion)
    }
    
    func checkIsSpecsExisted() {
        interactor.checkIsSpecsExisted()
    }
}
