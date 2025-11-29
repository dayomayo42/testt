//
//  StockBalanceController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.12.2020.
//

import UIKit

class StockBalanceController: UIViewController {

    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    var products: [StockProduct] = []
    
    var presenter: StockBalancePresenterProtocol!
    let configurator: StockBalanceConfiguratorProtocol = StockBalanceConfigurator()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        bottomView.addShadow(location: .top)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getProducts()
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
}

extension StockBalanceController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StockBalanceCell
        let obj = products[indexPath.row]
        cell.configure(name: obj.name ?? "", price: obj.priceOut ?? 0, count: obj.count ?? 0)
        return cell
    }
    
    
}
