//
//  StockConsumptionInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol StockConsumptionInteractorProtocol: class {
    func configureView()
    func addClient()
    func addProduct()
    func updateDatas()
    func checkFields()
    func fillStack()
    func clearFields()
    func clearStack()
    func sendArrival(model: StockConsumptionModel)
}

class StockConsumptionInteractor: StockConsumptionInteractorProtocol {
    weak var viewController: StockConsumptionController!
    weak var presenter: StockConsumptionPresenterProtocol!
    let dateFormatter = DateFormatter()
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: StockConsumptionController, presenter: StockConsumptionPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.currencyLabel.text = Settings.currency
        viewController.payedCurrecy.text = Settings.currency
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        viewController.countField.inputAccessoryView = toolbar
        viewController.priceField.inputAccessoryView = toolbar
        viewController.payedField.inputAccessoryView = toolbar
        viewController.discountField.inputAccessoryView = toolbar
        
        viewController.priceLabel.text = "\(0) \(Settings.currencyCym ?? "")"
        checkFields()
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }
    
    func updateDatas() {
        if viewController.client != nil {
            viewController.clientName.text = viewController.client?.lastname?.count ?? 0 > 0 ? "\(viewController.client?.lastname ?? "") \(viewController.client?.name ?? "")" : "\(viewController.client?.name ?? "")"
        }
        
        if viewController.product != nil {
            viewController.productNamee.text = viewController.product?.name
            viewController.priceField.text = "\(viewController.product?.priceOut ?? 0)"
            viewController.countField.text = "1"
        }
        
        checkFields()
    }
    
    func addClient() {
        let vc = viewController.getControllerClients(controller: .clients) as! ClientsController
        vc.stockDelegate = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addProduct() {
        let vc = viewController.getControllerProfile(controller: .productstock) as! StockProdutsController
        viewController.supplier = nil
        vc.stockDelegate = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkFields() {
        if viewController.client != nil && viewController.product != nil && viewController.priceField.text?.count ?? 0 > 0 && viewController.countField.text?.count ?? 0 > 0 && viewController.payedField.text?.count ?? 0 > 0 {
            viewController.addButton.isActive = true
        } else {
            viewController.addButton.isActive = false
        }
        
        
        let disc = CGFloat(100 - (viewController.discountField.text?.toInt() ?? 0))/100
        
        let sum = CGFloat(viewController.priceField.text?.toInt() ?? 0) * disc * CGFloat((viewController.countField.text?.toInt() ?? 0))
        viewController.priceLabel.text = "\(Int(sum)) \(Settings.currencyCym ?? "")"
    }
    
    func clearStack() {
        for item in viewController.viewList {
            item.isHidden = true
            viewController.stackView.removeArrangedSubview(item)
        }
    }
    
    func clearFields() {
//        viewController.client = nil
        viewController.product = nil
        viewController.priceField.text = ""
        viewController.countField.text = ""
//        viewController.clientName.text = ""
        viewController.productNamee.text = ""
        viewController.discountField.text = ""
        viewController.payedField.text = ""
        viewController.priceLabel.text = "\(0) \(Settings.currencyCym ?? "")"
        checkFields()
    }
    
    func fillStack() {
        clearStack()
        viewController.viewList = []
        for index in 0..<(viewController.stockList.count) {
            let item = viewController.stockList[index]
            let stockView = ArrivalProductView()
            stockView.tag = index
            stockView.configureView(name: item.product?.name ?? "", provider: item.client?.lastname?.count ?? 0 > 0 ? "\(item.client?.lastname ?? "") \(item.client?.name ?? "")" : "\(viewController.client?.name ?? "")", price: "\((item.price ?? 0)) \(Settings.currencyCym ?? "")")
            let recognizer = DeleteRecognizer(target: viewController, action: #selector(viewController.deleteItem(_:)))
            recognizer.id = stockView.tag
            stockView.thrashLabel.addGestureRecognizer(recognizer)
            viewController.stackView.addArrangedSubview(stockView)
            viewController.viewList.append(stockView)
        }
        checkFields()
    }
    
    func sendArrival(model: StockConsumptionModel) {
        SVProgressHUD.show()
        service.postStockConsumption(model: model).subscribe { (response) in
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


