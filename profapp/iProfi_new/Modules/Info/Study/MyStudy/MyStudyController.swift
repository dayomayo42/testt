//
//  MyStudyController.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation
import UIKit

class MyStudyController: UIViewController {
    var presenter: MyStudyPresenterProtocol!
    let configurator: MyStudyConfiguratorProtocol = MyStudyConfigurator()
    
    @IBOutlet weak var plugView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    var model: [SliderStudy]?
    
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

extension MyStudyController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyStudyCell
        cell.configure(title: model?[indexPath.row].name ?? "", id:  model?[indexPath.row].id ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MyStudyCell else { return }
        if let id = cell.studyID {
            presenter.getStudy(id: id)
        }
    }
}
