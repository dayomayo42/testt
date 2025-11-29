//
//  RecordsDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import UIKit
import SVProgressHUD

enum RecordsType {
    case now
    case future
    case cancelled
    case ended
}

protocol RecordEditProtocol {
    var model: Records? {get set}
    var presenter: RecordDetailPresenterProtocol! {get set}
    var originalProduct: [SortedProduct]? {get set}
    var notificTime: RecordsNotifTypeModel? {get set}
    var clientNotificTime: RecordsNotifTypeModel? {get set}
}

protocol RecordsDateEditDelegate {
    var parentVC: RecordDetailController? {get set}
    var dateString: String {get set}
    var records: [Records] {get set}
}

class RecordDetailController: UIViewController, RecordEditProtocol, RecordsDateEditDelegate, NotifAlertDelegate, RecordEntityCacheProtocol {
    
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var photoBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var shareHeight: NSLayoutConstraint!
    @IBOutlet weak var usersStackView: UIStackView!
    
    var parentVC: RecordDetailController?
    var dateString: String = ""
    var records: [Records] = []
    
    var originalProduct: [SortedProduct]?
    var presenter: RecordDetailPresenterProtocol!
    let configurator: RecordDetailConfiguratorProtocol = RecordDetailConfigurator()
    var model: Records?
    var type: RecordsType = .future
    var notificationDelegate: NotificationDelegate?
    
    //NotifAlertDelegate
    var notiId: Int?
    var needUpdate: Bool?
    var dismissAfter: Bool?
    var client: Client?
    var message: String?
    var dismissAll: Bool? {
        didSet {
            if dismissAll ?? false {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    var recordCache = RecordsEntityCache()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //user
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    //service
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var serviceStack: UIStackView!
    @IBOutlet weak var serviceView: UIView!
    
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
    @IBOutlet weak var dateView: UIView!
    
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productLabel: UILabel!
    
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var noteField: UITextView!
    
    @IBOutlet weak var notifView: UIView!
    @IBOutlet weak var notificLabel: UILabel!
    
    @IBOutlet weak var notifClientView: UIView!
    @IBOutlet weak var notifClientLabel: UILabel!
    
    @IBOutlet weak var rightPhoto: UIImageView!
    @IBOutlet weak var leftPhoto: UIImageView!
    
    @IBOutlet weak var endButtonPlate: UIView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var buttonPlate: UIView!
    
    @IBOutlet weak var repeateRecordView: UIView!
    
    var plates: [UIView] = []
    
    var isEditMode = false
    
    var photoURLBefore: URL?
    var photoURLAfter: URL?
    
    var notificTime: RecordsNotifTypeModel?// = RecordsNotifTypeModel(name: "За 2 часа", serverName: 120)
    var clientNotificTime: RecordsNotifTypeModel?
    
    var active: Int?
    
    var lastOffset: CGFloat = 0
    
    var fromNotific = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parentVC = self
        plates = [userView, serviceView, priceView, discountView, durationView, dateView, productView, noteView, leftPhoto, rightPhoto, notifView, notifClientView]
        configurator.configure(with: self)
        presenter.configureView()
        presenter.editMode(edit: isEditMode, initMode: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.configureView(with: model!)
//        presenter.configureView(with: model!)
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func editModeAction(_ sender: Any) {
        presenter.editMode(edit: !isEditMode, initMode: false)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        if model?.imageBefore != "" && model?.imageAfter != ""  {
            SVProgressHUD.show()
            presenter.sharePhoto(left: model?.imageBefore ?? "", right: model?.imageAfter ?? "")
        }
    }
    
    func checkFields() {
    
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        let alert = UIAlertController(title: "Удаление записи", message: "Вы действительно хотите удалить запись?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { action in
            self.presenter.deleteRecord()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in

        }))
        self.present(alert, animated: true)
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
    @IBAction func notifClientAction(_ sender: Any) {
        presenter.chooseNotifTime(client: true)
    }
    
    @IBAction func completeRecord(_ sender: Any) {
        presenter.endRecord(id: model?.id ?? 0)
    }
    
    @IBAction func dateTimeAction(_ sender: Any) {
        presenter.openDate()
    }
    
    @IBAction func productAction(_ sender: Any) {
        presenter.chooseProduct()
    }
    
    @IBAction func cancelRecordAction(_ sender: Any) {
        let alert = UIAlertController(title: "Отмена записи", message: "Вы действительно хотите отменить запись?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: { action in
            self.presenter.cancelRecord()
        }))
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: { action in

        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func rightPhotoAction(_ sender: Any) {
        active = 1
        presenter.choosePhoto()
    }
    
    @IBAction func leftPhotoAction(_ sender: Any) {
        active = 0
        presenter.choosePhoto()
    }
    
    @IBAction func repeateAction(_ sender: Any) {
        presenter.repeateRecord()
    }
    
}

extension RecordDetailController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let pos = textField.tag == 3 ? priceView.frame.minY : textField.tag == 4 ? discountView.frame.minY : durationView.frame.minY
        lastOffset = scrollView.contentOffset.y
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
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.lastOffset
        }
    }
}

extension RecordDetailController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.noteView.frame.minY - 120
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
    }
}

extension RecordDetailController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        if let url = info[.imageURL] as? URL {
            if self.active == 0 {
                self.photoURLBefore = url
            } else {
                self.photoURLAfter = url
            }
            
            if self.active == 0 {
                self.leftPhoto.image = image
            } else {
                self.rightPhoto.image = image
            }
            
            let urlStr = active == 0 ? photoURLBefore : photoURLAfter
            print("asdasd", active == 0 ? photoURLBefore : photoURLAfter)
            if urlStr != nil {
                presenter.postPhoto(url: urlStr!, side: active ?? 0)
            }
//            photoURL = url
        } else if let img = info[.originalImage] as? UIImage {
            img.saveToCameraRoll { url in
                if let url = url {
                    print(url)
//                    self.photoURL = url
                    if self.active == 0 {
                        self.photoURLBefore = url
                    } else {
                        self.photoURLAfter = url
                    }
                    
                    if self.active == 0 {
                        self.leftPhoto.image = image
                    } else {
                        self.rightPhoto.image = image
                    }
                    
                    let urlStr = self.active == 0 ? self.photoURLBefore : self.photoURLAfter
                    print("asdasd", self.active == 0 ? self.photoURLBefore : self.photoURLAfter)
                    if urlStr != nil {
                        self.presenter.postPhoto(url: urlStr!, side: self.active ?? 0)
                    }
                }
            }
        }
//        avatarView.image = image
//        presenter.postPhoto()
        picker.dismiss(animated: true, completion: nil)
    }
}
