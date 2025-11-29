//
//  RecordsProductsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 26.10.2020.
//

import UIKit

protocol RecordProductDelegate {
    var product: [SortedProduct] { get set }
    var productBuf: [SortedProduct] { get set }
}

class RecordsProductsController: UIViewController, RecordProductDelegate {
    var presenter: RecordsProductsPresenterProtocol!
    let configurator: RecordsProductsConfiguratorProtocol = RecordsProductsConfigurator()
    var product: [SortedProduct] = [] {
        didSet {
            product = product.filter { $0.expandables?.count ?? 0 > 0 }
        }
    }
    var productBuf: [SortedProduct] = []
    var oldproduct: [SortedProduct] = []
    var delegate: RecordProtocol?
    var editdelegate: RecordEditProtocol?
    var cache: RecordEntityCacheProtocol?
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    
        presenter.checkCacheProducts()
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdate), name: NSNotification.Name.ProductsUpdate, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.ProductsUpdate, object: nil)
    }
    
    @objc func onUpdate() {
        presenter.getProduct()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func readyAction(_ sender: Any) {
        presenter.chooseProduct()
    }
    
    @IBAction func addProduct(_ sender: Any) {
        presenter.addProduct()
    }
}

extension RecordsProductsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "header") as! RecordsProductsHeaderCell
        if section == 0 {
            header.configure(with: "")
        } else {
            header.configure(with: product[section - 1].name ?? "")
        }
        
        return header
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return product.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : (product[section - 1].expandables?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "noproduct", for: indexPath) as! RecordNoProductCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecordsProductsCell
            cell.configure(with: product[indexPath.section - 1].expandables![indexPath.row], delegateRec: self, currentIndexPath: IndexPath(row: indexPath.row, section: indexPath.section - 1))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            presenter.chooseNoProduct()
        }
    }
}

extension RecordsProductsController: UITextFieldDelegate {
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
                product = productBuf
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
