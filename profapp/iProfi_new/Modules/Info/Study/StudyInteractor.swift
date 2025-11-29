//
//  StudyInteractor.swift
//  iProfi_new
//
//  Created by violy on 11.08.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import StoreKit

protocol StudyInteractorProtocol {
    func configureView()
    func initSlider(with slides: SliderModel)
    func getStudyList(way: String)
    func getMyStudyList()
    func getDistributorsStuff(id: Int)
}

class StudyInteractor: StudyInteractorProtocol {
    var viewController: StudyViewController!
    var presenter: StudyPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: StudyViewController, presenter: StudyPresenter) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        configSlider()
        getDistributors()
        vc.tableView.reloadData()
        
        let screenWidth = UIScreen.main.bounds.width
        vc.sliderHeight.constant = screenWidth/1.5 + 25
    }
    
    func configSlider() {
        guard let vc = viewController else { return }
        if let slides = vc.slides {
            if slides.data?.count ?? 0 > 0 {
                slides.data?.forEach { slide in
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
        viewController.imageSlider.delegate = viewController
        guard let slides = viewController.imageSlider.createSlides(slides) else { return }
        viewController.imageSlider.setupSlideScrollView(slides: slides)
    }
    
    func getStudyList(way: String) {
        let id = InfoblockController.currentSpecId
        var name = ""
        switch way {
        case "consultation":
            name = "Консультации"
        case "webinar":
            name = "Вебинары"
        case "qualification":
            name = "Повыш. квалификации"
        default:
            break
        }
        
        SVProgressHUD.show()
        service.getStudyList(id: id, way: way).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.presenter.goToStudyList(model: response, headerName: name)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getMyStudyList() {
        SVProgressHUD.show()
        service.getMyStudyList().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    var model: [SliderStudy] = []
                    if response.data?.count ?? 0 > 0 {
                        response.data?.forEach { sliderStudy in
                            model += [sliderStudy]
                        }
                    }
                    self.presenter.goToMyStudy(model: model)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getDistributors() {
        SVProgressHUD.show()
        service.getDistributors().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.modelForStudyPlan = response.data
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getDistributorsStuff(id: Int) {
        SVProgressHUD.show()
        service.getAllDistributorsStuff(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.presenter.goToStudyList(model: response, headerName: response.data?[0].company?.name ?? "")
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
