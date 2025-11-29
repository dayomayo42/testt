//
//  RegInfoController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.09.2020.
//

import UIKit

class RegInfoController: UIViewController {
    var presenter: RegInfoPresenter!
    let configurator: RegInfoConfiguratorProtocol = RegInfoConfigurator()
    var model: RegisterModel?
    var sphereList: [SphereModel] = []
    @IBOutlet weak var namePlate: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var sphereLabel: UILabel!
    @IBOutlet weak var regButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func regAction(_ sender: Any) {
        presenter.registerAction()
    }
    
    @IBAction func sphereChooseAction(_ sender: Any) {
        presenter.openSphere()
    }
}

extension RegInfoController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.setActive(active: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.setActive(active: false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            presenter.checkField(text: updatedText)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
