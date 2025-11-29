//
//  SupplierDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.10.2020.
//

import UIKit
import TinkoffASDKUI

class SupplierDetailController: UIViewController {
    var presenter: SupplierDetailPresenterProtocol!
    let configurator: SupplierDetailConfiguratorProtocol = SupplierDetailConfigurator()
    
    @IBOutlet weak var content: UIView!
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
    
    @IBOutlet weak var deletePlate: UIView!
    @IBOutlet weak var editButton: UIButton!
    var isEditMode = false
    
    var lastOffset: CGFloat = 0
    
    var model: Supplier?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        presenter.editMode(edit: isEditMode)
        presenter.configureView(from: model!)
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func countryAction(_ sender: Any) {
        presenter.openChooseCountry()
    }
    
    @IBAction func editAction(_ sender: Any) {
        presenter.editMode(edit: !isEditMode)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        presenter.share(link: "https://yaprofi.app")
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        presenter.deleteSupplier()
    }
}

extension SupplierDetailController: UITextFieldDelegate {
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
        }
        return true
    }
}

extension SupplierDetailController: UITextViewDelegate {
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
