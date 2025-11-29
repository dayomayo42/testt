//
//  ReviewController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.02.2021.
//

import UIKit
import Cosmos
import StoreKit
import Moya
import RxSwift
import SVProgressHUD

class ReviewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var thnxPlate: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textPlate: UIView!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var starPlate: UIView!
    @IBOutlet weak var background: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
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

    @IBAction func complete(_ sender: Any) {
        if starView.rating < 4 {
            if !starView.isHidden {
                starView.isHidden = true
                textPlate.isHidden = false
            } else if !textPlate.isHidden {
                reviewText.resignFirstResponder()
                bottomConstraint.constant = 0
                textPlate.isHidden = true
                thnxPlate.isHidden = false
            } else {
                sendReview()
            }
        } else {
            if thnxPlate.isHidden && !starView.isHidden  {
                if #available(iOS 14.0, *) {
                    if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                } else if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                }
                starView.isHidden = true
                thnxPlate.isHidden = false
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func sendReview() {
        SVProgressHUD.show()
        service.postReview(text: reviewText.text ?? "", rating: Int(starView.rating)).subscribe { (response) in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                self.dismiss(animated: true, completion: nil)
            } else {
                SVProgressHUD.showError(withStatus: response.message)
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
 
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension ReviewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        bottomConstraint.constant = 300
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        bottomConstraint.constant = 0
    }
}
