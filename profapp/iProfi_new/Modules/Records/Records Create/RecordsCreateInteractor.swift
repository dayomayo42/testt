//
//  RecordsCreateInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit
import EventKit

protocol RecordsCreateInteractorProtocol: class {
    func configureView()
    func configureView(with model: RecordCreateFillModel)
    func chooseNotifTime(client: Bool)
    func postRecord(model: CreateRecordModel)
    func checkAndPost(model: CreateRecordModel)
    func checkFill()
}

class RecordsCreateInteractor: RecordsCreateInteractorProtocol {
    weak var viewController: RecordsCreateController!
    weak var presenter: RecordsCreatePresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    let dateFormatter = DateFormatter()
    
    let list: [RecordsNotifTypeModel] = [RecordsNotifTypeModel(name: "Не напоминать", serverName: 0), RecordsNotifTypeModel(name: "За 15 минут", serverName: 15), RecordsNotifTypeModel(name: "За 30 минут", serverName: 30), RecordsNotifTypeModel(name: "За 45 минут", serverName: 45), RecordsNotifTypeModel(name: "За 1 час", serverName: 60), RecordsNotifTypeModel(name: "За 2 часа", serverName: 120), RecordsNotifTypeModel(name: "За 1 день", serverName: 1440)]

    init(viewController: RecordsCreateController, presenter: RecordsCreatePresenterProtocol) {
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

        viewController.priceView.isUserInteractionEnabled = false //true
        viewController.durationView.isUserInteractionEnabled = false
        viewController.priceField.inputAccessoryView = toolbar
        viewController.discountField.inputAccessoryView = toolbar
        viewController.durationField.inputAccessoryView = toolbar
        viewController.noteField.inputAccessoryView = toolbar
        viewController.addButton.isActive = false
        
        if (Settings.subType == "manager") || (Settings.subType == "premium") {
            viewController.clientNotifPlate.isHidden = false
        } else {
            viewController.clientNotifPlate.isHidden = true
        }
        
        viewController.currencyView.text = Settings.currency
        
        viewController.parentVC = viewController
        
        if viewController.oldRecord != nil {
            configureRepeate()
        }
    }
    
    func configureRepeate() {
        viewController.model.client = viewController.oldRecord?.client
        //viewController.model.originalProduct = viewController.oldRecord.
        viewController.model.services = viewController.oldRecord?.services
        viewController.discountField.text = "\(viewController.oldRecord?.discount ?? 0)"
        viewController.noteField.text = viewController.oldRecord?.note
        viewController.model.notificTime = list.first(where: {$0.serverName == viewController.oldRecord?.reminder})!
    
        viewController.model.product = self.viewController.oldRecord?.expandables
        
        if (Settings.subType == "manager") || (Settings.subType == "premium") {
            viewController.clientNotifPlate.isHidden = false
        } else {
            viewController.clientNotifPlate.isHidden = true
        }
        
        configureView(with: viewController.model)
    }
    
    @objc func doneButtonAction() {
        viewController.view.endEditing(true)
    }

    func configureView(with model: RecordCreateFillModel) {
        
        guard let vc = viewController else { return }
        
        vc.usersStackView.arrangedSubviews.forEach { subView in
            if subView.tag != 42 {
                subView.removeFromSuperview()
            }
        }

        vc.addUserView.isHidden = model.client?.count ?? 0 > 0

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
            viewController.serviceName.text = names
        }

        if model.product?.count ?? 0 > 0 {
            var names = ""
            for item in model.product! {
                names += ", \(item.name ?? "")"
            }
            names = String(names.dropFirst(2))
            viewController.productLabel.text = names
        }

