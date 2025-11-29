//
//  StockProdutsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import UIKit

class StockProdutsController: UIViewController {
    @IBOutlet weak var placeholderView: UIView!
    var presenter: StockProdutsPresenterProtocol!
    let configurator: StockProdutsConfiguratorProtocol = StockProdutsConfigurator()
    var headerView: ProductHeaderCell?
    var products: [StockProduct] = []
    var productsBuffer: [StockProduct] = []
    var stockDelegate: StockDelegate?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    var link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getProducts()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    
    @IBAction func shareActio(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: [link], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func addProductAction() {
        presenter.addProduct()
    }
}

extension StockProdutsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            let header = tableView.dequeueReusableCell(withIdentifier: "header") as! ProductHeaderCell
            header.headerTitle.text = "Добавить товар"
            header.mainPlate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addProductAction)))
            headerView = header
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductStockCell
        cell.configure(with: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if stockDelegate != nil {
            presenter.chooseProduct(model: products[indexPath.row])
        } else {
            presenter.openDetail(model: products[indexPath.row])
        }
       
    }
}

extension StockProdutsController: UITextFieldDelegate {
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
                products = productsBuffer
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
