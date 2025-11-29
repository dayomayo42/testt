//
//  RecordDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 27.10.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

protocol RecordDetailInteractorProtocol: class {
    func configureView()
    func configureView(with model: RecordCreateFillModel)
    func chooseNotifTime(client: Bool)
    func postRecord(model: Records)
    func editMode(edit: Bool, initMode: Bool)
    func configureView(with model: Records)
    func cancelRecord()
    func choosePhoto()
    func postPhoto(url: URL, side: Int)
    func openDate()
    func sharePhoto(left: String, right: String)
    func endRecord(id: Int)
    func deleteRecord() 
}

class RecordDetailInteractor: RecordDetailInteractorProtocol {
    weak var viewController: RecordDetailController!
    weak var presenter: RecordDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    let dateFormatter = DateFormatter()
    var leftUrl: String?
    var rightUrl: String?
    var userInfo: [String: Records] = [:]

    let list: [RecordsNotifTypeModel] = [RecordsNotifTypeModel(name: "За 15 минут", serverName: 15), RecordsNotifTypeModel(name: "За 30 минут", serverName: 30), RecordsNotifTypeModel(name: "За 45 минут", serverName: 45), RecordsNotifTypeModel(name: "За 1 час", serverName: 60), RecordsNotifTypeModel(name: "За 2 часа", serverName: 120), RecordsNotifTypeModel(name: "За 1 день", serverName: 1440), RecordsNotifTypeModel(name: "Не напоминать", serverName: 0)]

    init(viewController: RecordDetailController, presenter: RecordDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = UIColor(named: "appBlue")
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()

        viewController.priceField.inputAccessoryView = toolbar
        viewController.discountField.inputAccessoryView = toolbar
        viewController.durationField.inputAccessoryView = toolbar
        viewController.noteField.inputAccessoryView = toolbar
        let model = viewController.model!

        viewController.priceField.isUserInteractionEnabled = false
        viewController.durationField.isUserInteractionEnabled = false
        viewController.dateLabel.text = model.date
        viewController.noteField.text = model.note
        viewController.durationField.text = "\(model.duration ?? 0)"
        viewController.discountField.text = "\(model.discount ?? 0)"
        viewController.priceField.text = "\(model.price ?? 0)"
        viewController.currencyView.text = Settings.currency
        
        switch viewController.type {
        case .now:
            viewController.repeateRecordView.isHidden = true
            viewController.buttonPlate.isHidden = true
            viewController.editButton.isHidden = false
            viewController.notifView.isHidden = true
            viewController.shareView.isHidden = true
            viewController.endButtonPlate.isHidden = false
            viewController.photoBottomSpace.constant = 16
        case .future:
            viewController.repeateRecordView.isHidden = true
            viewController.buttonPlate.isHidden = false
            viewController.editButton.isHidden = false
            viewController.notifView.isHidden = false
            viewController.shareView.isHidden = true
            viewController.endButtonPlate.isHidden = true
            viewController.photoBottomSpace.constant = 16
        case .cancelled:
            viewController.repeateRecordView.isHidden = false
            viewController.buttonPlate.isHidden = true
            viewController.editButton.isHidden = true
            viewController.notifView.isHidden = true
            viewController.shareView.isHidden = true
            viewController.endButtonPlate.isHidden = true
            viewController.photoBottomSpace.constant = 16
        case .ended:
            viewController.endButtonPlate.isHidden = true
            if (Settings.subType == "manager") || (Settings.subType == "premium") {
                viewController.shareView.isHidden = false
                viewController.photoBottomSpace.constant = 60
            } else {
                viewController.shareView.isHidden = true
                viewController.photoBottomSpace.constant = 16
            }
           
            viewController.repeateRecordView.isHidden = false
            print("")
        }
    
        
        if (Settings.subType == "manager") || (Settings.subType == "premium") {
            viewController.photoView.isHidden = false
            switch viewController.type {
            case .future:
                viewController.notifClientView.isHidden = false
            default:
                viewController.notifClientView.isHidden = true
            }
        } else {
            viewController.photoView.isHidden = true
            viewController.notifClientView.isHidden = true
        }

        if viewController.fromNotific {
            viewController.endButtonPlate.isHidden = true
            editMode(edit: true, initMode: true)
        }
    }

