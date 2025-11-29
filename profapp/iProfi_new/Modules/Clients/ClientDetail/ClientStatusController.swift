//
//  ClientStatusController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 24.12.2020.
//

import UIKit

class ClientStatusController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var background: UIView!
    var delegate: ClientChangeStatusDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: {
            self.background.alpha = 1
        }, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseOut, animations: {
            self.background.alpha = 0
        }, completion: nil)
    }

    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func readyAction(_ sender: Any) {
        print(pickerView.selectedRow(inComponent: 0))
        
        if pickerView.selectedRow(inComponent: 0) == 0 {
            delegate?.status = .active
        } else if pickerView.selectedRow(inComponent: 0) == 1 {
            delegate?.status = .waiting
        } else {
            delegate?.status = .blocked
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ClientStatusController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        row == 0 ? "Активный" : row == 1 ? "Лист ожидания" : "Заблокирован"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
      //  sexField.text = row == 0 ? "Мужской" : "Женский"
    }
}
