//
//  OnlineRecordController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 29.10.2020.
//

import UIKit
import TinkoffASDKUI

class OnlineRecordController: UIViewController {
    var presenter: OnlineRecordPresenterProtocol!
    let configurator: OnlineRecordConfiguratorProtocol = OnlineRecordConfigurator()
    
    var userModel: UserModel?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var aboutPlate: UIView!
    @IBOutlet weak var aboutField: UITextView!
    @IBOutlet weak var fbPlate: UIView!
    @IBOutlet weak var fbField: UITextField!
    @IBOutlet weak var instaField: UITextField!
    @IBOutlet weak var instaPlate: UIView!
    @IBOutlet weak var vkField: UITextField!
    @IBOutlet weak var vkPlate: UIView!
    @IBOutlet weak var whatsAppField: PhoneNumberView!
    @IBOutlet weak var whatsAppPlate: UIView!
    @IBOutlet weak var siteLink: UILabel!
    
    @IBOutlet weak var subPlate: UIView!
    @IBOutlet weak var margin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func shareAction(_ sender: Any) {
        presenter.shareLink()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        presenter.sendEdited()
    }
    
    @IBAction func timeAction(_ sender: Any) {
        presenter.openTime()
    }
    
    @IBAction func openCountry(_ sender: Any) {
        presenter.toCountryList()
    }
    
    @IBAction func openSubs(_ sender: Any) {
        presenter.openSubs()
    }
}


extension OnlineRecordController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let off = textField.tag == 0 ? 140 : textField.tag == 1 ? 210 : textField.tag == 2 ? 290 : 370
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat(off)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
    }
}

extension OnlineRecordController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 480
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            switch textField.tag {
            case 1:
                if updatedText.count < 7 {
                    return false
                } else {
                    return true
                }
            case 2:
                if updatedText.count < 14 {
                    return false
                } else {
                    return true
                }
            case 3:
                if updatedText.count < 13 {
                    return false
                } else {
                    return true
                }
            default:
                break
            }
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
    }
}
