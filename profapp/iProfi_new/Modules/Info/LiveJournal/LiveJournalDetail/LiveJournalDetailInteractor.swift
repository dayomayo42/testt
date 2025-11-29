//
//  LiveJournalDetailInteractor.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation
import AlamofireImage

protocol LiveJournalDetailInteractorProtocol {
    func configureView()
}

class LiveJournalDetailInteractor: LiveJournalDetailInteractorProtocol {
    var viewController: LiveJournalDetailController!
    var presenter: LiveJournalDetailPresenterProtocol!
    
    init(viewController: LiveJournalDetailController, presenter: LiveJournalDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        vc.descTextView.textContainerInset.left = -4
        let shareLink = vc.model?.url ?? ""
        vc.shareLink = shareLink
        
        if let type = vc.model?.type {
            switch type {
            case "journal/news":
                vc.headerTitileLabel.text = "Новости"
            case "journal/articles":
                vc.headerTitileLabel.text = "Статьи"
            case "journal/exhibitions":
                vc.headerTitileLabel.text = "Выставки"
            default:
                vc.headerTitileLabel.text = ""
            }
        }
        let title = vc.model?.name ?? ""
        
        vc.gradientView.isHidden = title.count == 0
        
        vc.titleLabel.text = title
        vc.descTextView.text = vc.model?.body
        
        if let url = URL(string: vc.model?.image ?? "") {
            vc.newImageView.contentMode = .scaleAspectFill
            vc.newImageView.af_setImage(withURL: url)
        } 
    }
}
