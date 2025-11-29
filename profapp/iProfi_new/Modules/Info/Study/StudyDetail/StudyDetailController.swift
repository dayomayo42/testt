//
//  StudyDetailController.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation
import UIKit

class StudyDetailController: UIViewController {
    var presenter: StudyDetailPresenterProtocol!
    let configurator: StudyDetailConfiguratorProtocol = StudyDetailConfigurator()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var sliderPlate: UIView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var enrollButton: UIButton!
    @IBOutlet weak var headerTitileLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailStudyImageView: UIImageView!
    @IBOutlet weak var detailStudyTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameFieldPlate: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameFieldPlate: UIView!
    @IBOutlet weak var numberFieldPlate: UIView!
    @IBOutlet weak var surNameField: UITextField!
    @IBOutlet weak var enrollButtonPlate: UIView!
    @IBOutlet weak var numberField: PhoneNumberView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pricePlateView: UIView!
    
    var isTextEdited = false
    var scrollEditedOffset: CGFloat = 0
    var delegate: StudySlidesRefreshDelegate?
    var keyboardHeight: CGFloat = 0
    
    var model: SliderStudy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        
        nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        surNameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        numberField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
    
    @IBAction func confirmEnroll() {
        guard let name = nameField.text else { return }
        guard let lastname = surNameField.text else { return }
        guard var number = numberField.text else { return }
        guard let id = model?.id else { return }
        
        number = number.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "")
        
        let model = JoinCourseModel(id: id, name: name, lastname: lastname, phone: number)
        presenter.postJoinCourse(model: model)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let name = nameField.text else { return }
        guard let lastname = surNameField.text else { return }
        guard let number = numberField.text else { return }
        let fields = [name, lastname, number]
        if fields.allSatisfy({ $0.withoutSpaces().count > 0 }) && numberField.isValidNumber {
            enrollButton.isEnabled = true
            enrollButton.backgroundColor = UIColor(named: "appBlue")
        } else {
            enrollButton.isEnabled = false
            enrollButton.backgroundColor = UIColor(named: "buttondismiss")
        }
    }
}

//extension StudyDetailController: UITextFieldDelegate {
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        var frame: CGRect = .zero
//
//        switch textField.tag {
//        case 0:
//            frame = textField.convert(nameFieldPlate.frame, to: scrollView)
//        case 1:
//            frame = textField.convert(surnameFieldPlate.frame, to: scrollView)
//        case 2:
//            frame = textField.convert(numberFieldPlate.frame, to: scrollView)
//        default:
//            break
//        }
//
//        if frame.maxY > (UIScreen.main.bounds.height - 500) {
//            UIView.animate(withDuration: 0.3) {
//                self.scrollView.contentOffset.y = (frame.maxY - (UIScreen.main.bounds.height - 500))
//            } completion: { _ in
//                self.isTextEdited = false
//            }
//        }
//    }
//
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return true
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        view.endEditing(true)
//        return true
//    }
//}
