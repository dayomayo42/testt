//
//  SalesInteractor.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import StoreKit


protocol SalesInteractorProtocol {
    func configureView()
    func initSlider(with slides: SliderModel)
    func getDistributors()
    func getFavorites()
    func getSale(id: Int)
    func getSalesCategories()
    func getSalesByDistributors(id: Int, completion: @escaping (SliderModelSales) -> ())
}

class SalesInteractor: SalesInteractorProtocol {
    var viewController: SalesController!
    var presenter: SalesPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SalesController, presenter: SalesPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        configureSlider()
        vc.model = vc.modelSales
        vc.tableView.reloadData()
        
        let screenWidth = UIScreen.main.bounds.width
        vc.sliderHeight.constant = screenWidth/1.5 + 25
    }
    
    func configureSlider() {
        guard let vc = viewController else { return }
        if let slides = vc.slides {
            if slides.data.count > 0 {
                slides.data.forEach{ slide in
                    vc.slidesModel?.data?.append(SlideModel(image: slide?.image, name: slide?.name))
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
        
    func getDistributors() {
        SVProgressHUD.show()
        service.getSalesDistributors().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    print(response.data)
                    self.presenter.openSalesDistributors(model: response)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getFavorites() {
        SVProgressHUD.show()
        service.getFavoriteSales().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.modelFavouritesSlides = response
                    var nameArr: [String] = []
                    response.data.forEach { item in
                        nameArr += [item?.name ?? ""]
                    }
                    if nameArr.isEmpty {
                        self.viewController.plugView.isHidden = false
                    }
                    self.viewController.model = nameArr
                    self.viewController.tableView.reloadData()
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
                        self.presenter.openSale(model: model)
                    }
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getSalesCategories() {
        SVProgressHUD.show()
        service.getSalesCategories().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.presenter.openSalesCategory(model: response)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getSalesByDistributors(id: Int, completion: @escaping (SliderModelSales) -> ()) {
        SVProgressHUD.show()
        service.getSalesByDistributors(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    completion(response)
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
