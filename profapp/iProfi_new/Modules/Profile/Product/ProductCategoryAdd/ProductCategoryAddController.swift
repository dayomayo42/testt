//
//  ProductCategoryAddController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 08.10.2020.
//

import UIKit

class ProductCategoryAddController: UIViewController {
    var presenter: ProductCategoryAddPresenterProtocol!
    let configurator: ProductCategoryAddConfiguratorProtocol = ProductCategoryAddConfigurator()
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var categoryPlate: UIView!
    @IBOutlet weak var categoryField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }

    @IBAction func addAction(_ sender: Any) {
        presenter.addAction()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }    
}

extension ProductCategoryAddController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if updatedText.count > 0 {
                addButton.isActive = true
            } else {
                addButton.isActive = false
            }
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
