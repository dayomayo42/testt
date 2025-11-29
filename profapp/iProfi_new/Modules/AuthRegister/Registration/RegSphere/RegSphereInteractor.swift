//
//  RegSphereInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.09.2020.
//

import Foundation
import UIKit

protocol RegSphereInteractorProtocol: class {
    func configureView()
}

class RegSphereInteractor: RegSphereInteractorProtocol {
    weak var viewController: RegSphereController!
    weak var presenter: RegSpherePresenterProtocol!

    init(viewController: RegSphereController, presenter: RegSpherePresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        guard let vc = viewController else { return }
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: vc.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        vc.searhField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        guard let vc = viewController else { return }
        vc.view.endEditing(true)
    }
}
