//
//  AnswerController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import UIKit
import WebKit

class AnswerController: UIViewController {
    var presenter: AnswerPresenterProtocol!
    let configurator: AnswerConfiguratorProtocol = AnswerConfigurator()
    
    @IBOutlet weak var webView: WKWebView!
    //  @IBOutlet weak var tableView: UITableView!
    var list: [AnswerQuest] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
     //   presenter.getQuest()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
}

//extension AnswerController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        list.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnswerCell
//        cell.configure(with: list[indexPath.row])
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.openDetail(model: list[indexPath.row])
//    }
//}
