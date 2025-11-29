//
//  UserNotificationAlert.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2021.
//

import UIKit
import SVProgressHUD

class UserNotificationAlert: UIViewController {
    var delegate: NotifAlertDelegate?

    @IBOutlet weak var messagePlateTop: NSLayoutConstraint!
    @IBOutlet weak var messagePlate: UIView!
    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: {
            self.backView.alpha = 1
        }, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseOut, animations: {
            self.backView.alpha = 0
        }, completion: nil)
    }

    func configure() {
        if delegate?.client?.image?.count ?? 0 > 0 {
            avatarView.af_setImage(withURL: URL(string: delegate?.client?.image ?? "")!)
        }
        
        nameLabel.text = delegate?.client?.name
        numberLabel.text = delegate?.client?.phone
        messageLabel.text = delegate?.message
    }

    @IBAction func closeAction(_ sender: Any) {
        if delegate?.dismissAfter ?? false {
            dismiss(animated: true) {
                self.delegate?.dismissAll = true
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func backCloseAction(_ sender: Any) {
        if delegate?.dismissAfter ?? false {
            dismiss(animated: true) {
                self.delegate?.dismissAll = true
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func smsAction(_ sender: Any) {
        let sms: String = "sms:\(delegate?.client?.phone ?? "")&body=\(delegate?.message ?? "")"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL(string: strURL)!, options: [:], completionHandler: nil)
        
        if delegate?.dismissAfter ?? false {
            dismiss(animated: true) {
                self.delegate?.dismissAll = true
            }
        } else {
            delegate?.needUpdate = true
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func whatsAppAction(_ sender: Any) {
        let urlWhats = "whatsapp://send?phone=\(delegate?.client?.phone ?? "")&text=\(delegate?.message ?? "")"

        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.insert(charactersIn: "?&")

        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: characterSet) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL as URL)
                    } else {
                        UIApplication.shared.openURL(whatsappURL as URL)
                    }
                } else {
                    print("Install Whatsapp")
                }
            }
        }
        
        if delegate?.dismissAfter ?? false {
            dismiss(animated: true) {
                self.delegate?.dismissAll = true
            }
        } else {
            delegate?.needUpdate = true
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func telegramAction(_ sender: Any) {
        let urlWhats = "tg://msg?text=\(delegate?.message ?? "")&to=\(delegate?.client?.phone ?? "")"

        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.insert(charactersIn: "?&")

        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: characterSet) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL as URL)
                    } else {
                        UIApplication.shared.openURL(whatsappURL as URL)
                    }
                } else {
                    print("Install Whatsapp")
                }
            }
        }
        
        if delegate?.dismissAfter ?? false {
            dismiss(animated: true) {
                self.delegate?.dismissAll = true
            }
        } else {
            delegate?.needUpdate = true
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func copyAction(_ sender: Any) {
        UIPasteboard.general.string = delegate?.message
//        UIView.animate(withDuration: 1) {
//            self.messagePlate.alpha = 1
//        } completion: { complete in
//            if complete {
//                UIView.animate(withDuration: 0.8, animations: {
//                    self.messagePlate.alpha = 0
//                }, completion: nil)
//
//            }
//        }
               
        if self.delegate?.dismissAfter ?? false {
            self.dismiss(animated: true) {
                self.delegate?.dismissAll = true
            }
        } else {
            self.delegate?.needUpdate = true
            self.dismiss(animated: true, completion: nil)
        }

        
    }
}
