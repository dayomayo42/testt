//
//  CurrencyBottom.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.11.2020.
//

import UIKit

struct CurrencyModel {
    let name: String
    let shortName: String
    let icon: UIImage
    let cymbol: String
}

class CurrencyBottom: UIViewController {

    @IBOutlet weak var background: UIView!
    var currencyList: [CurrencyModel] = [CurrencyModel(name: "Рубль", shortName: "RUB", icon: #imageLiteral(resourceName: "Ruble"), cymbol: "₽"),
                                         CurrencyModel(name: "Белорусский рубль", shortName: "BYN", icon: #imageLiteral(resourceName: "Exclude"), cymbol: "Br"),
                                         CurrencyModel(name: "Гривна", shortName: "UAH", icon: #imageLiteral(resourceName: "Hryvnia"), cymbol: "₴"),
                                         CurrencyModel(name: "Драм", shortName: "AMD", icon: #imageLiteral(resourceName: "Dram"), cymbol: "֏"),
                                         CurrencyModel(name: "Евро", shortName: "EUR", icon: #imageLiteral(resourceName: "Euro"), cymbol: "€"),
                                         CurrencyModel(name: "Крона", shortName: "CZK", icon: #imageLiteral(resourceName: "Krona"), cymbol: "Kč"),
                                         CurrencyModel(name: "Сом", shortName: "KGS", icon: #imageLiteral(resourceName: "Som"), cymbol: "с"),
                                         CurrencyModel(name: "Тенге", shortName: "KZT", icon: #imageLiteral(resourceName: "Tenge"), cymbol: "₸"),
                                         CurrencyModel(name: "Шекель", shortName: "ILS", icon: #imageLiteral(resourceName: "Shekel"), cymbol: "₪")]
    var delegate: CurrencyDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: {
            self.background.alpha = 1
        }, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseOut, animations: {
            self.background.alpha = 0
        }, completion: nil)
    }
    
    @IBAction func closeActio(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension CurrencyBottom: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        cell.configure(title: currencyList[indexPath.row].name, icon: currencyList[indexPath.row].icon)
        
        if tableView.indexPathsForSelectedRows?.contains(indexPath) ?? false {
            cell.selectDot.isHidden = false
        } else {
            cell.selectDot.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CurrencyCell
        cell.selectDot.isHidden = false
        delegate?.model = currencyList[indexPath.row]
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
            let cell = tableView.cellForRow(at: indexPath) as! CurrencyCell
            cell.selectDot.isHidden = true
        }
    }
    
}
