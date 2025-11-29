//
//  RecordsProductCategoryController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.01.2021.
//

import UIKit

class RecordsProductCategoryController: UIViewController {
    @IBOutlet weak var placeholderView: UIView!
    var presenter: RecordsProductCategoryPresenterProtocol!
    let configurator: RecordsProductCategoryConfiguratorProtocol = RecordsProductCategoryConfigurator()
    var categories: [Category] = []
    var headerView: ProductHeaderCell?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getCategories()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @objc func addProductAction() {
        presenter.addCategory()
    }
}
 
extension RecordsProductCategoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            let header = tableView.dequeueReusableCell(withIdentifier: "header") as! ProductHeaderCell
            header.headerTitle.text = "Добавить категорию"
            header.mainPlate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addProductAction)))
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
