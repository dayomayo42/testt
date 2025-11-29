//
//  StudyListController.swift
//  iProfi_new
//
//  Created by violy on 12.08.2022.
//

import Foundation
import UIKit


class StudyListController: UIViewController {
    var presenter: StudyListPresenterProtocol!
    let configurator: StudyListConfiguratorProtocol = StudyListConfigurator()
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var placeHolder: UIView!
    
    var model: SliderModelStudy?
    var headerName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        self.view.bringSubviewToFront(placeHolder)
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
}

extension StudyListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placeHolder.isHidden = model?.data?.count ?? 0 != 0
        return model?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudyListCell
        guard let specName = model?.data?[indexPath.row].name else { return UITableViewCell() }
        cell.configure(title: specName, imageUrl: model?.data?[indexPath.row].image ?? "", id: model?.data?[indexPath.row].id ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? StudyListCell else { return }
        if let id = cell.studyId {
            presenter.getStudy(id: id)
        }
    }
}
