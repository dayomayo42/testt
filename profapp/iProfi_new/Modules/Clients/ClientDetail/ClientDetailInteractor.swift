//
//  ClientDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.10.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

protocol ClientDetailInteractorProtocol: class {
    func configureView()
    func editAction()
    func choosePhoto()
    func postPhoto()
    func callAction(num: String)
    func addClientRecord()
    func getClient()
    func openRecord(model: Records)
    func changeStatus()
    func editUser()
}

class ClientDetailInteractor: ClientDetailInteractorProtocol {
    weak var viewController: ClientDetailController!
    weak var presenter: ClientDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var records: [Records] = []

    init(viewController: ClientDetailController, presenter: ClientDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        viewController.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 52, right: 0)
    }

    func editAction() {
        let vc = viewController.getControllerClients(controller: .clientEdit) as! ClientEditController
        vc.model = viewController.model
        viewController.navigationController?.pushViewController(vc, animated: true)
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

    func postPhoto() {
        if viewController.photoURL != nil {
            service.postPhoto(url: viewController.photoURL!).subscribe { response in
                if self.viewController != nil {
                    if response.success ?? false {
                        self.viewController.model?.image = response.data?.url
                        self.editUser()
                    } else {
                        SVProgressHUD.showError(withStatus: response.message)
                    }
                }
            } onError: { error in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }.disposed(by: disposeBag)
        }
    }

    func editUser() {
        SVProgressHUD.show()
        service.postEditClient(model: viewController.model!).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.getClient()
//                                    self.viewController.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func callAction(num: String) {
        let alert = UIAlertController(title: "Связаться с клиентом", message: "Выберите способ связи", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Телефон", style: .default, handler: { _ in
            if let url = URL(string: "tel://\("\(num)")") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }))

        alert.addAction(UIAlertAction(title: "SMS", style: .default, handler: { _ in
            let sms: String = "sms:\("\(num)")&body="
            let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            UIApplication.shared.open(URL(string: strURL)!, options: [:], completionHandler: nil)
        }))

        alert.addAction(UIAlertAction(title: "Соц. сети", style: .default, handler: { _ in
            let shareText = ""
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
            self.viewController.present(vc, animated: true)
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        viewController.present(alert, animated: true)
    }

    func addClientRecord() {
        // TODO: переделать
        
        if records.count > 0 {
            let vc = viewController.getControllerRecord(controller: .createRecord) as! RecordsCreateController
            if let client = viewController.model {
                vc.model.client = [client]
            }
            vc.records = records
            viewController.navigationController?.pushViewController(vc, animated: true)
        } else {
            getRecords()
        }
    }

    func getClient() {
//        SVProgressHUD.show()
        service.getClientDetail(id: viewController.model?.id ?? 0).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.model = response.data
                    self.viewController.tableView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func getRecords() {
        guard let model = viewController.model else { return }
        viewController.showHUD(show: true)
        service.getRecords().subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.records = response.data ?? []
                    let vc = self.viewController.getControllerRecord(controller: .createRecord) as! RecordsCreateController
                    vc.model.client = [model]
                    vc.records = response.data ?? []
                    self.viewController.navigationController?.pushViewController(vc, animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func openRecord(model: Records) {
        viewController.showHUD(show: true)
        service.getRecords().subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    let vc = self.viewController.getControllerRecord(controller: .recorddetail) as! RecordDetailController
                    let current = Date().getCurrentGmtDate()
                    vc.model = model

                    if model.date?.convertDateToDate().timeIntervalSince1970 ?? 0 > current.timeIntervalSince1970 {
                        // будет
                        vc.type = .future
                        if model.status == 1 {
                            vc.type = .cancelled
                        }
                    } else if Int(current.timeIntervalSince1970 - (model.date?.convertDateToDate().timeIntervalSince1970 ?? 0)) < (model.duration ?? 0) * 60 {
                        // в процессе
                        if model.status == 0 {
                            vc.type = .now
                        } else if model.status == 1 {
                            vc.type = .cancelled
                        }
                    } else {
                        // завершено
                        vc.type = .ended
                        if model.status == 1 {
                            vc.type = .cancelled
                        }
                    }
                    vc.records = response.data ?? []
                    self.viewController.navigationController?.pushViewController(vc, animated: true)

                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func changeStatus() {
        let vc = viewController.getControllerClients(controller: .clientStatus) as! ClientStatusController
        vc.delegate = viewController
        viewController.present(vc, animated: true)
    }
}
