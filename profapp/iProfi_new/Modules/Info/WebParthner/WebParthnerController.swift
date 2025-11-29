//
//  WebParthnerControllec.swift
//  iProfi_new
//
//  Created by violy on 23.09.2022.
//

import UIKit
import WebKit

class WebParthnerController: UIViewController, WKNavigationDelegate {
    
    var presenter: WebParthnerPresenterProtocol!
    let configurator: WebParthnerConfiguratorProtocol = WebParthnerConfigurator()
    

    @IBOutlet weak var webView: WKWebView!
    
    var link = "https://yakubashop.ru"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        webView.navigationDelegate = self
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
}
