//
//  FinanceController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import UIKit

class FinanceController: UIViewController {
    var presenter: FinancePresenterProtocol!
    let configurator: FinanceConfiguratorProtocol = FinanceConfigurator()
    let categories: [String] = ["Чистая прибыль", "Доход по услугам", "Расход по услугам", "Доход от продукции", "Другие расходы"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
}

extension FinanceController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FinanceCell
        cell.configure(with: categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openDetail(with: categories[indexPath.row])
    }
}
