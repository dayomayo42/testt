//
//  NotificationDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 03.12.2020.
//

import UIKit

protocol NotificationDelegate {
    var record: Records? {get set}
}

class NotificationDetailController: UIViewController, NotificationDelegate {
    
    @IBOutlet weak var cometLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    var record: Records?
    var status: Int?
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var serviceStack: UIStackView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    var presenter: NotificationDetailPresenterProtocol!
    let configurator: NotificationDetailConfiguratorProtocol = NotificationDetailConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.configureView()
    }
    
    @IBAction func editAction(_ sender: Any) {
        presenter.editAction(with: record!, type: .future)
    }
    
    @IBAction func phoeAction(_ sender: Any) {
        // TODO: переделать
//        presenter.openPhone(with: record?.client?.phone ?? "")
    }
    

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        presenter.postAccept(id: record?.id ?? 0)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        presenter.postCancel(id: record?.id ?? 0)
    }
}
