//
//  FilterTypeController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import UIKit
class FilterTypeAlert: UIViewController {
    
    @IBOutlet weak var background: UIView!
    var delegate: FilterTypeProtocol?
    
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
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func lowriderType(_ sender: Any) {
        delegate?.type = "low"
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stupidShitType(_ sender: Any) {
        delegate?.type = "height"
        self.dismiss(animated: true, completion: nil)
    }
}
