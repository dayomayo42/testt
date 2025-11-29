//
//  ViewController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.08.2020.
//

import UIKit

class LaunchController: UIViewController {
    
    @IBOutlet weak var authButton: UIButton!
    var presenter: LaunchPresenterProtocol!
    let configurator: LaunchConfiguratorProtocol = LaunchConfigurator()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var phoneField: PhoneNumberView!
    @IBOutlet weak var phonePlate: UIView!
    
    @IBOutlet weak var centerStackViewContstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        presenter.optimiseForLowHeightDevice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func authAction(_ sender: Any) {
        presenter.authClicked()
    }
    
    @IBAction func authPhoneAction(_ sender: Any) {
        presenter.postAuth(phone: phoneField.text ?? "")
    }
    
    @IBAction func registerAction(_ sender: Any) {
        presenter.registerClicked()
    }
    
    @IBAction func goToSite(_ sender: Any) {
        presenter.logoClicked(with: "https://yaprofi.app")
    }
}

extension LaunchController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("screen height - \(UIScreen.main.bounds.height)")
        let screenSize = UIScreen.main.bounds.height
        switch screenSize {
        case 560...660:
            scrollView.contentOffset.y = 150
        case 660...800:
            scrollView.contentOffset.y = 85
        case 812...840:
            scrollView.contentOffset.y = 40
        default:
            scrollView.contentOffset.y = 0
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        scrollView.contentOffset.y = 0
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            presenter.checkIsNumberValid(phone: updatedText)
        }
        return true
    }
}
