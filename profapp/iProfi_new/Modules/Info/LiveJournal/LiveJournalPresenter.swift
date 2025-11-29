//
//  LiveJournalPresenter.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation

protocol LiveJournalPresenterProtocol {
    var router: LiveJournalRouterProtocol! { get set }
    func configureView()
    func backAction()
    func initSlider(with slides: SliderModel)
    func openLiveJJournalDetail(model: SliderLJ)
    func openList(model: [LiveJournalList], state: LiveJournalListType)
    func getList(listType: LiveJournalListType)
}

class LiveJournalPresenter: LiveJournalPresenterProtocol {
    var router: LiveJournalRouterProtocol!
    var interactor: LiveJournalInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func initSlider(with slides: SliderModel) {
        interactor.initSlider(with: slides)
    }
    
    func openLiveJJournalDetail(model: SliderLJ) {
        router.openLiveJJournalDetail(model: model)
    }
    
    func openList(model: [LiveJournalList], state: LiveJournalListType) {
        router.openList(model: model, state: state)
    }
    
    func getList(listType: LiveJournalListType) {
        interactor.getList(listType: listType)
    }
    
}
