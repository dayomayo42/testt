//
//  RecordsCalendarMonthController.swift
//  iProfi_new
//
//  Created by violy on 26.04.2023.
//

import Foundation
import UIKit

enum RecordsCalendarMonthType {
    case based
    case weekends
}

class RecordsCalendarMonthController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leadingContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    var createDelegate: RecordsDateDelegate?
    var changeDelegate: RecordsDateEditDelegate?
    var sheduleDelegate: SheduleDelegate?
    var parentVC: RecordsCalendarController?
    
    var records: [Records] = []
    
    var type: RecordsCalendarMonthType = .based
    
    var calendarItems: [MonthCalendarItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var presenter: RecordsCalendarMonthPresenterProtocol!
    let configurator: RecordsCalendarMonthConfiguratorProtocol = RecordsCalendarMonthConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        
        collectionView.allowsMultipleSelection = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let weekends = sheduleDelegate?.sheduleModel.weekends {
            
            let selectIndexes = calendarItems.enumerated().filter {
                switch $0.element {
                case .monthDay(let monthDay) where weekends.contains(monthDay.date?.getDate() ?? ""):
                    return true
                default:
                    return false
                }
            }.map{ $0.offset }
    
            selectIndexes.forEach { row in
                collectionView.selectItem(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .right)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        headerView.isHidden = ((createDelegate == nil) && (changeDelegate == nil) && (sheduleDelegate == nil))
        
        let remainder = (UIScreen.main.bounds.width - 32).truncatingRemainder(dividingBy: 7)
        
        guard remainder != 0 else {
            leadingContainerConstraint.constant = 16
            trailingContainerConstraint.constant = 16
            collectionView.layoutIfNeeded()
            return
        }
        
        leadingContainerConstraint.constant = 16 + remainder/2
        trailingContainerConstraint.constant = 16 + remainder/2
        
        collectionView.layoutIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let weekends = sheduleDelegate?.sheduleModel.weekends {
            
            let selectedIndexes = collectionView.indexPathsForSelectedItems
            
            var updatedWeekendDays: [String] = []
            
            selectedIndexes?.forEach({ indexPath in
                let item = calendarItems[indexPath.row]
                switch item {
                case .monthDay(var monthDay):
                    updatedWeekendDays.append(monthDay.date?.getDate() ?? "")
                default:
                    break
                }
            })
            
            sheduleDelegate?.sheduleModel.weekends = updatedWeekendDays
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToCurrentDate()
    }
    
    @IBAction func backAction() {
        presenter.backAction()
    }
    
    @IBAction func openShedule() {
        presenter.openShedule()
    }
}

extension RecordsCalendarMonthController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch calendarItems[indexPath.row] {
        case .monthDay(_), .empty, .weekDay(_):
            let cellWidth = (collectionView.bounds.width)/7
            return CGSize(width: cellWidth, height: cellWidth)
        case .month(_):
            return CGSize(width: collectionView.bounds.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = calendarItems[indexPath.row]
        
        switch item {
        case .monthDay(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! RecordsCalendarMonthDateCell
            cell.configure(model: model)
            return cell
        case .month(let name):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as! RecordsCalendarMonthNameCell
            cell.configure(name)
            return cell
        case .weekDay(let weekday):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekdayCell", for: indexPath) as! RecordsCalendarMonthWeekdayCell
            cell.configure(weekDay: weekday)
            return cell
        case .empty:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = calendarItems[indexPath.row]
        switch item {
        case .monthDay(var monthDay):
            
            guard sheduleDelegate == nil else { return }
            
            if let parentVC {
                parentVC.presenter.openCalendarDetail(monthCalendarDay: monthDay, allRecords: records)
            } else {
                presenter.openCalendarDetail(monthCalendarDay: monthDay)
            }
        default:
            print(indexPath.row)
        }
    }
    
    func scrollToCurrentDate() {
        
        let currentDateItemIndex = calendarItems.firstIndex(where: {
            switch $0 {
            case .monthDay(let monthDay) where monthDay.date == Date().getCurrentGmtDate().startOfMonth():
                return true
            default:
                return false
            }
        })
        
        if let currentDateItemIndex {
            collectionView.scrollToItem(at: IndexPath(row: currentDateItemIndex, section: 0), at: .centeredVertically, animated: false)
        }
    }
}
