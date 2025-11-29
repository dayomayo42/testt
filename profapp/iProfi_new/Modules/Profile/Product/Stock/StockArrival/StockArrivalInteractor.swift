//
//  StockArrivalInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol StockArrivalInteractorProtocol: class {
    func configureView()
    func addDealer()
    func addProduct()
    func updateDatas()
    func checkFields()
    func fillStack()
    func clearFields()
    func clearStack()
    func sendArrival(model: StockArrivalModel)
}

class StockArrivalInteractor: StockArrivalInteractorProtocol {
    weak var viewController: StockArrivalController!
    weak var presenter: StockArrivalPresenterProtocol!
    let dateFormatter = DateFormatter()
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: StockArrivalController, presenter: StockArrivalPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.currecyLabel.text = Settings.currency
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        viewController.countField.inputAccessoryView = toolbar
        viewController.priceLabel.inputAccessoryView = toolbar
        
       
        checkFields()
    }
    
    @objc func doneButtonAction() {
        checkFields()
        viewController.view.endEditing(true)
    }
    
    func updateDatas() {
        if viewController.supplier != nil {
            viewController.providerLabel.text = viewController.supplier?.name
        }
        
        if viewController.product != nil {
            viewController.productLabel.text = viewController.product?.name
            viewController.priceLabel.text = "\(viewController.product?.priceIn ?? 0)"
        }
        
        checkFields()
    }
    
    func addDealer() {
        let vc = viewController.getControllerProfile(controller: .suppliers) as! SuppliersController
        vc.stockDelegate = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addProduct() {
        let vc = viewController.getControllerProfile(controller: .productstock) as! StockProdutsController
        vc.stockDelegate = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkFields() {
        if viewController.supplier != nil && viewController.product != nil && viewController.priceLabel.text?.count ?? 0 > 0 && viewController.countField.text?.count ?? 0 > 0 {
            viewController.addButton.isActive = true
        } else {
            viewController.addButton.isActive = false
        }
    }
    
    func clearStack() {
        for item in viewController.viewList {
            item.isHidden = true
            viewController.stackView.removeArrangedSubview(item)
        }
    }
    
    func clearFields() {
//        viewController.supplier = nil
        viewController.product = nil
        viewController.priceLabel.text = ""
        viewController.countField.text = ""
//        viewController.providerLabel.text = ""
        viewController.productLabel.text = ""
        checkFields()
    }
    
    func fillStack() {
        clearStack()
        viewController.viewList = []
        for index in 0..<(viewController.stockList.count) {
            let item = viewController.stockList[index]
            let stockView = ArrivalProductView()
            stockView.tag = index
            stockView.configureView(name: item.product?.name ?? "", provider: item.supplier?.name ?? "", price: "\(item.price ?? 0) \(Settings.currencyCym ?? "")")
            let recognizer = DeleteRecognizer(target: viewController, action: #selector(viewController.deleteItem(_:)))
            recognizer.id = stockView.tag
            stockView.thrashLabel.addGestureRecognizer(recognizer)
            viewController.stackView.addArrangedSubview(stockView)
            viewController.viewList.append(stockView)
        }
        checkFields()
    }
    
    func sendArrival(model: StockArrivalModel) {
        SVProgressHUD.show()
        
        service.postStockArrival(model: model).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}


