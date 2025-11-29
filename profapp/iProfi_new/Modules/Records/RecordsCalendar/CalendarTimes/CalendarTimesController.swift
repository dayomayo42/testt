//
//  CalendarTimesController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 20.11.2020.
//

import UIKit

class CalendarTimesController: UIViewController {
    
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var placeholderView: ShedulePlaceHolderView!
    @IBOutlet weak var tableView: UITableView!
    
    var createDelegate: RecordsDateDelegate?
    var changeDelegate: RecordsDateEditDelegate?
    
    var allRecords: [Records] = []
    var records: [Records] = []
    var recordsDates: [String] = []
    
    var monthCalendarDay: MonthCalendarDay? = nil
    
    var tableModel: [DayListTableModel] = []
    
    var allTimeList: [String] = ["00:00", "00:15", "00:30", "00:45", "01:00", "01:15", "01:30", "01:45", "02:00", "02:15", "02:30", "02:45", "03:00", "03:15", "03:30", "03:45", "04:00", "04:15", "04:30", "04:45", "05:00", "05:15", "05:30", "05:45", "06:00", "06:15", "06:30", "06:45", "07:00", "07:15", "07:30", "07:45", "08:00", "08:15", "08:30", "08:45", "09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:15", "15:30", "15:45", "16:00", "16:15", "16:30", "16:45", "17:00", "17:15", "17:30", "17:45", "18:00", "18:15", "18:30", "18:45", "19:00", "19:15", "19:30", "19:45", "20:00", "20:15", "20:30", "20:45", "21:00", "21:15", "21:30", "21:45", "22:00", "22:15", "22:30", "22:45", "23:00", "23:15", "23:30", "23:45"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        records = monthCalendarDay?.records ?? []
        
        topTitle.text = "Записи на \(monthCalendarDay?.date?.getDate() ?? "")"
        view.bringSubviewToFront(placeholderView)
        
        sortAllTimeList()
        
        guard allTimeList.count > 0 else {
            self.placeholderView.isHidden = false
            self.placeholderView.configure(type: .sheduleNotFilled, goToSheduleHidden: true)
            return
        }
        
        guard !allTimeList.contains("weekends") else {
            self.placeholderView.isHidden = false
            self.placeholderView.configure(type: .weekendPlaceholder, goToSheduleHidden: true)
            return
        }
        
        sortTimes()
    }
    
    func sortAllTimeList() {
        
        if let weekends = RecordsCalendarController.serverShadule?.weekends,
           let date = monthCalendarDay?.date?.getDate()  {
            if weekends.contains(date) {
                allTimeList = ["weekends"]
                return
            }
        }
        
        var dataTimes = RecordsCalendarController.serverShadule?.datatimes
        
        var beginTime: String? = ""
        var endTime: String? = ""
        
        if let weekDayNumber = monthCalendarDay?.weekdayNumber {
            switch weekDayNumber {
            case 1:
                if let sunday = dataTimes?.first { $0.day == 0 } {
                    beginTime = sunday.beginTime
                    endTime = sunday.endTime
                }
            case 2:
                if let monday = dataTimes?.first { $0.day == 1 } {
                    beginTime = monday.beginTime
                    endTime = monday.endTime
                }
            case 3:
                if let tuesday = dataTimes?.first { $0.day == 2 } {
                    beginTime = tuesday.beginTime
                    endTime = tuesday.endTime
                }
            case 4:
                if let wendnesday = dataTimes?.first { $0.day == 3 } {
                    beginTime = wendnesday.beginTime
                    endTime = wendnesday.endTime
                }
            case 5:
                if let thursday = dataTimes?.first { $0.day == 4 } {
                    beginTime = thursday.beginTime
                    endTime = thursday.endTime
                }
            case 6:
                if let friday = dataTimes?.first { $0.day == 5 } {
                    beginTime = friday.beginTime
                    endTime = friday.endTime
                }
            case 7:
                if let saturday = dataTimes?.first { $0.day == 6 } {
                    beginTime = saturday.beginTime
                    endTime = saturday.endTime
                }
            default:
                break
            }
            
            guard let beginTime, let endTime else { return }
            guard !beginTime.isEmpty, !endTime.isEmpty else {
                allTimeList = []
                return
            }
            
            var result = allTimeList
                .map { $0.convertToHours() }
                .filter { $0 >= beginTime.convertToHours() && $0 <= endTime.convertToHours() }
                .map { $0.getTime() }
            
            result = duplicateCancelled(shedule: result)
            result = removeCrossRecordsTime(shedule: result)
            
            generateTableModel(shedule: result)
            allTimeList = result
        }
    }
    
    func sortTimes() {
        recordsDates = records
            .compactMap { $0.date?.convertDate(to: 0) }
    }
    
