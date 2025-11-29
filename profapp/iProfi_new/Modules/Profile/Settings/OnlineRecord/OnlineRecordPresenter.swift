//
//  OnlineRecordPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 29.10.2020.
//

import Foundation
import UIKit

protocol OnlineRecordPresenterProtocol: ChooseCountryDelegate {
    var router: OnlineRecordRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openTime()
    func shareLink()
    func toCountryList()
    func sendEdited()
    func openSubs()
}

class OnlineRecordPresenter: OnlineRecordPresenterProtocol {
    var router: OnlineRecordRouterProtocol!
    var interactor: OnlineRecordInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openTime() {
        interactor.openTime()
    }
    
    func shareLink() {
        interactor.shareLink()
    }
    
    func toCountryList() {
        interactor.toCountryList()
    }
    
    func configureView(from model: CountriesModel?) {
        interactor.configureView(with: model)
    }
    
    func sendEdited() {
        interactor.sendEdited()
    }
    
    func openSubs() {
        interactor.openSubs()
    }
}

