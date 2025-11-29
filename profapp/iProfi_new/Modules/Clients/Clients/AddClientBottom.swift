//
//  AddClientBottom.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 30.11.2020.
//

import UIKit

enum AddClientType {
    case manual
    case contact
}

class AddClientBottom: UIViewController {
    
    @IBOutlet weak var background: UIView!
    var delegate: ClientDelegate?
    
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
    
    @IBAction func contactsType(_ sender: Any) {
        delegate?.type = .contact
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func jerkType(_ sender: Any) {
        delegate?.type = .manual
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

