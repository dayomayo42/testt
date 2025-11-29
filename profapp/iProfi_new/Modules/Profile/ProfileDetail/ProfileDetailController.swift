//
//  ProfileDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 23.10.2020.
//

import UIKit
import PhoneNumberKit
class ProfileDetailController: UIViewController {
    var presenter: ProfileDetailPresenterProtocol!
    let configurator: ProfileDetailConfiguratorProtocol = ProfileDetailConfigurator()
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var mainSpec: UIView!
    @IBOutlet weak var mainSpecLabel: UILabel!
    
    @IBOutlet weak var dopSpecOne: UIView!
    @IBOutlet weak var dopSpecOneLabel: UILabel!
    @IBOutlet weak var dopSpecOneArrow: UIImageView!
    
    @IBOutlet weak var dopSpecTwo: UIView!
    @IBOutlet weak var dopSpecTwoLabel: UILabel!
    @IBOutlet weak var dopSpecTwoArrow: UIImageView!
    
    @IBOutlet weak var dopSpecThree: UIView!
    @IBOutlet weak var dopSpecThreeLabel: UILabel!
    @IBOutlet weak var dopThreeArrow: UIImageView!
    
    @IBOutlet weak var dropMainSpecImageView: UIImageView!
    @IBOutlet weak var mainSpecArrowImageView: UIImageView!
    
    @IBOutlet weak var addSpecPlate: UIView!
    
    @IBOutlet weak var numberField: PhoneNumberView!
    @IBOutlet weak var numberPlate: UIView!
    
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var mailPlate: UIView!
    
    @IBOutlet weak var vkField: UITextField!
    @IBOutlet weak var vkPlate: UIView!
    
    @IBOutlet weak var instagramField: UITextField!
    @IBOutlet weak var instagramPlate: UIView!
    
    @IBOutlet weak var facebookField: UITextField!
    @IBOutlet weak var facebookPlate: UIView!
    
    @IBOutlet weak var sphereField: UITextField!
    @IBOutlet weak var spherePlate: UIView!
    
    @IBOutlet weak var lastNamePlate: UIView!
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var namePlate: UIView!
    
    @IBOutlet weak var patronymicField: UITextField!
    @IBOutlet weak var patronymicPlate: UIView!
    
    @IBOutlet weak var cityPlate: UIView!
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var addrressPlate: UIView!
    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    @IBOutlet weak var specInfoLabel: UILabel!
    var count = 0
    var isEditMode = false
    var userModel: UserModel?
    
    var lastOffset: CGFloat = 0
    var plates: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteAccountButton.setTitleColor(.red, for: .normal)
        plates = [numberPlate, mailPlate, vkPlate, instagramPlate, facebookPlate, mainSpec, dopSpecOne, dopSpecTwo, dopSpecThree, lastNamePlate, namePlate, patronymicPlate, cityPlate, addrressPlate, spherePlate]
        configurator.configure(with: self)
        presenter.configureView()
        presenter.editMode(edit: false)
        
        nameField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func addSpec(_ sender: Any) {
        presenter.addSpec(pos: count)
    }
    
    @IBAction func editAction(_ sender: Any) {
        presenter.editMode(edit: !isEditMode)
    }
    
    @IBAction func changePrimarySphere() {
        presenter.openSphereList()
    }
    
    @IBAction func deleteAccount() {
        presenter.deleteAccount()
    }
    
    @IBAction func baseSpecAction(_ sender: Any) {
        if count == 0 {
            presenter.openSpec(pos: 0)
        }
    }
    
    
    @IBAction func dopSpecOneAction(_ sender: Any) {
        presenter.openSpec(pos: 1)
    }
    
    @IBAction func dopSpecTwoAction(_ sender: Any) {
        presenter.openSpec(pos: 2)
    }
    
    @IBAction func dopSpecThreeAction(_ sender: Any) {
        presenter.openSpec(pos: 3)
    }
    
    @IBAction func deleteMainSpec(_ sender: Any) {
        presenter.deleteSpec(pos: 0)
    }
    
    @IBAction func deleteSpecOne(_ sender: Any) {
        presenter.deleteSpec(pos: 1)
    }
    
    @IBAction func deleteSpecTwo(_ sender: Any) {
        presenter.deleteSpec(pos: 2)
    }
    
    @IBAction func deleteSpecThree(_ sender: Any) {
        presenter.deleteSpec(pos: 3)
    }
    
    @IBAction func flagAction(_ sender: Any) {
        presenter.openChooseCountry()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter.checkEdit()
    }
}

extension ProfileDetailController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lastOffset = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        var scroll = 0
        switch textField.tag {
        case 0:
            scroll = 0
        case 1:
            scroll = Int(70)
        case 2:
            scroll = Int(140)
        case 3:
            scroll = Int(210)
        case 4:
            scroll = Int(280)
        case 6:
            scroll = Int(height - 530)
        case 7:
            scroll = Int(height - 460)
        case 8:
            scroll = Int(height - 390)
        case 9:
            scroll = Int(height - 320)
        case 10:
            scroll = Int(height - 250)
        default: break
        }
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat(scroll)
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            switch textField.tag {
            case 2:
                if updatedText.count < 7 {
                    return false
                } else {
                    return true
                }
            case 3:
                if updatedText.count < 14 {
                    return false
                } else {
                    return true
                }
            case 4:
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.lastOffset
        }
    }
}
