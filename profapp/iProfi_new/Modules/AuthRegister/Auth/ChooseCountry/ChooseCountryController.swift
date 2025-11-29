//
//  ChooseCountryController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import UIKit

class ChooseCountryController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var countryList: [CountriesModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var presenter: ChooseCountryPresenter!
    var authPresenter: ChooseCountryDelegate!
    let configurator: ChooseCountryConfiguratorProtocol = ChooseCountryConfigurator()
    
    @IBOutlet weak var navView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView(with: self)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension ChooseCountryController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountryCell
        cell.configure(from: countryList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        authPresenter.configureView(from: countryList[indexPath.row])
        presenter.dismissAction()
    }
}
