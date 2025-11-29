//
//  RememberPassController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.09.2020.
//

import TinkoffASDKUI
import UIKit

class RememberPassController: UIViewController {
    var presenter: RememberPassPresenter!
    let configurator: RememberPassConfiguratorProtocol = RememberPassConfigurator()
    @IBOutlet var enterButton: UIButton!
    @IBOutlet var numberPlate: UIView!
    @IBOutlet var numberField: PhoneNumberView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView(from: nil)
        presenter.checkFields(current: "", viewTag: 2)
    }

    @IBAction func flagAction(_ sender: Any) {
        presenter.openChooseCountry()
    }

    @IBAction func nextAction(_ sender: Any) {
        presenter.openComplete(with: numberField.text ?? "")
    }
}

extension RememberPassController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.checkFields(current: "", viewTag: textField.tag)
        presenter.setActive(tag: textField.tag)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.checkFields(current: "", viewTag: 2)
        presenter.setActive(tag: 2)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            presenter.checkFields(current: updatedText, viewTag: 0)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.setActive(tag: 2)
        presenter.checkFields(current: "", viewTag: 2)
        view.endEditing(true)
        return true
    }
}