        viewController.dateLabel.text = viewController.dateString
        viewController.notificView.text = model.notificTime.name
        viewController.clientNoticeView.text = model.clientNotificTime.name
        checkFill()
    }
    
    @objc func onClientTap(_ sender: UITapGestureRecognizer? = nil) {
        presenter.chooseClient()
    }

    func chooseNotifTime(client: Bool) {
        let vc = viewController.getControllerRecord(controller: .recordsNotificAlert) as! RecordsNotificAlert
        vc.delegate = viewController
        vc.client = client
        viewController.present(vc, animated: true)
    }
    var recModel: CreateRecordModel?
    
    func convertModelToV4(model: CreateRecordModel) -> CreateRecordModelV4 {
        let clients = model.client?.compactMap { ClientShort(clientID: $0.id) }
        let expandables = model.expandables?.compactMap { ProductShort(id: $0.id, count: $0.pivot?.count) }
        
        let modelV4 = CreateRecordModelV4(client: clients,
                                          expandables: expandables,
                                          services: model.services,
                                          price: model.price,
                                          discount: model.discount,
                                          duration: model.duration,
                                          date: model.date,
                                          note: model.note,
                                          reminder: model.reminder,
                                          reminderClient: model.reminderClient)
        return modelV4
    }

    func postRecord(model: CreateRecordModel) {
        guard let vc = viewController else { return }
            
        let modelv4 = convertModelToV4(model: model)
        
        SVProgressHUD.show()
        service.postRecord(model: modelv4).subscribe { response in
            self.recModel = model
            SVProgressHUD.dismiss()
            if response.success ?? false {
                let userInfo = ["addRecord" : response.data]
                NotificationCenter.default.post(name: NSNotification.Name.RecordsUpdate, object: nil, userInfo: userInfo)
                if Settings.calendar ?? false {
                    self.addToCalendar(model: model)
                }
                self.showAlert()
            } else {
                SVProgressHUD.showError(withStatus: self.checkVPNError(response.message ?? ""))
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: self.checkVPNError(error.localizedDescription))
        }.disposed(by: disposeBag)
    }
    
    func checkVPNError(_ error: String) -> String {
        if error.contains("Безопасное подключение") {
            return "Проблемы с подключением, проверьте возможно у вас включен VPN"
        } else {
            return error
        }
    }
    
    func showAlert() {
        
        guard recModel?.client?.count ?? 0 < 2, let client = recModel?.client?.first else {
            viewController.dismissAll = true
            return
        }
 
        if (Settings.subType == "manager") || (Settings.subType == "premium") {
            let vc = viewController.getControllerProfile(controller: .notifalert) as! UserNotificationAlert
            vc.delegate = viewController
            viewController.dismissAfter = true
            var services = ""//"\(recModel?.services?.first?.name)"
            for item in recModel?.services ?? [] {
                services += ", \(item.name ?? "")"
            }

            let servs = services.dropFirst(2)
            var message = "Вы записаны на: \(servs), \(recModel?.date ?? "")."
            if (Authorization.useraddress?.count ?? 0) > 0 {
                message += " Адрес: \(Authorization.useraddress ?? "")."
            }

            message += " Ваш специалист: \(Authorization.lastame ?? "") \(Authorization.name ?? "")."
            viewController.message = message
            viewController.client = client
            viewController.present(vc, animated: true)
        } else {
            viewController.dismissAll = true
        }
    }
    
    func checkAndPost(model: CreateRecordModel) {
        var newArr: [Records] = viewController.records
        
        let newDate = Int(model.date?.convertDateToDate().timeIntervalSince1970 ?? 0) + Int((model.duration ?? 0) * 60)

        newArr.removeAll(where: { ($0.date?.convertDateToDate().timeIntervalSince1970 ?? 0) < (model.date?.convertDateToDate().timeIntervalSince1970 ?? 0) })
        newArr.removeAll(where: { ($0.date?.convertDateToDate().timeIntervalSince1970 ?? 0) >= TimeInterval(newDate) })
        
        newArr.removeAll(where: { ($0.status == 1) })
        
        if newArr.count > 0 {
            let alert = UIAlertController(title: "Пересечение записей", message: "У вас есть запись, которая пересекается с текущей", preferredStyle: UIAlertController.Style.alert)
            
            
            let regularText = [NSAttributedString.Key.foregroundColor: UIColor.black ,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]
            let boldText = [NSAttributedString.Key.foregroundColor: UIColor.black ,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)]

            let textString = NSMutableAttributedString(string: newArr.count == 1 ? "\nУ вас есть запись, которая пересекается с текущей" : "\nУ вас есть записи, которые пересекаются с текущей", attributes: regularText)

            
            for item in newArr {
                var serviceName = ""
                item.services?.forEach({ service in
                    serviceName = ", \(service.name ?? "")"
                })
                
                serviceName = "\(serviceName.dropFirst(2))"
                let serviceNameAttr = NSMutableAttributedString(string: "\n\n\(serviceName)", attributes: boldText)
                textString.append(serviceNameAttr)
                
                var times = ""
                
                times += "c \(item.date?.convertDate(to: 0) ?? "")"
                let newDate = item.date?.convertDateToDate().add(component: .minute, value: item.duration ?? 0)
                times += " до \(newDate?.getTime() ?? "")"
                
                let timeStr = NSMutableAttributedString(string: "\n\(times)", attributes: regularText)
                textString.append(timeStr)
                
                let endDate = model.date?.convertDateToDate().add(component: .minute, value: model.duration ?? 0)
                let diff = Int((Int(endDate?.timeIntervalSince1970 ?? 0) - Int(item.date?.convertDateToDate().timeIntervalSince1970 ?? 0))/60)
                
                
                let diffStr = NSMutableAttributedString(string: "\nНаложение: \(diff) мин", attributes: regularText)
                textString.append(diffStr)
            }
            
            alert.setValue(textString, forKey: "attributedMessage")
            alert.addAction(UIAlertAction(title: "Разрешить добавление", style: UIAlertAction.Style.default, handler: {_ in 
                self.postRecord(model: model)
            }))
            alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))

            viewController.present(alert, animated: true, completion: nil)
        } else {
            postRecord(model: model)
        }
    }
    
    func addToCalendar(model: CreateRecordModel) {
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            DispatchQueue.main.async {
                self.insertEvent(store: eventStore, model: model)
            }
        case .denied:
            SVProgressHUD.showError(withStatus: "Доступ запрещен")
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion: { [weak self] (granted: Bool, _: Error?) -> Void in
                if granted {
                    DispatchQueue.main.async {
                        self?.insertEvent(store: eventStore, model: model)
                    }
                } else {
                    SVProgressHUD.showError(withStatus: "Доступ запрещен")
                }
            })
        default:
            print("Case default")
        }
    }
    
    func insertEvent(store: EKEventStore, model: CreateRecordModel) {
        //     DispatchQueue.global(qos: .background).async {
        let calendar = store.defaultCalendarForNewEvents
        let startDate = model.date?.convertDateToDate()//convertDateToDate("\(meetingStringDate) \(meetingStringTime)")
        let endDate = startDate!.addingTimeInterval(TimeInterval((model.duration ?? 0) * 60))
        let event = EKEvent(eventStore: store)
        event.calendar = calendar
        
        var serviceNames = ""
        for item in model.services ?? [] {
            serviceNames += ", \(item.name ?? "")"
        }
        serviceNames = String(serviceNames.dropFirst(2))
        
        if let clients = model.client {
            if clients.count == 1, let client = clients.first {
                event.title = "\(client.lastname ?? "") \(client.name ?? ""). \(serviceNames)"
            } else if clients.count > 1, let firstClient = clients.first {
                event.title = "\(firstClient.lastname ?? "") \(firstClient.name ?? "") + еще \(clients.count - 1). \(serviceNames)"
            }
        }
        
        event.startDate = startDate
        event.endDate = endDate

        do {
            try store.save(event, span: .thisEvent)
            SVProgressHUD.showDismissableSuccess(withStatus: "Запись добавлена в календарь")
        } catch {
            SVProgressHUD.showDismissableError(withStatus: "Ошибка сохранения")
        }
    }

    func checkFill() {
        if viewController.model.client != nil && viewController.model.services?.count ?? 0 > 0 && viewController.priceField.text?.count ?? 0 > 0 && viewController.durationField.text?.count ?? 0 > 0 && viewController.dateString.count > 0 {
            viewController.addButton.isActive = true
        } else {
            viewController.addButton.isActive = false
        }
    }
}
