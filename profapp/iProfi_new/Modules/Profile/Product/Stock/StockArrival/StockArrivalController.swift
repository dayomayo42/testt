//
//  StockArrivalController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import UIKit

struct StockArrivalFillModel {
    var date = ""
    var supplier: Supplier?
    var product: StockProduct?
    var price: Int?
    var count: Int?
}

class StockArrivalController: UIViewController, StockDelegate {
    var presenter: StockArrivalPresenterProtocol!
    let configurator: StockArrivalConfiguratorProtocol = StockArrivalConfigurator()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var currecyLabel: UILabel!
    @IBOutlet weak var countField: UITextField!
    
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var stockList: [StockArrivalFillModel] = []
    var viewList: [ArrivalProductView] = []
    
    var product: StockProduct?
    var client: Client?
    var supplier: Supplier?
    var lastOffset: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.updateDatas()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        var serverList: [StockArrival] = []
        for item in stockList {
            serverList.append(StockArrival(product: ArrivalSimple(id: item.product?.id), dealer: ArrivalSimple(id: item.supplier?.id), priceIn: item.price, dateIn: item.date, count: item.count))
        }
        
        let serverModel = StockArrivalModel(data: serverList)
        presenter.sendArrival(model: serverModel)
    }
    
    @objc func deleteItem(_ recognizer: DeleteRecognizer) {
        if viewList.count > 0 {
            stockList.remove(at: recognizer.id ?? 0)
            presenter.fillStack()
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        self.view.endEditing(true)
        stockList.append(StockArrivalFillModel(date: "", supplier: supplier, product: product, price: priceLabel.text?.toInt(), count: countField.text?.toInt()))
        presenter.fillStack()
        presenter.clearFields()
    }
    
    @IBAction func providerAction(_ sender: Any) {
        presenter.addDealer()
    }
    
    @IBAction func productAction(_ sender: Any) {
        presenter.addProduct()
    }
}

extension StockArrivalController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lastOffset = scrollView.contentOffset.y
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat(textField.tag * 70)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.checkFields()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.lastOffset
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter.checkFields()
        return true
    }
}

class DeleteRecognizer: UITapGestureRecognizer {
    var id: Int?
}
