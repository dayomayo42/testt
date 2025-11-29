//
//  FinanceAddConsumptionController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import UIKit

class FinanceAddConsumptionController: UIViewController {

    var presenter: FinanceAddConsumptionPresenterProtocol!
    let configurator: FinanceAddConsumptionConfiguratorProtocol = FinanceAddConsumptionConfigurator()
    var income: Bool = false
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var sumField: UITextField!
    @IBOutlet weak var sumPlate: UIView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var namePlate: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        presenter.postFinance(type: income ? "income/create/products" : "outcome/create/other", name: nameField.text ?? "", price: sumField.text?.toInt() ?? 0, comment: "")
    }
}

extension FinanceAddConsumptionController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.checkField()
        if textField.tag == 1 {
            UIView.animate(withDuration: 0.3) {
                self.scrollView.contentOffset.y = 50
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.checkField()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter.checkField()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension FinanceAddConsumptionController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        presenter.checkField()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 150
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
        presenter.checkField()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        presenter.checkField()
        return true
    }
}



