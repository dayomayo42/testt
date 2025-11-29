//
//  RegSphereController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 10.09.2020.
//

import UIKit

struct TestSphereModel {
    let id: Int?
    let title: String?
}

class RegSphereController: UIViewController {
    var presenter: RegSpherePresenter!
    let configurator: RegSphereConfiguratorProtocol = RegSphereConfigurator()
    
    var spherePresenter: RegInfoPresenterProtocol?
    var onSelect: ((SphereModel)->())?
    
    var shouldHideNavigaion: Bool = true
    
    @IBOutlet weak var searhField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var sphereList: [SphereModel] = []
    var searchModel: [SphereModel] = []
    
    @IBAction func backAction() {
        presenter.dismissAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if shouldHideNavigaion {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if shouldHideNavigaion {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
}

extension RegSphereController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sphereList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RegSphereCell
        cell.configure(with: sphereList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        spherePresenter?.configureView(with: sphereList[indexPath.row])
        presenter.dismissAction()
        onSelect?(sphereList[indexPath.row])
    }
}

extension RegSphereController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
