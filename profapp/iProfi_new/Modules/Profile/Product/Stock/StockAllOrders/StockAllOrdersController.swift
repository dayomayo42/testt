//
//  StockAllOrdersController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import UIKit

protocol FilterTypeProtocol: class {
    var type: String? {get set}
}

class StockAllOrdersController: UIViewController, FilterTypeProtocol {
    var type: String? {
        didSet {
            presenter.sortTo(type: type ?? "")
        }
    }
    
    @IBOutlet weak var placeholderView: UIView!
    var orders: [StockOrder] = []
    
    var presenter: StockAllOrdersPresenterProtocol!
    let configurator: StockAllOrdersConfiguratorProtocol = StockAllOrdersConfigurator()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        presenter.getOrders()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }

    @IBAction func filterAction(_ sender: Any) {
        presenter.chooseFilter()
        
    }
}

extension StockAllOrdersController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StockOrderCell
        let obj = orders[indexPath.row]
        cell.configure(name: "\(obj.client?.lastname ?? "") \(obj.client?.name ?? "") \(obj.client?.midname ?? "")", number: obj.id ?? 0, debt: obj.debt ?? 0 > 0 ? obj.debt ?? 0 : 0, date: obj.createdAt?.convertDate(to: 6) ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = orders[indexPath.row]
        presenter.openDetail(model: obj)
    }
    
}
