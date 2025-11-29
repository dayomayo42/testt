//
//  SupplierAddController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import TinkoffASDKUI
import UIKit

class SupplierAddController: UIViewController {
    var presenter: SupplierAddPresenterProtocol!
    let configurator: SupplierAddConfiguratorProtocol = SupplierAddConfigurator()

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var namePlate: UIView!
    @IBOutlet var nameField: UITextField!

    @IBOutlet var numberPlate: UIView!
    @IBOutlet var numberField: PhoneNumberView!

    @IBOutlet var mailField: UITextField!
    @IBOutlet var mailPlate: UIView!

    @IBOutlet var addressPlate: UIView!
    @IBOutlet var addressField: UITextField!

    @IBOutlet var descPlate: UIView!
    @IBOutlet var descField: UITextView!

    @IBOutlet var addButton: UIButton!
    var lastOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }

    @IBAction func addAction(_ sender: Any) {
        presenter.createAction()
    }

    @IBAction func countryAction(_ sender: Any) {
        presenter.openChooseCountry()
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
}

extension SupplierAddController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let pos = (textField.tag == 2 && UIScreen.main.bounds.height < 620) ? 140 : textField.tag == 3 ? 200 : (textField.tag == 1 && UIScreen.main.bounds.height < 620) ? 40 : (textField.tag == 2 && UIScreen.main.bounds.height > 620) ? 50 : 0

        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat(pos)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField.tag == 0 {
                if updatedText.count > 1 {
                    addButton.isActive = true
                } else {
                    addButton.isActive = false
                }
            }
        }
        return true
    }
}

extension SupplierAddController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let pos = 250
        lastOffset = scrollView.contentOffset.y
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat(pos)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.lastOffset
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}