    func choosePhoto() {
        let alert = UIAlertController(title: "Выберите изображение", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }

    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = viewController
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                viewController.present(imagePicker, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "У вас нет камеры.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = viewController
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            viewController.present(imagePicker, animated: true, completion: nil)

        } else {
            let alert = UIAlertController(title: "Ошибка", message: "У вас нет доступа к галерее.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func configureView(with model: Records) {
        
        
        guard let vc = viewController else { return }
        
        vc.usersStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }

        model.client?.forEach { client in
            let name = client.lastname?.count ?? 0 > 0 ? "\(client.lastname ?? "") \(client.name ?? "")" : "\(client.name ?? "")"
            let avatar = client.image ?? ""

            let userView = RecordCreateUserView(name: name, avatar: avatar)

            let tap = UITapGestureRecognizer(target: self, action: #selector(self.onClientTap(_:)))
            userView.addGestureRecognizer(tap)

            vc.usersStackView.addArrangedSubview(userView)
        }

        if model.services?.count ?? 0 > 0 {
            var names = ""
            var price = 0
            var duration = 0
            for item in model.services! {
                names += ", \(item.name ?? "")"
                price += item.price ?? 0
                duration += item.duration ?? 0
            }
            names = String(names.dropFirst(2))
            viewController.priceField.text = "\(price)"
            viewController.durationField.text = "\(duration)"
            viewController.model?.duration = duration
            viewController.model?.price = price
            viewController.serviceName.text = names
        }

        if model.expandables?.count ?? 0 > 0 {
            var names = ""
            for item in model.expandables! {
                names += ", \(item.name ?? "")"
            }
            names = String(names.dropFirst(2))
            viewController.productLabel.text = names
        } else {
            viewController.productLabel.text = "Нет продукта"
        }

        if viewController.notificTime == nil {
            viewController.notificTime = list.first(where: { $0.serverName == model.reminder }) ?? RecordsNotifTypeModel(name: "За 2 часа", serverName: 120)
        }
        
        if viewController.clientNotificTime == nil {
            viewController.clientNotificTime = list.first(where: { $0.serverName == model.reminderClient }) ?? RecordsNotifTypeModel(name: "За 2 часа", serverName: 120)
        }

        viewController.model?.reminder = viewController.notificTime?.serverName ?? 0
        viewController.model?.reminderClient = viewController.clientNotificTime?.serverName ?? 0

        viewController.notificLabel.text = viewController.notificTime?.name
        viewController.notifClientLabel.text = viewController.clientNotificTime?.name
        
        if let imageBefore = model.imageBefore {
            if let urlBefore = URL(string: imageBefore) {
                viewController.leftPhoto.af_setImage(withURL: urlBefore)
            }
        }

        if let imageAfter = model.imageAfter {
            if let urlAfter = URL(string: imageAfter) {
                viewController.rightPhoto.af_setImage(withURL: urlAfter)
            }
        }

        if viewController.dateString == "" {
            viewController.dateString = viewController.model?.date ?? ""
        }

        viewController.dateLabel.text = viewController.dateString
        viewController.model?.date = viewController.dateString
    }
    
    @objc func onClientTap(_ sender: UITapGestureRecognizer? = nil) {
        print("doSmth")
    }


    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }

    func configureView(with model: RecordCreateFillModel) {
        guard let vc = viewController else { return }
        
        vc.usersStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }

        model.client?.forEach { client in
            let name = client.lastname?.count ?? 0 > 0 ? "\(client.lastname ?? "") \(client.name ?? "")" : "\(client.name ?? "")"
            let avatar = client.image ?? ""

            let userView = RecordCreateUserView(name: name, avatar: avatar)

            let tap = UITapGestureRecognizer(target: self, action: #selector(self.onClientTap(_:)))
            userView.addGestureRecognizer(tap)

            vc.usersStackView.addArrangedSubview(userView)
        }

        if model.services?.count ?? 0 > 0 {
            var names = ""
            var price = 0
            var duration = 0
            for item in model.services! {
                names += ", \(item.name ?? "")"
                price += item.price ?? 0
                duration += item.duration ?? 0
                print(item)
            }
            names = String(names.dropFirst(2))
            viewController.priceField.text = "\(price)"
            viewController.durationField.text = "\(duration)"
            viewController.serviceName.text = names
        }

        if model.product?.count ?? 0 > 0 {
            var names = ""
            for item in model.product! {
                names += ", \(item.name ?? "")"
            }
            names = String(names.dropFirst(2))
            viewController.productLabel.text = names
        } else {
            viewController.productLabel.text = "Нет продукта"
        }

        viewController.notificLabel.text = model.notificTime.name
        viewController.notifClientLabel.text = model.clientNotificTime.name
        // 0 // model.notificTime.name //ВРЕМЯ НАПОМИНАНИЯ
    }

    func chooseNotifTime(client: Bool) {
        let vc = viewController.getControllerRecord(controller: .recordsNotificAlert) as! RecordsNotificAlert
        vc.editdelegate = viewController
        vc.client = client
        viewController.present(vc, animated: true)
    }
    
    func convertModelToV4(model: Records) -> RecordsV4 {
        self.userInfo = ["editRecord": model]
        
        let clients = model.client?.compactMap { ClientShort(clientID: $0.id) }
        let expandables = model.expandables?.compactMap { ProductShort(id: $0.id, count: $0.pivot?.count) }
        
        let modelV4 = RecordsV4(id: model.id,
                                userID: model.userID,
                                clientID: model.userID,
                                price: model.price,
                                discount: model.discount,
                                duration: model.duration,
                                date: model.date,
                                note: model.note,
                                imageBefore: model.imageBefore,
                                reminder: model.reminder,
                                reminderClient: model.reminderClient,
                                imageAfter: model.imageAfter,
                                status: model.status,
                                createdAt: model.createdAt,
                                updatedAt: model.updatedAt,
                                clients: clients,
                                services: model.services,
                                expandables: expandables,
                                read: model.read)
        
        return modelV4
    }

    func postRecord(model: Records) {
        SVProgressHUD.show()
        
        let modelV4 = convertModelToV4(model: model)
        
        service.postEditRecord(model: modelV4).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    NotificationCenter.default.post(name: NSNotification.Name.RecordsUpdate, object: nil, userInfo: self.userInfo)
                    if self.viewController.fromNotific {
                        self.viewController.notificationDelegate?.record = model
                        if (Settings.subType == "manager") || (Settings.subType == "premium") {
                            self.showAlert(dismiss: true, cancel: false)
                        } else {
                            self.viewController.navigationController?.popViewController(animated: true)
                        }
                        
                    } else {
                        if (Settings.subType == "manager") || (Settings.subType == "premium") {
                            self.showAlert(dismiss: false, cancel: false)
                        } else {
                            self.viewController.navigationController?.popViewController(animated: true)
                        }
                    }
                    //  self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func postPhoto(url: URL, side: Int) {
        SVProgressHUD.show()
        service.postPhoto(url: url).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if side == 0 {
                        self.viewController.model?.imageBefore = response.data?.url
                        self.leftUrl = response.data?.url
                    } else {
                        self.viewController.model?.imageAfter = response.data?.url
                        self.rightUrl = response.data?.url
                    }
                    self.viewController.active = nil
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func editMode(edit: Bool, initMode: Bool) {
        if viewController.isEditMode {
            if !initMode {
                viewController.model?.note = viewController.noteField.text
                viewController.model?.discount = viewController.discountField.text?.toInt() ?? 0
                postRecord(model: viewController.model!)
            }
        }
        viewController.isEditMode = edit
        if edit {
            if viewController.fromNotific {
                viewController.plates.forEach { view in
                    view.isUserInteractionEnabled = false
                    if view != viewController.leftPhoto && view != viewController.rightPhoto {
                        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
                    }
                }
                viewController.serviceView.isUserInteractionEnabled = true
                viewController.dateView.isUserInteractionEnabled = true
                viewController.serviceView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                viewController.dateView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                viewController.plates.forEach { view in
                    view.isUserInteractionEnabled = true
                    if view != viewController.leftPhoto && view != viewController.rightPhoto {
                        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    }
                }
            }

            viewController.photoView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            viewController.editButton.setTitle("Сохранить", for: .normal)
            viewController.editButton.setImage(UIImage(), for: .normal)
        } else {
            viewController.plates.forEach { view in
                view.isUserInteractionEnabled = false
                if view != viewController.leftPhoto && view != viewController.rightPhoto {
                    view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
                }
            }
            viewController.photoView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9882352941, blue: 1, alpha: 1)
            viewController.editButton.setTitle("", for: .normal)
            viewController.editButton.setImage(#imageLiteral(resourceName: "pen"), for: .normal)
            viewController.view.endEditing(true)
        }
    }

    func cancelRecord() {
        SVProgressHUD.show()
        service.postDeleteRecord(viewController.model?.id ?? 0).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    var canceledRecord = self.viewController.model
                    canceledRecord?.status = 1
                    let userInfo = ["editRecord": canceledRecord]
                    NotificationCenter.default.post(name: NSNotification.Name.RecordsUpdate, object: nil, userInfo: userInfo)
                    if (Settings.subType == "manager") || (Settings.subType == "premium") {
                        self.showAlert(dismiss: true, cancel: true)
                    } else {
                        self.viewController.navigationController?.popViewController(animated: true)
                    }
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func openDate() {
        let vc = viewController.getControllerRecord(controller: .calendarmonth) as! RecordsCalendarMonthController
        
        vc.changeDelegate = viewController
        vc.records = viewController.records
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func sharePhoto(left: String, right: String) {
//        let shareText = "Приложение - Profiapp\nМои работы! Фото до и после."
//        let vc = UIActivityViewController(activityItems: [shareText, left, right], applicationActivities: [])
//        viewController.present(vc, animated: true)
        
        let new = UIImage.collage(images: [viewController.leftPhoto.image?.cropsToSquare() ?? UIImage(), viewController.rightPhoto.image?.cropsToSquare() ?? UIImage()], size: CGSize(width: 2048, height: 1024))

        let bottomImage = new
        let topImage = UIImage(named: "logoMask.png")

        let size = CGSize(width: 2048, height: 1144)
        UIGraphicsBeginImageContext(size)

        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bottomImage.draw(in: CGRect(x: 0, y: 0, width: 2048, height: 1024))

        topImage!.draw(in: areaSize, blendMode: .normal, alpha: 1)

        var name = Authorization.lastame ?? ""

        if !name.isEmpty {
            if (Authorization.name?.count ?? 0) > 0 {
                name += " \(Authorization.name?.first.map { String($0) } ?? "")."
            }
            
            if (Authorization.midname?.count ?? 0) > 0 {
                name += "\(Authorization.midname?.first.map { String($0) } ?? "")."
            }
        } else {
            name = Authorization.name ?? ""
        }

        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        var resImg: UIImage?
        resImg = textToImage(drawText: name.uppercased() as NSString, inImage: newImage, atPoint: CGPoint(x: 40, y: 1060))
        //resultImage.image = resImg // newImage

        resImg?.saveToCameraRoll { url in
            if let url = url {
                self.postImg(url: url)
            }
        }
//        share(withUiImage: resImg)
        
//        let image = resImg
//
//        // set up activity view controller
//        let imageToShare = [image!]
//        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = viewController.view // so that iPads won't crash
//
//        // exclude some activity types from the list (optional)
//        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook]
//
//        // present the view controller
//        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func share(withUiImage uiImage : UIImage?){
        viewController.showHUD(show: false)
        
        if let safeImage: UIImage = uiImage,let imagePngData = safeImage.jpegData(compressionQuality: 0.7) {
            let activityViewController  = UIActivityViewController(activityItems: [imagePngData], applicationActivities: nil)

            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceView = self.viewController.view
                popoverController.sourceRect = CGRect(x: self.viewController.view.bounds.midX, y: self.viewController.view.bounds.maxY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }

    func postImg(url: URL) {
        SVProgressHUD.show()
        service.postPhoto(url: url, compressIndex: 0.8).subscribe { response in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                let shareText = "Приложение - ProfApp\nМои работы! Фото до и после."
                let vc = UIActivityViewController(activityItems: [shareText, response.data?.url ?? ""], applicationActivities: [])
                self.viewController.present(vc, animated: true)
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func textToImage(drawText: NSString, inImage: UIImage, atPoint: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 44)!
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }

    func endRecord(id: Int) {
        SVProgressHUD.show()
        service.endRecord(id: id).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func showAlert(dismiss: Bool, cancel: Bool) {
        // TODO: Переделать
        
        guard viewController.model?.client?.count ?? 0 == 1,
              let client = viewController.model?.client?.first else { return }
        
        let vc = viewController.getControllerProfile(controller: .notifalert) as! UserNotificationAlert
        vc.delegate = viewController
        viewController.dismissAfter = dismiss
        var message = ""
        if cancel {
            var services = ""//"\(recModel?.services?.first?.name)"
            for item in viewController.model?.services ?? [] {
                services += ", \(item.name ?? "")"
            }

            let servs = services.dropFirst(2)
            message = "Отмена записи на: \(servs), \(viewController.model?.date ?? "")."
            message += " Ваш специалист: \(Authorization.lastame ?? "") \(Authorization.name ?? "")."
        } else {
            var services = ""//"\(recModel?.services?.first?.name)"
            for item in viewController.model?.services ?? [] {
                services += ", \(item.name ?? "")"
            }

            let servs = services.dropFirst(2)
            message = "Здравствуйте! Изменение записи: \(servs), \(viewController.model?.date ?? "")."
            if (Authorization.useraddress?.count ?? 0) > 0 {
                message += " Адрес: \(Authorization.useraddress ?? "")."
            }

            message += " Ваш специалист: \(Authorization.lastame ?? "") \(Authorization.name ?? "")."
        }

        viewController.message = message
        viewController.client = client
        viewController.present(vc, animated: true)
    }
    
    
    func deleteRecord() {
        viewController.showHUD(show: true)
        
        service.deleteRecord(id: viewController.model?.id ?? 0).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    let userInfo = ["deleteRecord": self.viewController.model]
                    NotificationCenter.default.post(name: NSNotification.Name.RecordsUpdate, object: nil, userInfo: userInfo)
                }
                RecordsController.showLoader = true
                self.viewController.navigationController?.popViewController(animated: true)
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}
