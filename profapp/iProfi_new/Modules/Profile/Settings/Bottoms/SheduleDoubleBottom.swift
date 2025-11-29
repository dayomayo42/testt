//
//  SheduleDoubleBottom.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.11.2020.
//

import UIKit

class SheduleDoubleBottom: UIViewController {

    @IBOutlet weak var contentPlate: UIView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fieldTitleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    var active: UITextField?
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondTextField: UITextField!
    
    var delegate: SheduleDelegate?
    
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        datePicker.locale = .current
        datePicker.timeZone = .current
        datePicker.alpha = 1
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 15

        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        datePicker.addTarget(self, action: #selector(datePickerAction(_:)), for: .valueChanged)
        textField.inputView = datePicker
        secondTextField.inputView = datePicker
        textField.inputView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        secondTextField.inputView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.tag = 0
        secondTextField.tag = 1
        textField.delegate = self
        secondTextField.delegate = self
        
        let obj = delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0]
        if obj?.breakTimes.count == 2 {
            textField.text = obj?.breakTimes[0] ?? ""
            secondTextField.text = obj?.breakTimes[1] ?? ""
        }
    }
    
    @IBAction func cleanFields(_ sender: Any) {
        textField.text = ""
        secondTextField.text = ""
    }
    
    @objc func datePickerAction(_ picker: UIDatePicker) {
        dateFormatter.dateFormat = "HH:mm"
        active?.text = dateFormatter.string(from: picker.date)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: {
            self.background.alpha = 1
            self.bottomConstraint.constant += 170
        }, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseOut, animations: {
            self.background.alpha = 0
        }, completion: nil)
    }

    @IBAction func doneAction(_ sender: Any) {
        delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].breakTimes = [textField.text ?? "", secondTextField.text ?? ""]
        self.dismiss(animated: true, completion: nil)
    }
}

extension SheduleDoubleBottom: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        active = textField.tag == 0 ? self.textField : self.secondTextField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        active = nil
    }
}
