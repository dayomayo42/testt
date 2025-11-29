//
//  StockConsumptionController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 11.12.2020.
//

import UIKit

protocol StockDelegate: class {
    var product: StockProduct? {get set}
    var client: Client? {get set}
    var supplier: Supplier? {get set}
}

struct StockConsumptionFillModel {
    var date = ""
    var client: Client?
    var product: StockProduct?
    var price: Int?
    var discount: Int?
    var count: Int?
    var payed: Int?
}

class StockConsumptionController: UIViewController, StockDelegate {
    var presenter: StockConsumptionPresenterProtocol!
    let configurator: StockConsumptionConfiguratorProtocol = StockConsumptionConfigurator()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var productNamee: UILabel!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var discountField: UITextField!
    @IBOutlet weak var countField: UITextField!
    @IBOutlet weak var payedField: UITextField!
    @IBOutlet weak var payedCurrecy: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    var stockList: [StockConsumptionFillModel] = []
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
        var serverList: [StockConsumption] = []
        for item in stockList {
            serverList.append(StockConsumption(product: ArrivalSimple(id: item.product?.id ?? 0), client: ArrivalSimple(id: item.client?.id ?? 0), dateOut: item.date, priceOut: item.price, discount: item.discount, paid: item.payed, count: item.count))
        }
        
        let serverModel = StockConsumptionModel(data: serverList)
        presenter.sendArrival(model: serverModel)
    }
    
    @IBAction func clietAction(_ sender: Any) {
        presenter.addClient()
    }
    
    @IBAction func productAction(_ sender: Any) {
        presenter.addProduct()
    }
    
    @objc func deleteItem(_ recognizer: DeleteRecognizer) {
        if viewList.count > 0 {
            stockList.remove(at: recognizer.id ?? 0)
            presenter.fillStack()
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        self.view.endEditing(true)
        stockList.append(StockConsumptionFillModel(date: "", client: client, product: product, price: priceField.text?.toInt() ?? 0, discount: discountField.text?.toInt(), count: countField.text?.toInt() ?? 0, payed: payedField.text?.toInt() ?? 0))
        presenter.fillStack()
        presenter.clearFields()
    }
}

extension StockConsumptionController: UITextFieldDelegate {
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
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField == discountField {
                if updatedText.toInt() ?? 0 > 100 {
                    return false
                } else {
                    return true
                }
            }
        }
        return true
    }
}
