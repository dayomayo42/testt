//
//  LiveJournalInteractor.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import CoreAudio

protocol LiveJournalInteractorProtocol {
    func configureView()
    func initSlider(with slides: SliderModel)
    func getList(listType: LiveJournalListType)
}

class LiveJournalInteractor: LiveJournalInteractorProtocol {
    var viewController: LiveJournalController!
    var presenter: LiveJournalPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: LiveJournalController, presenter: LiveJournalPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        let screenWidth = UIScreen.main.bounds.width
        vc.sliderHeight.constant = screenWidth/1.5 + 25
        configureSlider()
    }
    
    func configureSlider() {
        guard let vc = viewController else { return }
        if let slides = vc.slides {
            if slides.data?.count ?? 0 > 0 {
                slides.data?.forEach{ slide in
                    vc.slidesModel?.data?.append(SlideModel(image: slide.image, name: slide.name))
                }
                if let slidesModel = vc.slidesModel {
                    presenter.initSlider(with: slidesModel)
                }
                vc.sliderPlate.isHidden = false
            } else {
                vc.sliderPlate.isHidden = true
            }
        }
    }
    
    
    func initSlider(with slides: SliderModel) {
        viewController.slider.delegate = viewController
        guard let slides = viewController.slider.createSlides(slides) else { return }
        viewController.slider.setupSlideScrollView(slides: slides)
    }
    
    func getList(listType: LiveJournalListType) {
        
        var way = "news"
        
        switch listType {
        case .news:
            way = "news"
        case .exhibition:
            way = "exhibitions"
        case .article:
            way = "articles"
        }
        
        let id = InfoblockController.currentSpecId
        
        SVProgressHUD.show()
        service.getLiveJournalList(id: id, way: way).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if let model = response.data {
                        self.presenter.openList(model: model, state: listType)
                    }
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
