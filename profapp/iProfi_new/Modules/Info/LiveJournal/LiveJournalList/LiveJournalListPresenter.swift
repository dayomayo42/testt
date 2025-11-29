//
//  LiveJournalListPresenter.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation

protocol LiveJournalListPresenterProtocol {
    var router: LiveJournalListRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openLiveJJournalDetail(model: SliderLJ)
    func getJournalItem(id: Int)
}

class LiveJournalListPresenter: LiveJournalListPresenterProtocol {
    var router: LiveJournalListRouterProtocol!
    var interactor: LiveJournalListInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openLiveJJournalDetail(model: SliderLJ) {
        router.openLiveJJournalDetail(model: model)
    }
    
    func getJournalItem(id: Int) {
        interactor.getJournalItem(id: id)
    }
}
