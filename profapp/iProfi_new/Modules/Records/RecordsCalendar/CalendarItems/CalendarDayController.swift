//
//  CalendarDayController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 16.11.2020.
//

import Moya
import RxSwift
import SVProgressHUD
import UIKit

struct CalendarDay {
    let dayWeekNumber: Int
    let dayNumber: Int
    let monthName: String
    let year: Int
    let dayWeekShortName: String
    let dateFormated: String
    var weekend: Bool
    var records: [Records]
}

struct CalendarRecordShedule {
    let startPoint: Int
    let endPoint: Int
}

struct DayListTableModel: Equatable {
    let date: String?
    let hourDate: String?
    let record: Records?
}

class CalendarDayController: UIViewController {
    var parentVC: RecordsCalendarController?
    
    var records: [Records] = []
    var dayList: [MonthCalendarDay] = []
    var recordsDates: [String] = []
    
    var current: Int? = nil
    var serverShadule: SheduleModel?
    var delegate: RecordsCalendarDelegate?
    
    var tableModel: [DayListTableModel] = []
    
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var dayDateLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var datesView: UIView!
    @IBOutlet weak var activityIdicator: UIActivityIndicatorView!
    @IBOutlet weak var placeHolderView: ShedulePlaceHolderView!

    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAvailibleDates()
    }
    
    func updateRecords() {
        activityIdicator.startAnimating()
        datesView.isHidden = true
        tableView.isHidden = true
        
        setupDayList(isUpdate: true)
    }

    func getAvailibleDates() {
        activityIdicator.startAnimating()
        service.getCalendarTimes().subscribe { response in
            SVProgressHUD.dismiss()
            if response.success ?? false {
                self.serverShadule = response.data
                RecordsCalendarController.serverShadule = response.data
                self.setupDayList()
            } else {
                self.activityIdicator.stopAnimating()
                SVProgressHUD.showError(withStatus: response.message)
            }
        } onError: { error in
            self.activityIdicator.stopAnimating()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }

    func setupDayList(isUpdate: Bool = false) {
        
        var days: [MonthCalendarDay] = []
        let stopDate = Date().getCurrentGmtDate().calendarEndDate()
        
        var currentCalendar = Calendar.current
        
        currentCalendar.timeZone = Date().gmt
        
        let calendarComponents = DateComponents(hour: 0, minute: 0, second: 0, nanosecond: 0)
        
        currentCalendar.enumerateDates(startingAfter: "2020-01-01T00:00:00".date()!, matching: calendarComponents, matchingPolicy: .nextTimePreservingSmallerComponents, repeatedTimePolicy: .first, direction: .forward) { date, _, stop in
            if let date = date {
                if date > stopDate.dateWithDayEnd() {
                    stop = true
                } else {
                    days.append(MonthCalendarDay(date: date,
                                                 number: date.getDay(),
                                                 weekdayNumber: date.numberOfDayInWeek(),
                                                 records: getDateRecords(date: date),
                                                 isWeekend: isWeekend(date: date)))
                }
            }
        }
        
        dayList = days
        
        let recordsList = dayList.filter { $0.records?.count ?? 0 > 0 }
        
        if !isUpdate {
            current = getCurrent()
        }
        
        activityIdicator.stopAnimating()
        datesView.isHidden = false
        
        fillDates()
    }
    

    func fillDates() {
        guard let current else { return }
        let serverShedule = RecordsCalendarController.serverShadule
        
        let model = dayList[current]
        let dayNum = (model.weekdayNumber ?? 42) - 1
        
        monthLabel.text = "\(model.date?.getMonthString() ?? "") \(model.date?.getYear() ?? 2001)"
        dayDateLabel.text = "\(model.number ?? "") \(model.date?.getWeekNameShortString() ?? "")"
        
        if let weekends = serverShedule?.weekends {
            guard !weekends.contains(model.date?.getDate() ?? "") else {
                self.placeHolderView.configure(type: .weekendPlaceholder, goToSheduleHidden: true)
                
                self.placeHolderView.isHidden = false
                self.tableView.isHidden = true
                return
            }
        }
        
        guard let todayShedule = serverShedule?.datatimes?.first(where: { $0.day == dayNum } ),
              !(todayShedule.beginTime?.isEmpty ?? true) && !(todayShedule.endTime?.isEmpty ?? true) else {
            
            self.placeHolderView.configure(type: .sheduleNotFilled, goToSheduleHidden: false)
            
            self.placeHolderView.onGoToSheduleTappedAction = { [weak self] in
                self?.delegate?.goToShitfSettings()
            }
            
            self.placeHolderView.isHidden = false
            self.tableView.isHidden = true
            return
        }
        
        let shedule = getTimeListForDay(day: model)
        
        dayList[current].sheduleString = shedule
        generateTableModel(shedule: shedule)
        
        placeHolderView.isHidden = true
        tableView.isHidden = false
        
        tableView.reloadData()
    }
    
    private func getRecordsDateStr(records: [Records]) -> [String] {
        return records.compactMap { $0.date?.convertDate(to: 0) }
    }
    
    private func getTimeListForDay(day: MonthCalendarDay) -> [String] {
        guard let sheduleDataTimes = RecordsCalendarController.serverShadule?.datatimes else { return [] }
        
        let allTimeList: [String] = ["00:00", "00:15", "00:30", "00:45", "01:00", "01:15", "01:30", "01:45", "02:00", "02:15", "02:30", "02:45", "03:00", "03:15", "03:30", "03:45", "04:00", "04:15", "04:30", "04:45", "05:00", "05:15", "05:30", "05:45", "06:00", "06:15", "06:30", "06:45", "07:00", "07:15", "07:30", "07:45", "08:00", "08:15", "08:30", "08:45", "09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:15", "15:30", "15:45", "16:00", "16:15", "16:30", "16:45", "17:00", "17:15", "17:30", "17:45", "18:00", "18:15", "18:30", "18:45", "19:00", "19:15", "19:30", "19:45", "20:00", "20:15", "20:30", "20:45", "21:00", "21:15", "21:30", "21:45", "22:00", "22:15", "22:30", "22:45", "23:00", "23:15", "23:30", "23:45"]
        
        var beginTime: String? = ""
        var endTime: String? = ""
        var returnValue: [String] = []
        
        if let weekDayNumber = day.weekdayNumber {
            switch weekDayNumber {
            case 7:
                if let sunday = sheduleDataTimes.first { $0.day == 6 } {
                    beginTime = sunday.beginTime
                    endTime = sunday.endTime
                }
            case 1:
                if let monday = sheduleDataTimes.first { $0.day == 0 } {
                    beginTime = monday.beginTime
                    endTime = monday.endTime
                }
            case 2:
                if let tuesday = sheduleDataTimes.first { $0.day == 1 } {
                    beginTime = tuesday.beginTime
                    endTime = tuesday.endTime
                }
            case 3:
                if let wendnesday = sheduleDataTimes.first { $0.day == 2 } {
                    beginTime = wendnesday.beginTime
                    endTime = wendnesday.endTime
                }
            case 4:
                if let thursday = sheduleDataTimes.first { $0.day == 3 } {
                    beginTime = thursday.beginTime
                    endTime = thursday.endTime
                }
            case 5:
                if let friday = sheduleDataTimes.first { $0.day == 4 } {
                    beginTime = friday.beginTime
                    endTime = friday.endTime
                }
            case 6:
                if let saturday = sheduleDataTimes.first { $0.day == 5 } {
                    beginTime = saturday.beginTime
                    endTime = saturday.endTime
                }
            default:
                break
            }
            
            guard let beginTime, let endTime else { return  [] }
            guard !beginTime.isEmpty, !endTime.isEmpty else {
                return []
            }
            
            returnValue = allTimeList
                .map { $0.convertToHours() }
                .filter { $0 >= beginTime.convertToHours() && $0 <= endTime.convertToHours() }
                .map { $0.getTime() }
        }
        
        
        returnValue = duplicateCancelled(shedule: returnValue)
        returnValue = removeCrossRecordsTime(shedule: returnValue)
        
        return returnValue
    }
    
    private func removeCrossRecordsTime(shedule: [String]) -> [String] {
        
        guard let current, let records = dayList[current].records else { return [] }
        var returnValue = shedule
        
        let rightRecords = records.filter { $0.status != 1 }
        var cancelledRecords = records.filter { $0.status == 1 }
        
        let recordsRange = rightRecords.compactMap {
            ($0.date?.convertDate(to: 0).getDateMinutes() ?? 0)...(($0.duration ?? 0) + ($0.date?.convertDate(to: 0).getDateMinutes() ?? 0))
        }
        
        shedule.forEach { date in
            if let dateInt = date.getDateMinutes() {
                if let catchedRange = recordsRange.first { $0.contains(dateInt) } {
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
        guard let current, let records = dayList[current].records else { return [] }
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
        guard let current, var records = dayList[current].records else { return }
        
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
        guard let current,
              let breakTimes = RecordsCalendarController.serverShadule?.datatimes?[(dayList[current].weekdayNumber ?? 42)-1].breakTimes else {
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
    
    private func getCurrent() -> Int? {
        guard !dayList.isEmpty else { return nil }
        
        var returnValue: Int? = nil
        
        dayList.enumerated().forEach { index, day in
            if let date = day.date {
                if date.isToday() {
                    returnValue = index
                }
            }
        }
        return returnValue
    }
    
    private func isWeekend(date: Date?) -> Bool {
        guard let date else { return false }
        guard let weekends = serverShadule?.weekends else { return false }
        
        let dateStr = date.getDate()
        var returnValue = false
        
        weekends.forEach { weekendString in
            if weekendString.contains(dateStr) {
                returnValue = true
            }
        }
        
        return returnValue
    }
    
    private func getDateRecords(date: Date?) -> [Records] {
        guard let date else { return [] }
        
        var returnResult: [Records] = []
        let dateStr = date.getDate()
        
        records.forEach { record in
            if let date = record.date {
                if date.contains(dateStr) {
                    returnResult.append(record)
                }
            }
        }
        
        return returnResult
    }

    @IBAction func nextDate(_ sender: Any) {
        guard let current else { return }
        if current < (dayList.count - 1) {
            self.current! += 1
            fillDates()
        }
    }

    @IBAction func lastDate(_ sender: Any) {
        guard let current else { return }
        if current > 0 {
            self.current! -= 1
            fillDates()
        }
    }
}

extension CalendarDayController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let current else { return 0 }
        return tableModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = tableModel[indexPath.row]
        
        if let record = model.record{
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
        guard let current else { return }
        let tableModel = tableModel[indexPath.row]
        
        if let model = tableModel.record {
            let vc = getControllerRecord(controller: .recorddetail) as! RecordDetailController
            let currentDate = Date().getCurrentGmtDate()
            vc.model = model
            
            if let records = parentVC?.records {
                vc.records = records
            }
            
            if model.date?.convertDateToDate().timeIntervalSince1970 ?? 0 > currentDate.timeIntervalSince1970 {
                // будет
                vc.type = .future
                if model.status == 1 {
                    vc.type = .cancelled
                }
            } else if Int(currentDate.timeIntervalSince1970 - (model.date?.convertDateToDate().timeIntervalSince1970 ?? 0)) < (model.duration ?? 0) * 60 {
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
            parentVC?.navigationController?.pushViewController(vc, animated: true)
        } else {
            let date = dayList[current].date?.getDate()
            parentVC?.presenter.addActionWithDate("\(date ?? "") \(tableModel.date ?? "")")
        }
    }
}
