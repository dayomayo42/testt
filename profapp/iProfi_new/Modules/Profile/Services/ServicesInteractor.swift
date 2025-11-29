//
//  ServicesInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol ServicesInteractorProtocol: class {
    func configureView()
    func openDetail(model: Service)
    func addService()
    func getServices()
    func shareLink()
}

class ServicesInteractor: ServicesInteractorProtocol {
    weak var viewController: ServicesController!
    weak var presenter: ServicesPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var first = true
    
    init(viewController: ServicesController, presenter: ServicesPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        
    }
    
    func openDetail(model: Service) {
        let vc = viewController.getControllerProfile(controller: .serviceDetail) as! ServiceDetailController
        vc.model = model
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkIfPlaceholderNeeded() {
        if viewController.services.count != 0 {
            viewController.placeholderView.isHidden = true
        } else {
            viewController.placeholderView.isHidden = false
        }
    }
    
    func addService() {
        let vc = viewController.getControllerProfile(controller: .serviceAdd)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func shareLink() {
        var address = ""
        var city = ""
        var link = ""
        
    
        service.getProfile().subscribe { response in
            if self.viewController != nil {
                if response.success ?? false {
                    address = response.data?.address ?? ""
                    city = response.data?.city ?? ""
                    link = response.data?.siteLink ?? ""
                    
                    if address.count > 0 && city.count > 0 {
                        let shareText = self.viewController.link ?? ""
                        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
                        self.viewController.present(vc, animated: true)
                    } else {
                        let dialogMessage = UIAlertController(title: "Ошибка", message: "Необходимо заполнить поля \"Город\" и \"Адрес\" в профиле", preferredStyle: .alert)
                         let ok = UIAlertAction(title: "Закрыть", style: .default, handler: { (action) -> Void in
                          })
                         dialogMessage.addAction(ok)
                        self.viewController.present(dialogMessage, animated: true, completion: nil)
                    }
                    
                    
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getServices() {
        if first {
            self.viewController.showHUD(show: true)
            first = false
        }
        service.getServices().subscribe { (response) in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                if self.viewController != nil {
                    self.viewController.services = response.data ?? []
                    self.checkIfPlaceholderNeeded()
                    self.viewController.link = response.link ?? ""
                    if response.data?.count ?? 0 > 0 {
                        self.viewController.tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    } else {
                        self.viewController.tableView.backgroundColor = .clear
                    }
                    self.viewController.tableView.reloadData()
                }
            } else {
                self.checkIfPlaceholderNeeded()
                SVProgressHUD.showError(withStatus: response.message)
            }
        } onError: { (error) in
            self.checkIfPlaceholderNeeded()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
}

