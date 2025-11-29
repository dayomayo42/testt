//
//  LiveJournalListController.swift
//  iProfi_new
//
//  Created by violy on 16.08.2022.
//

import Foundation
import UIKit

enum LiveJournalListType {
    case news
    case article
    case exhibition
}

class LiveJournalListController: UIViewController {
    var presenter: LiveJournalListPresenterProtocol!
    let configurator: LiveJournalListConfiguratorProtocol = LiveJournalListConfigurator()
    
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    var state: LiveJournalListType?
    
    var model: [LiveJournalList]? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        self.view.bringSubviewToFront(placeHolderView)
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
}

extension LiveJournalListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placeHolderView.isHidden = model?.count ?? 0 != 0
        return model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LiveJournalListCell
        var desc: String?
        var dateArr: [String] = []
        if state != .exhibition {
            desc = nil
            dateArr += [model?[indexPath.row].updatedAt ?? ""]
        } else {
            desc = model?[indexPath.row].body
            if model?[indexPath.row].dates?.count ?? 0 > 0 {
            dateArr += [model?[indexPath.row].dates?[0].date ?? ""]
            dateArr += [model?[indexPath.row].dates?[0].dateTill?.date ?? ""]
            } else {
                dateArr += [""]
            }
        }
        cell.configure(imageUrl: model?[indexPath.row].image ?? "", title: model?[indexPath.row].name ?? "" , desc: desc, date: dateArr, type: self.state ?? .news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LiveJournalListCell else { return }
        if let cellId = model?[indexPath.row].id {
            presenter.getJournalItem(id: cellId)
        }
    }
}

