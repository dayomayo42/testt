//
//  RecordsCalendarInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.11.2020.
//

import Foundation
import Moya
import RxSwift
import SVProgressHUD
import UIKit

protocol RecordsCalendarInteractorProtocol: class {
    func configureView()
    func selectVC(num: Int)
    func openCalendarDetail(monthCalendarDay: MonthCalendarDay, allRecords: [Records])
    func addAction()
    func getRecords(completion: @escaping () -> ())
    func addActionWithDate(_ date: String)
}

class RecordsCalendarInteractor: RecordsCalendarInteractorProtocol {
    weak var viewController: RecordsCalendarController!
    weak var presenter: RecordsCalendarPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: RecordsCalendarController, presenter: RecordsCalendarPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }

    func configureView() {
        configureList()
        selectVC(num: 0)
    }

    func configureList() {
        let dayvc = viewController.getControllerRecord(controller: .calendarday) as! CalendarDayController
        dayvc.records = viewController.records
        dayvc.parentVC = viewController
        
        let weekvc = viewController.getControllerRecord(controller: .newcalendarweek) as! RecordsCalendarWeekViewController
        weekvc.records = viewController.records
        weekvc.parentVC = viewController
        
        let monthvc = viewController.getControllerRecord(controller: .calendarmonth) as! RecordsCalendarMonthController
        monthvc.records = viewController.records
        monthvc.parentVC = viewController
        viewController.controllerList = [dayvc, weekvc, monthvc]
    }

    func selectVC(num: Int) {
        let previousVC = viewController.controllerList[viewController.prevIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        viewController.prevIndex = num
        
        if num == 0 {
            let vc = viewController.controllerList[viewController.prevIndex] as? CalendarDayController
            vc?.delegate = viewController
            vc?.view.frame = viewController.containerView.bounds
            viewController.containerView.addSubview(vc?.view ?? UIView())
            vc?.didMove(toParent: viewController)
        } else if num == 1 {
            let vc = viewController.controllerList[viewController.prevIndex] as? RecordsCalendarWeekViewController
            vc?.records = viewController.records
            vc?.view.frame = viewController.containerView.bounds
            viewController.containerView.addSubview(vc?.view ?? UIView())
            vc?.didMove(toParent: viewController)
        } else if num == 2 {
            let vc = viewController.controllerList[viewController.prevIndex] as? RecordsCalendarMonthController
            vc?.records = viewController.records
            vc?.view.frame = viewController.containerView.bounds
            viewController.containerView.addSubview(vc?.view ?? UIView())
            vc?.didMove(toParent: viewController)
        }
    }

    func openCalendarDetail(monthCalendarDay: MonthCalendarDay, allRecords: [Records]) {
        let vc = viewController.getControllerRecord(controller: .calendartimes) as! CalendarTimesController
        
        vc.allRecords = allRecords
        
        vc.monthCalendarDay = monthCalendarDay
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func addAction() {
        let vc = viewController.getControllerRecord(controller: .createRecord) as! RecordsCreateController
        vc.records = viewController.records
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func getRecords(completion: @escaping () -> ()) {
//        SVProgressHUD.show()
        service.getRecords().subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.records = response.data ?? []

                    self.viewController.records.sort {
                        $0.status ?? 0 > $1.status ?? 0
                    }

                    self.viewController.records.sort {
                        $0.date?.convertDateToDate().timeIntervalSince1970 ?? 0 < $1.date?.convertDateToDate().timeIntervalSince1970 ?? 0
                    }
                    completion()
 
//                    let vc = self.viewController.controllerList[self.viewController.prevIndex] as! CalendarDelegate
//                    vc.records = self.viewController.records
//                    vc.update()
                    //                self.sortRecords(with: response.data ?? [])
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func addActionWithDate(_ date: String) {
        let vc = viewController.getControllerRecord(controller: .createRecord) as! RecordsCreateController
        vc.dateString = date
        vc.records = viewController.records
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
