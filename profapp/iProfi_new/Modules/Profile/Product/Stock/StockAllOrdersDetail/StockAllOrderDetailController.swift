//
//  StockAllOrderDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.01.2021.
//

import UIKit

class StockAllOrderDetailController: UIViewController {
    var headerView: StockAllOrdersDetailHeader?
    var model: StockOrder!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension StockAllOrderDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            headerView = tableView.dequeueReusableCell(withIdentifier: "header") as? StockAllOrdersDetailHeader
            headerView?.configure(name: "\(model.client?.lastname ?? "") \(model.client?.name ?? "")", date: model.createdAt?.convertDate(to: 6) ?? "", sum: "\(model.priceOut ?? 0) \(Settings.currencyCym ?? "")")
        }
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StockAllOrdersDetailCell
        let obj = model.products?[indexPath.row]
        cell.configure(name: obj?.name ?? "", count: obj?.count ?? 0, price: obj?.priceOut ?? 0, discount: obj?.discount ?? 0)
        return cell
    }
    
    
}
