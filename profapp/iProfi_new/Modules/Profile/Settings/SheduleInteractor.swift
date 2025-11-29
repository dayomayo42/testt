//
//  SettingsInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol SheduleInteractorProtocol: class {
    func configureView()
    func configureView(with model: SheduleModel)
    func openOnline()
    func openWeeks()
    func sendData(with model: SheduleModel)
    func getShadule()
}

class SheduleInteractor: SheduleInteractorProtocol {
    weak var viewController: SheduleController!
    weak var presenter: ShedulePresenterProtocol!
    var days: [String] = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    var views: [ShaduleView] = []
    
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    init(viewController: SheduleController, presenter: ShedulePresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        for i in 0..<days.count {
            let view = ShaduleView()
            view.dayName.text = days[i]
            viewController.stackView.addArrangedSubview(view)
            
            view.beginPlate.tag = i
            view.endPlate.tag = i
            view.breakPlate.tag = i
            view.accessPlate.tag = i
            
            let recognizerBegin = SheduleRecognizer(target: viewController, action: #selector(self.viewController.beginAction))
            recognizerBegin.headline = i
            view.beginPlate.addGestureRecognizer(recognizerBegin)
            
            
            let recognizerEnd = SheduleRecognizer(target: viewController, action: #selector(self.viewController.endAction))
            recognizerEnd.headline = i
            view.endPlate.addGestureRecognizer(recognizerEnd)
            
            
            let recognizerBreak = SheduleRecognizer(target: viewController, action: #selector(self.viewController.breakAction(_:)))
            recognizerBreak.headline = i
            view.breakPlate.addGestureRecognizer(recognizerBreak)
            
            
            let recognizerAccess = SheduleRecognizer(target: viewController, action: #selector(self.viewController.accessTimeAction(_:)))
            recognizerAccess.headline = i
            view.accessPlate.addGestureRecognizer(recognizerAccess)
            
            views.append(view)
        }
    }
    
    func configureView(with model: SheduleModel) {
        if model.datatimes?.count ?? 0  > 6 {
            for i in 0..<days.count {
                views[i].beginTime.text = model.datatimes?[i].beginTime ?? ""
                views[i].endTime.text = model.datatimes?[i].endTime ?? ""
                if model.datatimes?[i].breakTimes.count ?? 0 > 1 {
                    if model.datatimes?[i].breakTimes[0].count ?? 0 > 0 && model.datatimes?[i].breakTimes[1].count ?? 0 > 0 {
                        views[i].breakTime.text = "с \(model.datatimes?[i].breakTimes[0] ?? "") до \(model.datatimes?[i].breakTimes[1] ?? "")"
                    } else {
                        views[i].breakTime.text = ""
                    }
                } else {
                    views[i].breakTime.text = ""
                }
            }
        }
    }

    
    func openOnline() {
        let vc = viewController.getControllerProfile(controller: .onlinesettings) as! OnlineRecordSettingsController
       // vc.userModel = viewController.userModel
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openWeeks() {
        let vc = viewController.getControllerRecord(controller: .calendarmonth) as! RecordsCalendarMonthController
        vc.sheduleDelegate = viewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendData(with model: SheduleModel) {
        SVProgressHUD.show()
        
        service.postShedule(model: model).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    RecordsCalendarController.serverShadule = model
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func getShadule() {
        SVProgressHUD.show()
        service.getShadule().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    if response.data?.datatimes?.count == 0 {
                        for i in 0...6 {
                            self.viewController.sheduleModel.datatimes?.append(ShaduleTimes(day: i, beginTime: "", endTime: "", breakTimes: ["", ""], availableTimes: []))
                        }
                        self.viewController.sheduleModel.weekends = []
                    } else {
                        self.viewController.sheduleModel = response.data!
                    }
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
    
}

class SheduleRecognizer: UITapGestureRecognizer {
    var headline: Int?
}
