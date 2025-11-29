//
//  ServicesController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 15.10.2020.
//

import UIKit

class ServicesController: UIViewController {

    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ServicesPresenterProtocol!
    let configurator: ServicesConfiguratorProtocol = ServicesConfigurator()
    var headerView: ProductHeaderCell?
    var services: [Service] = []
    var link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        presenter.getServices()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdate), name: NSNotification.Name.ServicesUpdate, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.ServicesUpdate, object: nil)
    }
    
    @objc func onUpdate() {
        presenter.getServices()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func shareAction(_ sender: Any) {
        presenter.shareLink()
    }
    
    @objc func addProductAction() {
        presenter.addService()
    }
}

extension ServicesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil {
            let header = tableView.dequeueReusableCell(withIdentifier: "header") as! ProductHeaderCell
            header.headerTitle.text = "Добавить услугу"
            header.mainPlate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addProductAction)))
            headerView = header
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryDetailCell
        cell.configureService(with: services[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openDetail(model: services[indexPath.row])
    }
}
