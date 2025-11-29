//
//  StockOrdersController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 10.11.2020.
//

import UIKit

class StockOrdersController: UIViewController {

    var presenter: StockOrdersPresenterProtocol!
    let configurator: StockOrdersConfiguratorProtocol = StockOrdersConfigurator()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func allOrdersAction(_ sender: Any) {
        presenter.allOrders()
    }
    
    @IBAction func debtorsAction(_ sender: Any) {
        presenter.debts()
    }
}
