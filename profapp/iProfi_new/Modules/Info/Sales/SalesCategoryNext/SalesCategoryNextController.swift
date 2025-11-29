//
//  SalesCategoryNextcController.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation
import UIKit

class SalesCategoryNextController: UIViewController {
    var presenter: SalesCategoryNextPresenterProtocol!
    let configurator: SalesCategoryNextConfiguratorProtocol = SalesCategoryNextConfigurator()
    
    var model: SliderModelSales?
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var headerTitileLabel: UILabel!
    
    @IBOutlet weak var plugView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var headerLabelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        view.bringSubviewToFront(plugView)
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
}

extension SalesCategoryNextController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SalesCategoryNextCell
        if let name = model?.data[indexPath.row]?.name {
            cell.configure(name: name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SalesCategoryNextCell else { return }
        if let id = model?.data[indexPath.row]?.id {
            presenter.getSale(id: id)
        }
    }
}
