//
//  RecordsInterractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD


protocol RecordsInteractorProtocol: class {
    func configureView()
    func createRecord()
    func openSearch()
    func getRecords()
    func openDetail(with model: Records, type: RecordsType)
    func openCalendar()
}

class RecordsInteractor: RecordsInteractorProtocol {
    weak var viewController: RecordsController!
    weak var presenter: RecordsPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    init(viewController: RecordsController, presenter: RecordsPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func getRecords() {
        if RecordsController.showLoader {
            self.viewController.showHUD(show: true)
            RecordsController.showLoader = false
        }
        service.getRecords().subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.records = response.data ?? []
                    
                    self.viewController.records.sort {
                        $0.status ?? 0 > $1.status  ?? 0
                    }
                    
                    self.viewController.records.sort {
                        $0.date?.convertDateToDate().timeIntervalSince1970 ?? 0 < $1.date?.convertDateToDate().timeIntervalSince1970 ?? 0
                    }
                    
                    self.viewController.tableView.reloadData()
                    self.viewController.sortRecords()
    //                self.sortRecords(with: response.data ?? [])
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        } onCompleted: {
        }.disposed(by: disposeBag)
    }
    
    func sortRecords(with records: [Records]) {
        
    }

    func configureView() {
        checkSubTrialEnd()
    }
    
    func checkSubTrialEnd() {
        guard let phone = Authorization.phone else { return }
        guard Settings.subTrialShowed?.filter({$0.key == phone }).first?.value != true else { return }
        guard Settings.subTrialExp?.count ?? 0 > 0 else { return }
        
        if let subTrialExpDateStr = Settings.subTrialExp?.convertDate(to: 4).convertDateToDateWTime().addingTimeInterval(3600*3) {
            let currentDate = "".convertDate(to: 4).convertDateToDateWTime().addingTimeInterval(3600*3)
            if currentDate > subTrialExpDateStr {
                Settings.subTrialShowed?.updateValue(true, forKey: phone)
                self.presenter.openSubExpiredView()
            }
        }
    }
    
    func createRecord() {
        let vc = viewController.getControllerRecord(controller: .createRecord) as! RecordsCreateController
        vc.hidesBottomBarWhenPushed = true
        vc.records = viewController.records
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSearch() {
        let vc = viewController.getControllerRecord(controller: .recordsSearch) as! RecordsSearchController
        vc.hidesBottomBarWhenPushed = true
        let filteredRecords = viewController.records.filter { $0.client?.count ?? 0 > 0 }
        vc.allRecords = filteredRecords
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDetail(with model: Records, type: RecordsType) {
        let vc = viewController.getControllerRecord(controller: .recorddetail) as! RecordDetailController
        vc.hidesBottomBarWhenPushed = true
        vc.model = model
        vc.type = type
        vc.records = viewController.records
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openCalendar() {
        let vc = viewController.getControllerRecord(controller: .recordscalendar) as! RecordsCalendarController
        vc.hidesBottomBarWhenPushed = true
        vc.records = viewController.records
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
