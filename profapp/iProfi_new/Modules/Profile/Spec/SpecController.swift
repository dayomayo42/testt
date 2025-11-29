//
//  SpecController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 24.10.2020.
//

import UIKit

class SpecController: UIViewController {
    var presenter: SpecPresenterProtocol!
    let configurator: SpecConfiguratorProtocol = SpecConfigurator()
    var specs: [Spec] = []
    var inter: ProfileDetailInteractor?
    var pos: Int = 0
    var sphereID: String = ""
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getSpec()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
}

extension SpecController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        specs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RegSphereCell
        cell.configureSpec(with: specs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectSpec(spec: specs[indexPath.row])
    }
}
