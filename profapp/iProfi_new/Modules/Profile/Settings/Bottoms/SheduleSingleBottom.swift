//
//  SheduleSingleBottom.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.11.2020.
//

import UIKit

class SheduleSingleBottom: UIViewController {

    @IBOutlet weak var contentPlate: UIView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fieldTitleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var clearFieldButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var delegate: SheduleDelegate?
    
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.timeZone = .current
        datePicker.alpha = 1
        datePicker.minuteInterval = 15
        datePicker.datePickerMode = .time

        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        datePicker.addTarget(self, action: #selector(datePickerAction(_:)), for: .valueChanged)
        textField.inputView = datePicker
        textField.inputView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    @objc func datePickerAction(_ picker: UIDatePicker) {
        dateFormatter.dateFormat = "HH:mm"
        print(picker.date)
        textField.text = dateFormatter.string(from: picker.date)
    }
    
    func configure() {
        let obj = delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0]
        switch delegate?.type {
        case .begin:
            self.titleLabel.text = "Начало"
            self.fieldTitleLabel.text = "Начало"
            self.textField.text = obj?.beginTime
        case .end:
            self.titleLabel.text = "Конец"
            self.fieldTitleLabel.text = "Конец"
            self.textField.text = obj?.endTime
        case .none:
            break
        }
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
        switch delegate?.type {
        case .begin:
            delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].day = delegate?.pos ?? 0
            delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].beginTime = textField.text
        case .end:
            delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].day = delegate?.pos ?? 0
            delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].endTime = textField.text
        case .none:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearFieldAction() {
        textField.text = ""
    }
}
