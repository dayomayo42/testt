//
//  InfoblockInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import StoreKit

protocol InfoblockInteractorProtocol: class {
    func configureView()
    func initSlider(with slides: SliderModel)
    func getSlides(id: Int)
    func getSpec()
    func getStudy(id: Int)
    func getSale(id: Int)
    func getSpeczList()
    func getLiveJournalSlides()
    func getSalesSlides()
    func getStudySlides()
}

class InfoblockInteractor: InfoblockInteractorProtocol {
    weak var viewController: InfoblockController!
    weak var presenter: InfoblockPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: InfoblockController, presenter: InfoblockPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        vc.blankPlugView.isHidden = false
        vc.view.bringSubviewToFront(viewController.blankPlugView)
        
        vc.noSpecPlugView.isHidden = true
        vc.collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        vc.collectionView.isMultipleTouchEnabled = false
        
        let screenWidth = UIScreen.main.bounds.width
        vc.sliderHeight.constant = screenWidth/1.5 + 25
        getSpec()
    }
    
    func initSlider(with slides: SliderModel) {
        viewController.imageSlider.delegate = viewController
        guard let slides = viewController.imageSlider.createSlides(slides) else { return }
        viewController.imageSlider.setupSlideScrollView(slides: slides)
    }
    
    func showPlug() {
        guard let vc = viewController else { return }
        vc.noSpecPlugView.isHidden = false
        vc.view.bringSubviewToFront(vc.noSpecPlugView)
    }
    
    func defaultShow() {
        guard let vc = viewController else { return }
        vc.blankPlugView.isHidden = true
    }
    
    
    func getSpec() {
        SVProgressHUD.show()
        service.getProfile().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.userModel = response.data
                    if var specs = response.data?.specs {
                        if specs.count > 0 {
                            self.defaultShow()
                            var specsSorted: [Spec] = []
                            specsSorted.append(specs[0])
                            specs.removeFirst()
                            specs.forEach { spec in
                                if spec.checked == 1 {
                                    specsSorted += [spec]
                                }
                            }
                            
                            if specsSorted != self.viewController.categories {
                                self.viewController.categories = specsSorted
                                self.viewController.collectionView.reloadData()
                                
                                DispatchQueue.main.async {
                                    UIView.animate(withDuration:0) {
                                        self.viewController.collectionView.contentOffset.x = -20
                                    } completion: { _ in
                                        self.viewController.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
                                        self.viewController.collectionView(self.viewController.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
                                    }
                                }
                            }
                        }
                    } else {
                        self.showPlug()
                    }
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            let moyaError = error as? MoyaError
            if moyaError?.errorCode == 6 {
                let plug = NoInternetPlugView() {
                    self.viewController.blankPlugView.isHidden = false
                    self.getSpec()
                }
                self.viewController.blankPlugView.isHidden = true
                plug.frame = self.viewController.view.bounds
                self.viewController.view.addSubview(plug)
                SVProgressHUD.dismiss()
            } else {
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    func getSlides(id: Int) {
        SVProgressHUD.show()
        service.getSliderMain(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.slides = response
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getStudy(id: Int) {
        SVProgressHUD.show()
        service.getStudy(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if let studyModel = response.data?[0] {
                        self.presenter.openSlideStudy(model: studyModel)
                    }
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getSale(id: Int) {
        SVProgressHUD.show()
        service.getSale(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if let model = response.data[0] {
                        self.presenter.openSlideSale(model: model)
                    }
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getSpeczList() {
        SVProgressHUD.show()
        service.getProfile().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if var model = response.data?.specs {
                        self.presenter.openSpeczList(model: model)
                    }
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    
    func getLiveJournalSlides() {
        let id = InfoblockController.currentSpecId
        SVProgressHUD.show()
        service.getSliderJournal(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.presenter.openLiveJournal(slides: response)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    
    func getSalesSlides() {
        let id = InfoblockController.currentSpecId
        SVProgressHUD.show()
        service.getSliderSales(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.presenter.openSales(slides: response)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getStudySlides() {
        let id = InfoblockController.currentSpecId
        SVProgressHUD.show()
        service.getSliderStudy(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.presenter.openStudy(slides: response)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
