//
//  RecordsCreateController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import UIKit

protocol RecordsDateDelegate {
    var parentVC: RecordsCreateController? {get set}
    var dateString: String {get set}
    var records: [Records] {get set}
}

struct RecordCreateFillModel {
    var client: [Client]?
    var services: [Service]?
    var product: [Product]?
    var originalProduct: [SortedProduct]?
    var notificTime: RecordsNotifTypeModel = RecordsNotifTypeModel(name: "Не напоминать", serverName: 0)
    var clientNotificTime: RecordsNotifTypeModel = RecordsNotifTypeModel(name: "Не напоминать", serverName: 0)
}

protocol RecordEntityCacheProtocol {
    var recordCache: RecordsEntityCache { get set }
}

protocol RecordProtocol {
    var model: RecordCreateFillModel {get set}
    var presenter: RecordsCreatePresenterProtocol! {get set}
}

protocol NotifAlertDelegate {
    var dismissAll: Bool? {get set}
    var dismissAfter: Bool? {get set}
    var message: String? {get set}
    var client: Client? {get set}
    var notiId: Int? {get set}
    var needUpdate: Bool? {get set}
}

class RecordsCreateController: UIViewController, RecordProtocol, RecordsDateDelegate, NotifAlertDelegate, RecordEntityCacheProtocol {
    //NotifAlertDelegate
    var notiId: Int?
    var needUpdate: Bool?
    var dismissAfter: Bool?
    var client: Client?
    var message: String?
    
    var dismissAll: Bool? {
        didSet {
            if dismissAll ?? false {
                if repeate {
                    self.navigationController?.popToViewController(ofClass: RecordsCalendarController.self, animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    var parentVC: RecordsCreateController?
    var dateString: String = ""
    var records: [Records] = []
    var oldRecord: Records?
    var repeate: Bool = false
    var recordCache = RecordsEntityCache()
    
    var model: RecordCreateFillModel = RecordCreateFillModel()
    var presenter: RecordsCreatePresenterProtocol!
    let configurator: RecordsCreateConfiguratorProtocol = RecordsCreateConfigurator()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var clientNotifPlate: UIView!
    //user
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var addUserView: UIView!
    //service
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var serviceStack: UIStackView!
    //price
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var currencyView: UILabel!
    @IBOutlet weak var discountField: UITextField!
    
    //duration
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var durationView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var productLabel: UILabel!
    
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var noteField: UITextView!
    @IBOutlet weak var usersStackView: UIStackView!
    
    @IBOutlet weak var notificView: UILabel!
    @IBOutlet weak var clientNoticeView: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    var lastOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.configureView(with: model)
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    func checkFields() {
    
    }
    
    @IBAction func clientNoticeAction(_ sender: Any) {
        presenter.chooseNotifTime(client: true)
    }
    
    @IBAction func changeUserAction(_ sender: Any) {
        presenter.chooseClient()
    }
    
    @IBAction func addUserAction(_ sender: Any) {
        presenter.chooseClient()
    }
    
    @IBAction func serviceEditAction(_ sender: Any) {
        presenter.chooseService()
    }

    @IBAction func notificationAction(_ sender: Any) {
        presenter.chooseNotifTime(client: false)
    }
    
    @IBAction func productAction(_ sender: Any) {
        presenter.chooseProduct()
    }
    
    @IBAction func addAction(_ sender: Any) {
        if model.product == nil {
            model.product = []
        }
        presenter.checkAndPost(model: CreateRecordModel(client: model.client, expandables: model.product, services: model.services, price: priceField.text?.toInt() ?? 0, discount: discountField.text?.toInt() ?? 0, duration: durationField.text?.toInt() ?? 0, date: dateString, note: noteField.text, reminder: model.notificTime.serverName, reminderClient: model.clientNotificTime.serverName))
    }
    
    @IBAction func dateAction(_ sender: Any) {
        presenter.openDate()
    }
}

extension RecordsCreateController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lastOffset = scrollView.contentOffset.y
        let pos = textField.tag == 3 ? priceView.frame.minY : textField.tag == 4 ? discountView.frame.minY : durationView.frame.minY
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = pos - 120//CGFloat(textField.tag * 90)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        checkFields()
        if let text = textField.text, let textRange = Range(range, in: String(text)) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField == discountField {
                if updatedText.toInt() ?? 0 > 100 {
                    return false
                } else {
                    return true
                }
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        presenter.checkFill()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.lastOffset
        }
    }
}

extension RecordsCreateController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.noteView.frame.minY - 120
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        presenter.checkFill()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
    }
}
