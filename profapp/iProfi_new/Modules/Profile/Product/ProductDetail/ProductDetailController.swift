//
//  ProductDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 13.10.2020.
//

import UIKit

class ProductDetailController: UIViewController {
    var presenter: ProductDetailPresenterProtocol!
    let configurator: ProductDetailConfiguratorProtocol = ProductDetailConfigurator()
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var sumPlate: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var sumField: UITextField!
    @IBOutlet weak var descPlate: UIView!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var brandPlate: UIView!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var namePlate: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var categoryPlate: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var product: Product?
    var category: Category?
    
    var isEditMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView(with: product!)
        presenter.editMode(edit: isEditMode, product: product!)
        
        nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        sumField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let isNameFieldTextEmpty = nameField.text?.isEmpty ?? true
        let isSumFieldTextEmpty = sumField.text?.isEmpty ?? true
        
        if isSumFieldTextEmpty || isNameFieldTextEmpty {
            editButton.isEnabled = false
            editButton.setTitleColor(.lightGray, for: .normal)
        } else {
            editButton.isEnabled = true
            editButton.setTitleColor(UIColor(named: "appBlue"), for: .normal)
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        presenter.delete(id: product?.id ?? 0)
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func editAndSaveAction(_ sender: Any) {
        if isEditMode {
            presenter.editMode(edit: !isEditMode, product: Product(id: product?.id, expcategoryID: product?.expcategoryID, name: nameField.text ?? "", brand: brandField.text ?? "", datumDescription: descField.text ?? "", price: sumField.text?.toInt() ?? 0))
        } else {
            presenter.editMode(edit: !isEditMode, product: product!)
        }
    }
}

extension ProductDetailController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let pos = textField.tag == 0 ? 120 : textField.tag == 1 ? 204 : 407
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat(pos - 120)//CGFloat(textField.tag * 90)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension ProductDetailController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let pos = 318
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat(pos - 120)//CGFloat(textField.tag * 90)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let textStr = textView.text, let textRange = Range(range, in: String(textStr)) {
            let updatedText = textStr.replacingCharacters(in: textRange, with: text)
            
        }
        return true
    }
}

