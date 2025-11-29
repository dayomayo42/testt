//
//  ProductDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 12.10.2020.
//

import UIKit

class ProductAddController: UIViewController {
    var presenter: ProductAddPresenterProtocol!
    let configurator: ProductAddConfiguratorProtocol = ProductAddConfigurator()

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var priceCurrency: UILabel!

    @IBOutlet var priceField: UITextField!
    @IBOutlet var pricePlate: UIView!
    @IBOutlet var descriptionPlate: UIView!
    @IBOutlet var descriptionField: UITextView!
    @IBOutlet var brandField: UITextField!
    @IBOutlet var brandPlate: UIView!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var namePlate: UIView!

    @IBOutlet var categoryPlate: UIView!
    @IBOutlet var categoryLabel: UILabel!
    
    var category: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        presenter.checkFields(pos: 12, str: "")
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }

    @IBAction func addAction(_ sender: Any) {
        presenter.addProduct(model: ProductCreateModel(expcategoryID: category?.id, name: nameField.text ?? "", brand: brandField.text ?? "", productCreateModelDescription: descriptionField.text ?? "", price: priceField.text?.toInt()))
    }
}

extension ProductAddController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let pos = textField.tag == 0 ? 160 : textField.tag == 1 ? 244 : 457
        print(pos)
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
            let pos = textField.tag == 0 ? 0 : textField.tag == 3 ? 3 : 5
            presenter.checkFields(pos: pos, str: updatedText)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension ProductAddController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let pos = 348
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
