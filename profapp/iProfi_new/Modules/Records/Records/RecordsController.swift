//
//  RecordsController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 01.10.2020.
//

import UIKit
import SVProgressHUD

class RecordsController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var fuckingArrow: UIImageView!
    
    var presenter: RecordsPresenterProtocol!
    let configurator: RecordsConfiguratorProtocol = RecordsConfigurator()
    
    var records: [Records] = []
    var sortedRecords: [[Records]] = []
    
    static var showLoader: Bool = true
    
    var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getRecords()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SVProgressHUD.dismiss()
    }

    @IBAction func calendarAction(_ sender: Any) {
        presenter.openCalendar()
    }

    @IBAction func searchAction(_ sender: Any) {
        presenter.openSearch()
    }

    @IBAction func createRecords(_ sender: Any) {
        presenter.createAction()
    }
    
    func sortRecords() {
        let current = Date().getCurrentGmtDate()
        var futureRecords: [Records] = []
        var currentRecords: [Records] = []
        var canceledRecords: [Records] = []
        
        for item in records {
            if item.date?.convertDateToDate().timeIntervalSince1970 ?? 0 > current.timeIntervalSince1970 {
                
                //будет
                if item.status == 1 {
                    canceledRecords.append(item)
                } else {
                    futureRecords.append(item)
                }
                
            } else if Int(current.timeIntervalSince1970 - (item.date?.convertDateToDate().timeIntervalSince1970 ?? 0)) < (item.duration ?? 0)*60 {
                //в процессе
                if item.status == 1 {
                    canceledRecords.append(item)
                } else if item.status != 2 {
                    currentRecords.append(item)
                }
            } else {
                //завершено
            }
        }
        
        sortedRecords = [currentRecords, futureRecords, canceledRecords]
        
        if futureRecords.count == 0 && currentRecords.count == 0 && canceledRecords.count == 0 {
            tableView.isHidden = true
            fuckingArrow.isHidden = false
            infoView.isHidden = false
        } else {
            tableView.isHidden = false
            fuckingArrow.isHidden = true
            infoView.isHidden = true
        }
        tableView.reloadData()
    }
}

extension RecordsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "header") as! RecordHeaderCell
        header.configure(type: section == 0 ? .now : section == 1 ? .next : .cancelled)
        return header
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sortedRecords.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sortedRecords[section].count > 0 {
            return 32
        } else {
            return 2
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedRecords[section].count// section == 0 ? 1 : 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "now", for: indexPath) as! RecordNowCell
            cell.configure(with: sortedRecords[indexPath.section][indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "next", for: indexPath) as! RecordCell
            cell.configure(with: sortedRecords[indexPath.section][indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openDetail(with: sortedRecords[indexPath.section][indexPath.row], type: indexPath.section == 0 ? .now: sortedRecords[indexPath.section][indexPath.row].status == 1 ? .cancelled : .future)
    }
}
