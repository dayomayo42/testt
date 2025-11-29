//
//  WeekMainCell.swift
//  iProfi_new
//
//  Created by violy on 17.05.2023.
//

import Foundation
import UIKit

class WeekMainCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var datesCollectionView: UICollectionView!
    
    static var offsetPosition: CGPoint? = nil
    
    var weekModel: [WeekDayCalendar] = []
    var delegate: RecordsCalendarWeekDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let prevOffset = WeekMainCell.offsetPosition {
            collectionView.setContentOffset(prevOffset, animated: false)
        } else {
            scrollToCurrentTime()
        }
    }
    
    func configure(model: [WeekDayCalendar]) {
        guard model.count == 7 else { return }
        self.weekModel = model
        
        collectionView.reloadData()
        datesCollectionView.reloadData()
    }
}

extension WeekMainCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.datesCollectionView {
            
            let cellWidth = (collectionView.bounds.width)/8
            
            return CGSize(width: cellWidth, height: collectionView.frame.height)
        } else {
            
            let cellWidth = (collectionView.bounds.width)/8
            let cellHeight = CGFloat(120*24)
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.datesCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDate", for: indexPath) as! WeekDateCell
            
            if indexPath.row == 0 {
                cell.configure(day: nil, month: nil)
            } else {
                
                let model = weekModel[indexPath.row - 1]
                let day = "\(model.number ?? "") \(model.date?.getWeekNameShortString() ?? "")"
                let month = model.date?.getMonthString(short: true) ?? ""
                
                cell.configure(day: day, month: month)
            }
            
            return cell
            
        } else {
            
            guard indexPath.row != 0 else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "WeekTime", for: indexPath) as! WeekTimeCell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDay", for: indexPath) as! WeekDayCell
            
            let model = weekModel[indexPath.row - 1]
            cell.configure(model: model)
            cell.delegate = delegate
            
            return cell
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        WeekMainCell.offsetPosition = collectionView.contentOffset
    }
    
    func scrollToCurrentTime() {
        let minutesYCoords = Date().getCurrentGmtDate().getMinutesOfDate() * 2
        collectionView.setContentOffset(CGPoint(x: 0, y: minutesYCoords), animated: false)
    }
}