    func addActionWithDate(_ date: String) {
        let vc = self.getControllerRecord(controller: .createRecord) as! RecordsCreateController
        vc.dateString = date
        vc.records = allRecords
        vc.repeate = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func removeCrossRecordsTime(shedule: [String]) -> [String] {

        var returnValue = shedule
        
        let rightRecords = records.filter { $0.status != 1 }
        var cancelledRecords = records.filter { $0.status == 1 }
        
        let recordsRange = rightRecords.compactMap {
            ($0.date?.convertDate(to: 0).getDateMinutes() ?? 0)...(($0.duration ?? 0) + ($0.date?.convertDate(to: 0).getDateMinutes() ?? 0))
        }
        
        shedule.forEach { date in
            if let dateInt = date.getDateMinutes() {
                if let catchedRange = recordsRange.first(where: { $0.contains(dateInt) }) {
                    if (dateInt != catchedRange.first) && (dateInt != catchedRange.last) {
                        if !rightRecords.contains(where: { $0.date?.convertDate(to: 0) == date }) && !cancelledRecords.contains(where: { $0.date?.convertDate(to: 0) == date }) {
                            
                            if let idx = returnValue.firstIndex(where: { $0 == date }) {
                                returnValue.remove(at: idx)
                            }
                            
                        } else if cancelledRecords.contains(where: { $0.date?.convertDate(to: 0) == date }) {
                            if let idx = cancelledRecords.firstIndex(where: { $0.date?.convertDate(to: 0) == date }) {
                                cancelledRecords.remove(at: idx)
                            }
                        }
                    }
                }
            }
        }
        
        return returnValue
    }
    
    private func duplicateCancelled(shedule: [String]) -> [String] {

        var returnValue = shedule
        
        let cancelledRecords = records.filter { $0.status == 1 }
        
        shedule.forEach { date in
            if cancelledRecords.contains(where: { $0.date?.convertDate(to: 0) == date }) {
                let matchRecords = cancelledRecords.filter { $0.date?.convertDate(to: 0) == date }
                for _ in matchRecords {
                    returnValue.append(date)
                }
            }
        }
        
        returnValue = returnValue
            .map { $0.convertToHours() }
            .sorted { $0 < $1 }
            .map { $0.getTime() }
        
        return returnValue
    }
    
    private func generateTableModel(shedule: [String]) {
        
        var hoursArray = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00",  "23:00"]
        
        var dayListModel: [DayListTableModel] = []
        
        shedule.forEach { date in
            
            var hourDate: String? = nil
            
            if let hourIdx = hoursArray.firstIndex(where: { $0 == date }) {
                hoursArray.remove(at: hourIdx)
                hourDate = date
            }
            
            if let idx = records.firstIndex(where: { $0.date?.convertDate(to: 0) == date  }) {
                
                let dayList = DayListTableModel(date: date, hourDate: hourDate, record: records[idx])
                dayListModel.append(dayList)
                
                records.remove(at: idx)
                
            } else{
                
                let dayList = DayListTableModel(date: date, hourDate: hourDate, record: nil)
                dayListModel.append(dayList)
            }
        }
        
        tableModel = removeBreakTimes(with: dayListModel)
    }
    
    private func removeBreakTimes(with model: [DayListTableModel]) -> [DayListTableModel] {
        guard let breakTimes = RecordsCalendarController.serverShadule?.datatimes?[(monthCalendarDay?.weekdayNumber ?? 0)-1].breakTimes else {
            return model
        }
        
        guard breakTimes.count == 2 else { return model }
        
        let range = (breakTimes[0].getDateMinutes() ?? 0)...(breakTimes[1].getDateMinutes() ?? 0)
        
        var returnValue = model
        
        model.enumerated().forEach { index, day in
            if let dateInt = day.date?.getDateMinutes() {
                if range.contains(dateInt) {
                    if day.record == nil {
                        if let idx = returnValue.firstIndex(where: { $0 == day }) {
                            returnValue.remove(at: idx)
                        }
                    }
                }
            }
        }
        
        return returnValue
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CalendarTimesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allTimeList.contains("weekends") {
            return 0
        } else {
            return tableModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = tableModel[indexPath.row]
        
        if let record = model.record {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarDayCell
            
            if let hour = model.hourDate {
                cell.hourLabel.text = "\(hour)"
            } else {
                cell.hourLabel.text = ""
            }
            
            cell.configure(record: record)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellFree", for: indexPath) as! CalendarFreeCell
            
            if let hour = model.hourDate {
                cell.hourLabel.text = "\(hour)"
            } else {
                cell.hourLabel.text = ""
            }
            
            cell.titleLabel.text = "\(model.date ?? "") Свободно"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tableModel = tableModel[indexPath.row]
        
        if let model = tableModel.record {
                
                guard createDelegate == nil && changeDelegate == nil else { return }
                
                let vc = self.getControllerRecord(controller: .recorddetail) as! RecordDetailController
                let current = Date().getCurrentGmtDate()
                vc.model = model
                vc.records = allRecords
                
                if model.date?.convertDateToDate().timeIntervalSince1970 ?? 0 > current.timeIntervalSince1970 {
                    //будет
                    vc.type = .future
                    if model.status == 1 {
                        vc.type = .cancelled
                    }
                } else if Int(current.timeIntervalSince1970 - (model.date?.convertDateToDate().timeIntervalSince1970 ?? 0)) < (model.duration ?? 0)*60 {
                    //в процессе
                    if model.status == 0 {
                        vc.type = .now
                    } else if model.status == 1 {
                        vc.type = .cancelled
                    }
                } else {
                    //завершено
                    vc.type = .ended
                    if model.status == 1 {
                        vc.type = .cancelled
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                if var createDelegate {
                    guard let currentDate = monthCalendarDay?.date?.getDate() else { return }
                    
                    createDelegate.dateString = "\(currentDate) \(tableModel.date ?? "")"
                    navigationController?.popToViewController((createDelegate.parentVC)!, animated: true)
                    return
                } else if var changeDelegate {
                    guard let currentDate = monthCalendarDay?.date?.getDate() else { return }
                    
                    changeDelegate.dateString = "\(currentDate) \(tableModel.date ?? "")"
                    navigationController?.popToViewController((changeDelegate.parentVC)!, animated: true)
                } else {
                    self.addActionWithDate("\(monthCalendarDay?.date?.getDate() ?? "") \(tableModel.date ?? "")")
                }
            }
    }
}
