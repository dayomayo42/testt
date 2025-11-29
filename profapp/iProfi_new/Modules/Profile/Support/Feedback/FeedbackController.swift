//
//  FeedbackController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import UIKit

class FeedbackController: UIViewController {
    var presenter: FeedbackPresenterProtocol!
    let configurator: FeedbackConfiguratorProtocol = FeedbackConfigurator()
    
    @IBOutlet weak var namePlate: UIView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var mailPlate: UIView!
    @IBOutlet weak var mailLabel: UITextField!
    @IBOutlet weak var tetxtPlate: UIView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func sendAction(_ sender: Any) {
        presenter.sendAction()
    }
}

extension FeedbackController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = textField.tag == 1 ? 80 : 0
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
        presenter.checkView()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter.checkView()
        return true
    }
}

extension FeedbackController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 160
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
        presenter.checkView()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        presenter.checkView()
        return true
    }
}
