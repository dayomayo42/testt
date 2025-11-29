//
//  SalesCategoryController.swift
//  iProfi_new
//
//  Created by violy on 15.08.2022.
//

import Foundation
import UIKit

class SalesCategoryController: UIViewController {
    var presenter: SalesCategoryPresenterProtocol!
    let configurator: SalesCategoryConfiguratorProtocol = SalesCategoryConfigurator()
    
    var model: SaleCategoryModel?
    
    @IBOutlet weak var plugView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchModel = SaleCategoryModel(success: true, message: "", data: [])
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        presenter.configureView()
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
        searchModel.data.removeAll()
        model?.data.forEach({ saleCategory in
            if saleCategory.title.lowercased().withoutSpaces().contains(text.lowercased().withoutSpaces()) == true {
                searchModel.data += [saleCategory]
            }
        })

        tableView.reloadData()
        if isSearching && searchModel.data.count == 0 {
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

extension SalesCategoryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearching {
            return model?.data.count ?? 0
        } else {
            return searchModel.data.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SalesCategoryCell
        if !isSearching  {
            if let title = model?.data[indexPath.row].title {
                cell.configure(name: title)
            }
        } else {
            let title = searchModel.data[indexPath.row].title
            cell.configure(name: title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? SalesCategoryCell else { return }
        guard let cellTitle = cell.categoryNameLabel.text else { return }
        
        if !isSearching {
            if let id = model?.data[indexPath.row].id {
                presenter.getSalesByCategory(id: id) { model in
                    self.presenter.openSalesCategoryNext(model: model, categoryName: cellTitle)
                }
            }
        } else {
            let id = searchModel.data[indexPath.row].id
            presenter.getSalesByCategory(id: id) { model in
                self.presenter.openSalesCategoryNext(model: model, categoryName: cellTitle)
            }
        }
    }
}

extension SalesCategoryController: UITextFieldDelegate {
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

