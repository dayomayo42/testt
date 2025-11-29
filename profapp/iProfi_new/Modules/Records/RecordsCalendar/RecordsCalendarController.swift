//
//  RecordsCalendarController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.11.2020.
//

import UIKit

protocol RecordsCalendarDelegate {
    func goToShitfSettings()
}

class RecordsCalendarController: UIViewController, RecordsCalendarDelegate {
    
    @IBOutlet weak var switchView: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    static var serverShadule: SheduleModel?
    
    var prevIndex = 0
    var controllerList: [UIViewController] = []
    var records: [Records] = []
    
    var presenter: RecordsCalendarPresenterProtocol!
    let configurator: RecordsCalendarConfiguratorProtocol = RecordsCalendarConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onUpdate(_:)), name: NSNotification.Name.RecordsUpdate, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.RecordsUpdate, object: nil)
    }
    
    @objc func onUpdate(_ notification: NSNotification) {
        
        if let newRecord = notification.userInfo?["addRecord"] as? Records {
            records.append(newRecord)
            updateControllers()
        }
        
        if let updateRecord = notification.userInfo?["editRecord"] as? Records {
            records = records.map { $0.id == updateRecord.id ? updateRecord : $0 }
            updateControllers()
        }
        
        if let deleteRecord = notification.userInfo?["deleteRecord"] as? Records {
            records = records.filter { $0.id != deleteRecord.id }
            updateControllers()
        }
    }
    
    private func updateControllers() {
        let monthController = self.controllerList[2] as! RecordsCalendarMonthController
        if monthController.isViewLoaded {
            monthController.records = self.records
            monthController.presenter.configureView()
        }
        
        let weekController = self.controllerList[1] as! RecordsCalendarWeekViewController
        if weekController.isViewLoaded {
            weekController.records = self.records
            weekController.presenter.configureView()
        }
        
        let dayController = self.controllerList[0] as! CalendarDayController
        if dayController.isViewLoaded {
            dayController.records = self.records
            dayController.updateRecords()
        }
    }
    
    func goToShitfSettings() {
        presenter.goToShitfSettings()
    }
    
    @IBAction func addAction(_ sender: Any) {
        presenter.addAction()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func switchAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter.selectVC(num: 0)
        case 1:
            presenter.selectVC(num: 1)
        case 2:
            presenter.selectVC(num: 2)
        default: break
        }
    }
}
