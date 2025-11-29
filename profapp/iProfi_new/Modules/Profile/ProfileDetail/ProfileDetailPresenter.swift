//
//  ProfileDetailPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 23.10.2020.
//

import Foundation
import UIKit

protocol ProfileDetailPresenterProtocol: ChooseCountryDelegate {
    var router: ProfileDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func editMode(edit: Bool)
    func addSpec(pos: Int)
    func openSpec(pos: Int)
    func deleteSpec(pos: Int)
    func openChooseCountry()
    func deleteAccount()
    func checkEdit()
    func openSpheres(sphereList: [SphereModel], onSelect: @escaping ((SphereModel)->()))
    func openSphereList()
}

class ProfileDetailPresenter: ProfileDetailPresenterProtocol {
    var router: ProfileDetailRouterProtocol!
    var interactor: ProfileDetailInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func editMode(edit: Bool) {
        interactor.editMode(edit: edit)
    }

    func addSpec(pos: Int) {
        interactor.addSpec(pos: pos)
    }
    
    func openSpec(pos: Int) {
        interactor.openSpec(pos: pos)
    }
    
    func deleteSpec(pos: Int) {
        interactor.deleteSpec(pos: pos)
    }
    
    func openChooseCountry() {
        interactor.toCountryList()
    }
    
    func deleteAccount() {
        interactor.deleteAccount()
    }
    
    func configureView(from model: CountriesModel?) {
        interactor.configureView(with: model)
    }
    
    func checkEdit() {
        interactor.checkEdit()
    }
    
    func openSpheres(sphereList: [SphereModel], onSelect: @escaping ((SphereModel)->())) {
        router.openSpheres(sphereList: sphereList, onSelect: onSelect)
    }
    
    func openSphereList() {
        interactor.openSphereList()
    }
}

