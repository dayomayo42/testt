//
//  RecordsCalendarWeekController.swift
//  iProfi_new
//
//  Created by violy on 12.05.2023.
//

import Foundation
import UIKit

protocol RecordsCalendarWeekDelegate {
    func openRecord(record: Records, type: RecordsType)
}

class RecordsCalendarWeekViewController: UIViewController, RecordsCalendarWeekDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isScrolledOnce: Bool = false
    
    var parentVC: RecordsCalendarController?
    var records: [Records] = []
    
    var calendarItems: [[WeekDayCalendar]] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var presenter: RecordsCalendarWeekPresenterProtocol!
    let configurator: RecordsCalendarWeekConfiguratorProtocol = RecordsCalendarWeekConfigurator()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToCurrentDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func openRecord(record: Records, type: RecordsType) {
        guard let parentVC else { return }
        let vc = parentVC.getControllerRecord(controller: .recorddetail) as! RecordDetailController
        vc.hidesBottomBarWhenPushed = true
        vc.model = record
        vc.type = type
        vc.records = records
        parentVC.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecordsCalendarWeekViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekMain", for: indexPath) as! WeekMainCell
        let model = calendarItems[indexPath.row]
        cell.configure(model: model)
        cell.delegate = self
        return cell
    }
    
    func scrollToCurrentDate() {
        
        let currentIndex = calendarItems.firstIndex {
            $0.contains { $0.date?.isToday() ?? false }
        }
        
        if let currentIndex {
            collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredVertically, animated: false)
        }
    }
}
