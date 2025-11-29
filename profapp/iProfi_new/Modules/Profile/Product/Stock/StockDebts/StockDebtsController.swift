//
//  StockDebtsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import UIKit

class StockDebtsController: UIViewController {

    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var presenter: StockDebtsPresenterProtocol!
    let configurator: StockDebtsConfiguratorProtocol = StockDebtsConfigurator()
    var debtors: [DebtsUser] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getDebtors()
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
}


extension StockDebtsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debtors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StockOrderCell
        let obj = debtors[indexPath.row]
        cell.configure(name: obj.name ?? "", number: 0, debt: obj.debt ?? 0, date: obj.date ?? "")
       // print(obj.orders)
        cell.configureNumber(number: obj.orders ?? [])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openDetail(with: debtors[indexPath.row])
    }
    
}
