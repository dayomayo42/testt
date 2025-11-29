//
//  AuthController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import TinkoffASDKUI
import UIKit

class AuthController: UIViewController {
    @IBOutlet var passPlate: UIView!
    @IBOutlet var numberPlate: UIView!
    @IBOutlet var enterButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var passField: UITextField!
    @IBOutlet var numberField: PhoneNumberView!

    var presenter: AuthPresenter!
    let configurator: AuthConfiguratorProtocol = AuthConfigurator()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView(from: nil)
        presenter.checkFields(current: "", viewTag: 2)
    }

    open func textField(
        _ textField: UITextField,
        didFillMandatoryCharacters complete: Bool,
        didExtractValue value: String
    ) {
        presenter.checkFields(current: value, viewTag: 0)
    }

    @IBAction func regionChange(_ sender: Any) {
        presenter.openChooseCountry()
    }

    @IBAction func enterAction(_ sender: Any) {
        presenter.openApp()
    }

    @IBAction func rememberAction(_ sender: Any) {
        presenter.openRemember()
    }
    
    @IBAction func testAction(_ sender: Any) {
        presenter.testAuth()
    }
    
}

extension AuthController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.checkFields(current: "", viewTag: textField.tag)
        presenter.setActive(tag: textField.tag)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.checkFields(current: "", viewTag: 2)
        presenter.setActive(tag: 2)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.checkFields(current: "", viewTag: 2)
        presenter.setActive(tag: 2)
        view.endEditing(true)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            presenter.checkFields(current: updatedText, viewTag: textField.tag)
        }
        return true
    }
}
