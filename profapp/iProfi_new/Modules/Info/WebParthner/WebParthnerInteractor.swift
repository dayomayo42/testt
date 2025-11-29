//
//  WebParthnerInteractor.swift
//  iProfi_new
//
//  Created by violy on 23.09.2022.
//

import Foundation
import UIKit

protocol WebParthnerInteractorProtocol {
    func configureView()
}

class WebParthnerInteractor: WebParthnerInteractorProtocol {
    var viewController: WebParthnerController!
    var presenter: WebParthnerPresenterProtocol!
    
    init(viewController: WebParthnerController, presenter: WebParthnerPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        if let url = URL(string: vc.link) {
            let myURLRequest = URLRequest(url: url)
            vc.webView.load(myURLRequest)
        }
    }
}
