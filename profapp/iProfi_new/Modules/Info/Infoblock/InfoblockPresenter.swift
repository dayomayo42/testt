//
//  InfoblockPresenter.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit

protocol InfoblockPresenterProtocol: class {
    var router: InfoblockRouterProtocol! { get set }
    func configureView()
    func initSlider(with slides: SliderModel)
    func openStudy(slides: SliderModelStudy)
    func openSpeczList(model: [Spec])
    func openSales(slides: SliderModelSales)
    func openLiveJournal(slides: SliderModelLJ)
    func getSlides(id: Int)
    func openProfileDetail(userModel: UserModel)
    func getSpec()
    func openSlideSale(model: SliderSales)
    func getStudy(id: Int)
    func openSlideStudy(model: SliderStudy)
    func getSale(id: Int)
    func getSpeczList()
    func getLiveJournalSlides()
    func getSalesSlides()
    func getStudySlides()
    func openUrl(urlString: String)
    func openWebParthner(urlString: String)
}

class InfoblockPresenter: InfoblockPresenterProtocol {
    var router: InfoblockRouterProtocol!
    var interactor: InfoblockInteractorProtocol!
    
    func configureView() {
        interactor.configureView()
    }
    
    func initSlider(with slides: SliderModel) {
        interactor.initSlider(with: slides)
    }
    
    func openStudy(slides: SliderModelStudy) {
        router.openStudy(slides: slides)
    }
    
    func getLiveJournalSlides() {
        interactor.getLiveJournalSlides()
    }
    
    func openSales(slides: SliderModelSales) {
        router.openSales(slides: slides)
    }
    
    func openSpeczList(model: [Spec]) {
        router.openSpeczList(model: model)
    }
    
    func openLiveJournal(slides: SliderModelLJ) {
        router.openLiveJournal(slides: slides)
    }
    
    func getSlides(id: Int) {
        interactor.getSlides(id: id)
    }
    
    func openProfileDetail(userModel: UserModel) {
        router.openProfileDetail(userModel: userModel)
    }
    
    func getSpec() {
        interactor.getSpec()
    }
    
    func openSlideSale(model: SliderSales) {
        router.openSlideSale(model: model)
    }
    
    func getStudy(id: Int) {
        interactor.getStudy(id: id)
    }
    
    func openSlideStudy(model: SliderStudy) {
        router.openSlideStudy(model: model)
    }
    
    func getSale(id: Int) {
        interactor.getSale(id: id)
    }
    
    func getSpeczList() {
        interactor.getSpeczList()
    }
    
    func getSalesSlides() {
        interactor.getSalesSlides()
    }
    
    func getStudySlides() {
        interactor.getStudySlides()
    }
    
    func openUrl(urlString: String) {
        router.openUrl(urlString: urlString)
    }
    
    func openWebParthner(urlString: String) {
        router.openWebParthner(urlString: urlString)
    }
}

