//
//  NewSubscriptionController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 21.04.2022.
//

import UIKit
import CoreMedia

class NewSubscriptionController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var subsArr: [Subscription] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: NewSubscriptionPresenterProtocol!
    let configurator: NewSubscriptionConfiguratorProtocol = NewSubscriptionConfigurator()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
}

extension NewSubscriptionController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewSubscriptionCell
        cell.configure(object: subsArr[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subObject = subsArr[indexPath.row]
        presenter.openSubList(subObject: subObject)
    }
}
