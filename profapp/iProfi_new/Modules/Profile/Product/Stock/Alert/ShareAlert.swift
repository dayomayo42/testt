//
//  ShareAlert.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 19.10.2020.
//

import UIKit

class ShareAlert: UIViewController {
    
    @IBOutlet weak var background: UIView!
    var link: String = ""
    
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
    
    @IBAction func copyLink(_ sender: Any) {
        UIPasteboard.general.string = link
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func socialAction(_ sender: Any) {
        let shareText = "\(link)"
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        present(vc, animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
