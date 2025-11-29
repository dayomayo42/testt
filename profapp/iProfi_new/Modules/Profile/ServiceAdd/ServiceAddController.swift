//
//  ServiceAddController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import UIKit

class ServiceAddController: UIViewController {
    var presenter: ServiceAddPresenterProtocol!
    let configurator: ServiceAddConfiguratorProtocol = ServiceAddConfigurator()
    var pickerView = UIPickerView()
    
    var timesArray: [ServiceTimes] = []
    
    @IBOutlet weak var namePlate: UIView!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var pricePlate: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceField: UITextField!
    
    @IBOutlet weak var durationPlate: UIView!
    @IBOutlet weak var durationField: UITextField!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var minutesInt: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createArray()
        configurator.configure(with: self)
        presenter.configureView()
        
       
    }
    
    func createArray() {
        for hour in 0...23 {
            for minute in [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55] {
                var timeString = ""
                let intMinutes = hour*60 + minute
                if hour == 0 {
                    if minute > 0 {
                        timeString  = "\(minute) минут"
                        timesArray.append(ServiceTimes(title: timeString, minutes: intMinutes))
                    }
                } else if hour == 1 {
                    timeString  = "\(hour) час"
                    if minute > 0 {
                        timeString += " \(minute) минут"
                    }
                    
                    timesArray.append(ServiceTimes(title: timeString, minutes: intMinutes))
                } else {
                    timeString  = hour == 21 ? "\(hour) час" : hour < 5 || hour > 20 ? "\(hour) часа" : "\(hour) часов"
                    if minute > 0 {
                        timeString += " \(minute) минут"
                    }
                    
                    timesArray.append(ServiceTimes(title: timeString, minutes: intMinutes))
                }
            }
        }
        timesArray.append(ServiceTimes(title: "24 часа", minutes: 1440))
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func addService(_ sender: Any) {
        presenter.addService()
    }
}

extension ServiceAddController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let pos = (textField.tag == 2 && UIScreen.main.bounds.height < 620) ? 140 : (textField.tag == 1 && UIScreen.main.bounds.height < 620) ? 40 : (textField.tag == 2 && UIScreen.main.bounds.height > 620) ? 50 : 0
        
        if textField.tag == 2 {
            if durationField.text?.count == 0 {
                durationField.text = timesArray.first?.title
                minutesInt = timesArray.first?.minutes ?? 0
            }
        }
        presenter.checkField()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat(pos)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
        presenter.checkField()
        return true
    }
}

extension ServiceAddController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        timesArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        timesArray[row].title
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        durationField.text = timesArray[row].title
        minutesInt = timesArray[row].minutes ?? 0
    }
}
