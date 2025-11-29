//
//  ClientEditController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import UIKit
import TinkoffASDKUI

class ClientEditController: UIViewController {
    var presenter: ClientEditPresenterProtocol!
    let configurator: ClientEditConfiguratorProtocol = ClientEditConfigurator()
    
    @IBOutlet weak var surnameView: UIView!
    @IBOutlet weak var surnameField: UITextField!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var patronymicView: UIView!
    @IBOutlet weak var patronymicField: UITextField!
    
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var phoneNumberField: PhoneNumberView!
    
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var mailField: UITextField!
    
    @IBOutlet weak var birthView: UIView!
    @IBOutlet weak var birthField: UITextField!
    
    @IBOutlet weak var sexView: UIView!
    @IBOutlet weak var sexField: UITextField!
    
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var noteField: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var saveButtonView: UIView!
    
    var lastOffset: CGFloat = 0

    var isTextEditing = false
    var scrollEditedOffset: CGFloat = 0
    
    var model: Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        presenter.configureView(with: model!)
        
        nameField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        phoneNumberField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func countryAction(_ sender: Any) {
        presenter.openChooseCountry()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let editedModel = Client(id: model?.id, image: model?.image, name: nameField.text, midname: patronymicField.text, lastname: surnameField.text, phone: phoneNumberField.text, email: mailField.text, gender: sexField.text, birth: birthField.text, note: noteField.text)
        presenter.editUser(with: editedModel)
    }
    
    @IBAction func deleteClient(_ sender: Any) {
        
        let alert = UIAlertController(
            title: "Удалить клиента?",
            message: "",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { (action: UIAlertAction!) in
            self.presenter.deleteUser(with: self.model?.id ?? 0)
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let edit = presenter.checkFields()
        
        if edit {
            saveButton.isUserInteractionEnabled = true
            saveButton.backgroundColor = UIColor(named: "appBlue")
        } else {
            saveButton.isUserInteractionEnabled = false
            saveButton.backgroundColor = UIColor(named: "buttondismiss")
        }
    }
}

extension ClientEditController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        row == 0 ? "Мужской" : "Женский"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexField.text = row == 0 ? "Мужской" : "Женский"
    }
}
