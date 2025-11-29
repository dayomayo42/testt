//
//  SuppliersController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import UIKit

class SuppliersController: UIViewController {
    var presenter: SuppliersPresenterProtocol!
    let configurator: SuppliersConfiguratorProtocol = SuppliersConfigurator()
    var headerView: ProductHeaderCell?
    var suppliers: [Supplier] = []
    var suppliersBuffer: [Supplier] = []
    var stockInteractor: StockProductAddInteractor?
    var stockDetailInteractor: StockProductDetailInteractor?
    var stockDelegate: StockDelegate?
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getSuppliers()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @objc func addSupplierAction() {
        presenter.addAction()
    }
}

extension SuppliersController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            let header = tableView.dequeueReusableCell(withIdentifier: "header") as! ProductHeaderCell
            header.headerTitle.text = "Добавить поставщика"
            header.mainPlate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addSupplierAction)))
            headerView = header
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        suppliers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductStockCell
        cell.configure(with: suppliers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if stockDelegate != nil {
            presenter.chooseSupplier(with: suppliers[indexPath.row])
        } else {
            presenter.detailAction(with: suppliers[indexPath.row])
        }
        
    }
}

extension SuppliersController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.contentInset.bottom = 380
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.contentInset.bottom = 0
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if updatedText.count > 0 {
                presenter.search(string: updatedText)
            } else {
                suppliers = suppliersBuffer
                tableView.reloadData()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
