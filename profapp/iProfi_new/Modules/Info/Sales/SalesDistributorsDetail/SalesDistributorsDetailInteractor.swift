//
//  SalesDistributorsDetailInteractor.swift
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

protocol SalesDistributorsDetailInteractorProtocol {
    func configureView()
    func setLikeDislike()
}

class SalesDistributorsDetailInteractor: SalesDistributorsDetailInteractorProtocol {
    var viewController: SalesDistributorsDetailController!
    var presenter: SalesDistributorsDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SalesDistributorsDetailController, presenter: SalesDistributorsDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        vc.descriptionTextView.textContainerInset.left = -4
        vc.saleDescriptionTextView.textContainerInset.left = -4
        setModel()
    }
    
    func setModel() {
        
        guard let vc = viewController else { return }
        let image = vc.model?.image ?? ""
        let title = vc.model?.name ?? ""
        let desc = vc.model?.datumDescription ?? ""
        let shortDescription = vc.model?.shortDescription ?? ""
        let price = vc.model?.price ?? 0
        let header = vc.model?.company?.name ?? ""
        let shareLink = vc.model?.url ?? ""
        let promocode = vc.model?.promocode?.title ?? ""
        let saleCount = vc.model?.promocode?.discount ?? 0
        
        if promocode.withoutSpaces().count > 0 {
            vc.promocodeButton.setTitle(promocode, for: .normal)
        } else {
            vc.promocodePlate.isHidden = true
        }
        
        vc.gradientView.isHidden = title.count == 0
        
        if saleCount != 0 {
            vc.saleLabel.text = "Получите скидку \(saleCount)% по промокоду"
        }  else {
            vc.saleLabel.text = "Получите скидку по промокоду"
        }
        
        vc.shareLink = shareLink
        
        if let url = URL(string: image) {
            vc.imageView.contentMode = .scaleAspectFill
            vc.imageView.af_setImage(withURL: url)
        }
        
        if shortDescription.withoutSpaces().isEmpty {
            vc.salesDescriptionPlate.isHidden = true
        } else {
            vc.salesDescriptionPlate.isHidden = false
            vc.saleDescriptionTextView.text = shortDescription
        }
        
        if vc.model?.liked == 0 {
            vc.likeButton.setImage(UIImage(named: "ic_like"), for: .normal)
        } else {
            vc.likeButton.setImage(UIImage(named: "ic_like_filled"), for: .normal)
        }
        
        vc.headerTitleLabel.text = header
        vc.titleLabel.text = title
        vc.descriptionTextView.text = desc
        vc.priceLabel.text = "\(price) руб."
        vc.imageTitleLabel.isHidden = true
    }
    
    func setLikeDislike() {
        guard let vc = viewController else { return }
        if vc.likeButton.currentImage == UIImage(named: "ic_like") {
            postLike {
                vc.likeButton.setImage(UIImage(named: "ic_like_filled"), for: .normal)
            }
        } else {
            postLike {
                vc.likeButton.setImage(UIImage(named: "ic_like"), for: .normal)
            }
        }
    }
    
    func postLike(completion: @escaping () -> ()) {
        let id = viewController.model?.id ?? 0
        SVProgressHUD.show()
        service.getLikeSale(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    completion()
                } else {
                    SVProgressHUD.showDismissableError(withStatus: response.message ?? "response error")
                }
            }
        } onError: { (error) in
            SVProgressHUD.showDismissableError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
