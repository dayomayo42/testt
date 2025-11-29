//
//  StockController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.04.2021.
//

import UIKit

class StockController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var presenter: StockPresenterProtocol!
    let configurator: StockConfiguratorProtocol = StockConfigurator()
    var userModel: UserModel?
    let stockCategories: [String] = ["Справочник поставщиков", "Справочник товаров", "Приход товаров", "Расход товаров", "Остаток товаров на складе", "Заказы"]

    @IBOutlet var subPlate: UIView!
    @IBOutlet weak var margin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }

    @IBAction func backActio(_ sender: Any) {
        presenter.backAction()
    }

    @IBAction func subAction(_ sender: Any) {
        presenter.openSubs()
    }
}

extension StockController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stockCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as! ProductStockCell
        cell.configure(with: stockCategories[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presenter.supplierDirectory()
        case 1:
            presenter.productCatalog()
        case 2:
            presenter.productArrival()
        case 3:
            presenter.productConsumption()
        case 4:
            presenter.productRemaining()
        case 5:
            presenter.productOrders()
        default: break
        }
    }
}
