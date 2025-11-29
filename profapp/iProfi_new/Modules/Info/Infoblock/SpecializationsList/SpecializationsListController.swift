//
//  SpecializationsListController.swift
//  iProfi_new
//
//  Created by violy on 28.07.2022.
//

import Foundation
import UIKit

class SpecializationsListController: UIViewController {
    
    @IBOutlet weak var blankPlug: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noSpecPlugView: UIView!
    var userModel: UserModel?
    
    var presenter: SpecializationsListPresenterProtocol!
    let configurator: SpecializationsListConfiguratorProtocol = SpecializationsListConfigurator()
    var model: [Spec]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.checkIsSpecsExisted()
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
    
    @IBAction func confirmAction() {
        presenter.postSpec() {
            self.presenter.backAction()
        }
    }
    
    @IBAction func goToProfileDetailed() {
        if let userModel = userModel {
            presenter.openProfileDetail(userModel: userModel)
        }
    }
}

extension SpecializationsListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpecializationsListCell
        guard let specName = model?[indexPath.row].name else { return UITableViewCell() }
        guard let isSeletcted = model?[indexPath.row].checked else { return UITableViewCell() }
        cell.configure(specName: specName, isSelected: isSeletcted)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SpecializationsListCell else { return }
        
        if cell.isCheckBoxSelected == 1 {
            model?[indexPath.row].checked = 0
            cell.swithCheckBoxState(isSelected: 0)
        } else {
            model?[indexPath.row].checked = 1
            cell.swithCheckBoxState(isSelected: 1)
        }
    }
}
