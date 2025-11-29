//
//  StockDebtsDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.11.2020.
//

import UIKit

protocol UpdateDebDelegate: class {
    var model: DebtsUser? {get set}
    var editId: Int? {get set}
}

class StockDebtsDetailController: UIViewController, UpdateDebDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: StockDebtsDetailPresenterProtocol!
    let configurator: StockDebtsDetailConfiguratorProtocol = StockDebtsDetailConfigurator()
    
    var editId: Int?
    var model: DebtsUser?
    var orderList: [Debconsumption] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    //    presenter.sortList()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
}

extension StockDebtsDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.orderList?.count ?? 0 // orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StockDebtsCell
        let obj = model?.orderList![indexPath.row]
        var names = ""
        for item in obj?.products ?? [] {
            names += ", \(item.name ?? "") x\(item.count ?? 0)"
        }
        
        names = "\(names.dropFirst(2))"
        let debt = (obj?.priceOut ?? 0) - (obj?.paid ?? 0)
        cell.configure(product: "\(names)", debt: debt, title: "Заказ № \(obj?.id ?? 0) - \(obj?.dateOut?.convertDate(to: 6) ?? "")")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editId = model?.orderList![indexPath.row].id
        presenter.openDetail()
    }
}
