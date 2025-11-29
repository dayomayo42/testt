//
//  LiveJournalDetailPresenter.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation

protocol LiveJournalDetailPresenterProtocol {
    var router: LiveJournalDetailRouterProtocol! { get set }
    func configureView()
    func backAction()
    func openUrl(urlString: String)
    func openWebParthner(urlString: String)
}

class LiveJournalDetailPresenter: LiveJournalDetailPresenterProtocol {
    var router: LiveJournalDetailRouterProtocol!
    var interactor: LiveJournalDetailInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func backAction() {
        router.backAction()
    }
    
    func openUrl(urlString: String) {
        router.openUrl(urlString: urlString)
    }
    
    func openWebParthner(urlString: String) {
        router.openWebParthner(urlString: urlString)
    }
}
