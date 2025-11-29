//
//  SaleDistributorsController.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation
import UIKit

class SalesDistributorsController: UIViewController {
    
    var presenter: SalesDistributorsPresenterProtocol!
    let configurator: SalesDistributorsConfiguratorProtocol = SalesDistributorsConfigurator()
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plugView: UIView!
    
    var model: DistributorsModel?
    var searchModel = DistributorsModel(success: true, message: "", data: [])
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        view.bringSubviewToFront(placeholderView)
        view.bringSubviewToFront(plugView)
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.withoutSpaces().count > 2 {
            isSearching = true
        } else {
            isSearching = false
        }
        searchModel.data?.removeAll()
        model?.data?.forEach({ distributor in
            if distributor.name?.lowercased().withoutSpaces().contains(text.lowercased().withoutSpaces()) == true {
                searchModel.data? += [distributor]
            }
        })
        tableView.reloadData()
        
        if isSearching && searchModel.data?.count == 0 {
            DispatchQueue.main.async {
                self.plugView.isHidden = false
            }
        } else {
            DispatchQueue.main.async {
                self.plugView.isHidden = true
            }
        }
    }
}

extension SalesDistributorsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearching {
            return model?.data?.count ?? 0
        } else {
            return searchModel.data?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SalesDistributorsCell
        if !isSearching {
            cell.configure(categoryName: model?.data?[indexPath.row].name ?? "", logoImageUrl: model?.data?[indexPath.row].image )
        } else {
            cell.configure(categoryName: searchModel.data?[indexPath.row].name ?? "", logoImageUrl: searchModel.data?[indexPath.row].image )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SalesDistributorsCell else { return }
        if !isSearching {
            if let id = model?.data?[indexPath.row].id {
                presenter.getSalesByDistributors(id: id)
            }
        } else {
            if let id = searchModel.data?[indexPath.row].id {
                presenter.getSalesByDistributors(id: id)
            }
        }
    }
}

extension SalesDistributorsController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.contentOffset = .zero
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
