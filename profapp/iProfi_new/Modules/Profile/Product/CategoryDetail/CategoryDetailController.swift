//
//  CategoryDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.10.2020.
//

import UIKit

class CategoryDetailController: UIViewController {
    @IBOutlet weak var placeholderView: UIView!
    var presenter: CategoryDetailPresenterProtocol!
    let configurator: CategoryDetailConfiguratorProtocol = CategoryDetailConfigurator()
    var headerView: ProductHeaderCell?
    var category: Category?
    var products: [Product] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getProduct(category: category?.id ?? 0)
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @objc func addProductAction() {
        presenter.addProduct(category: category!)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        presenter.deleteCategory(category: category?.id ?? 0)
    }
}


extension CategoryDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            let header = tableView.dequeueReusableCell(withIdentifier: "header") as! ProductHeaderCell
            header.headerTitle.text = "Добавить"
            header.mainPlate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addProductAction)))
            headerView = header
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryDetailCell
        cell.configureProduct(with: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openDetail(with: products[indexPath.row])
    }
}
