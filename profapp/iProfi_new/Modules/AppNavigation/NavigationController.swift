//
//  NavigationController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import UIKit

class NavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .fullScreen
        self.modalTransitionStyle = .coverVertical
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.modalPresentationStyle = .fullScreen
        self.modalTransitionStyle = .coverVertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.interactivePopGestureRecognizer?.delegate = nil
        self.navigationBar.isHidden = true
    }
}
