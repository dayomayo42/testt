//
//  StockUpdateDebtController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 17.12.2020.
//

import UIKit
import Moya
import RxSwift
import SVProgressHUD

class StockUpdateDebtController: UIViewController {
    
    @IBOutlet weak var sumLabel: UITextField!
    @IBOutlet weak var seconCurrencyLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    
    
    var delegate: UpdateDebDelegate?
    var order: Debconsumption?
    
    var debt: Int? = nil
    
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        postButton.isActive = false
        
        order = delegate?.model?.orderList?.first(where: {$0.id == delegate?.editId})
        debt = (order?.priceOut ?? 0) - (order?.paid ?? 0)

        debtLabel.text = "\(debt ?? 0)"
        currencyLabel.text = Settings.currency
        nameLabel.text = delegate?.model?.name ?? ""
        seconCurrencyLabel.text = Settings.currency
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        sumLabel.inputAccessoryView = toolbar
    }
    
    @IBAction func postDebt(_ sender: Any) {
        SVProgressHUD.show()
        
        service.postUpdateDebt(id: order?.id ?? 0, sum: sumLabel.text?.toInt() ?? 0).subscribe { (response) in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                let index = self.delegate?.model?.orderList?.firstIndex(where: {$0.id == self.delegate?.editId}) ?? 0
                if self.delegate?.model?.orderList?[index].debt != nil {
                    self.delegate?.model?.orderList?[index].debt! -= (self.sumLabel.text?.toInt() ?? 0)
                }
                 //.first(where: {$0.id == delegate?.editId})
                self.navigationController?.popToViewController(ofClass: StockDebtsController.self, animated: true)
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension StockUpdateDebtController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if updatedText.count > 0 {
                if updatedText.toInt() ?? 0 <= debt ?? 0 {
                    postButton.isActive = true
                } else {
                    postButton.isActive = false
                }
            } else {
                postButton.isActive = false
            }
        }
        return true
    }
}
