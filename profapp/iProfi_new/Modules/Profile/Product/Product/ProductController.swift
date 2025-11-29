//
//  ProductController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 07.10.2020.
//

import UIKit

class ProductController: UIViewController {
    @IBOutlet weak var placeholderView: UIView!
    
    let stockCategories: [String] = ["Справочник поставщиков", "Справочник товаров", "Приход товаров", "Расход товаров", "Остаток товаров на складе", "Заказы"]
    var presenter: ProductPresenterProtocol!
    let configurator: ProductConfiguratorProtocol = ProductConfigurator()
    var headerView: ProductHeaderCell?
    var categories: [Category] = []
    @IBOutlet var tableView: UITableView!
    var userModel: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        
        presenter.getCategories()
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdate), name: NSNotification.Name.ProductsUpdate, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.ProductsUpdate, object: nil)
    }
    
    @objc func onUpdate() {
        presenter.getCategories()
    }

    @objc func addProductAction() {
        presenter.addCategory()
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
}

extension ProductController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            let header = tableView.dequeueReusableCell(withIdentifier: "header") as! ProductHeaderCell
            header.headerTitle.text = "Добавить категорию"
            header.mainPlate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addProductAction)))
            headerView = header
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        78
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        cell.configureCategory(with: categories[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openCategory(category: categories[indexPath.row])
    }
}
