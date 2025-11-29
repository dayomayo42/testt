//
//  SpecializationsListInteractor.swift
//  iProfi_new
//
//  Created by violy on 28.07.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol SpecializationsListInteractorProtocol {
    func configureView()
    func checkIsSpecsExisted()
    func postSpec(completion: @escaping () -> ())
}

class SpecializationsListInteractor: SpecializationsListInteractorProtocol {
    var viewController: SpecializationsListController!
    var presenter: SpecializationsListPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SpecializationsListController, presenter: SpecializationsListPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        viewController.blankPlug.isHidden = false
        viewController.view.bringSubviewToFront(viewController.blankPlug)
        viewController.noSpecPlugView.isHidden = true
        
        if vc.model?.count ?? 0 > 0 {
            vc.model?.removeFirst()
        }
        
        if vc.model?.count ?? 0 > 0 {
            showDefault()
        } else {
            showPlug()
        }
    }
    
    func checkIsSpecsExisted() {
        if viewController.noSpecPlugView.isHidden == false {
            getSpec()
        }
    }
    
    func showPlug() {
        guard let vc = viewController else { return }
        vc.noSpecPlugView.isHidden = false
        vc.blankPlug.isHidden = true
        vc.view.bringSubviewToFront(vc.noSpecPlugView)
    }
    
    func showDefault() {
        guard let vc = viewController else { return }
        vc.noSpecPlugView.isHidden = true
        vc.blankPlug.isHidden = true
    }
    
    func postSpec(completion: @escaping () -> ()) {
        var ids: [Int] = []
        viewController.model?.forEach { spec in
            if spec.checked == 1 {
                if let id = spec.id {
                    ids += [id]
                }
            }
        }
        
        service.postInfoBlockSpecs(specsId: ids).subscribe { (response) in
            if self.viewController != nil {
                if response.success ?? false {
                    completion()
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getSpec() {
        SVProgressHUD.show()
        service.getProfile().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.model = response.data?.specs
                    self.viewController.model?.removeFirst()
                    if self.viewController.model?.count == 0 {
                        self.showPlug()
                    } else {
                        self.showDefault()
                    }
                    self.viewController.tableView.reloadData()
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "error")
                }
            }
        } onError: { (error) in
            let moyaError = error as? MoyaError
            if moyaError?.errorCode == 6 {
                let plug = NoInternetPlugView() {
                    self.viewController.blankPlug.isHidden = false
                    self.getSpec()
                }
                self.viewController.blankPlug.isHidden = true
                plug.frame = self.viewController.view.bounds
                self.viewController.view.addSubview(plug)
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
}
