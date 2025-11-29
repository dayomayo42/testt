//
//  RecordTimeController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 05.11.2020.
//

import UIKit

class RecordTimeController: UIViewController {
    var presenter: RecordTimePresenterProtocol!
    let configurator: RecordTimeConfiguratorProtocol = RecordTimeConfigurator()
    
    let allList: [String] = ["00:00", "00:15", "00:30", "00:45", "01:00", "01:15", "01:30", "01:45", "02:00", "02:15", "02:30", "02:45", "03:00", "03:15", "03:30", "03:45", "04:00", "04:15", "04:30", "04:45", "05:00", "05:15", "05:30", "05:45", "06:00", "06:15", "06:30", "06:45", "07:00", "07:15", "07:30", "07:45", "08:00", "08:15", "08:30", "08:45", "09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:15", "15:30", "15:45", "16:00", "16:15", "16:30", "16:45", "17:00", "17:15", "17:30", "17:45", "18:00", "18:15", "18:30", "18:45", "19:00", "19:15", "19:30", "19:45", "20:00", "20:15", "20:30", "20:45", "21:00", "21:15", "21:30", "21:45", "22:00", "22:15", "22:30", "22:45", "23:00", "23:15", "23:30", "23:45"]
    
    var sortedAllList: [String] = []
    var morningList: [String] = []
    var dayList: [String] = []
    var eveningList: [String] = []
    
    var delegate: SheduleDelegate?
    
    @IBOutlet weak var eveningHeight: NSLayoutConstraint!
    @IBOutlet weak var dayHeight: NSLayoutConstraint!
    @IBOutlet weak var moringHeight: NSLayoutConstraint!
    @IBOutlet weak var eveningCollectionView: UICollectionView!
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var morningCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortTimes()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func sortTimes() {
        
        if delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].beginTime?.withoutSpaces().count ?? 0 > 0 && delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].endTime?.withoutSpaces().count ?? 0 > 0 {
            for item in allList {
                if item.convertTime() >= delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].beginTime?.convertTime() ?? 0 && item.convertTime() <= delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].endTime?.convertTime() ?? 0 {
                    if delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].breakTimes.count == 2 {
                        if item.convertTime() < delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].breakTimes[0].convertTime() ?? 0 || item.convertTime() >= delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].breakTimes[1].convertTime() ?? 0 {
                            sortedAllList.append(item)
                        }
                    } else {
                        sortedAllList.append(item)
                    }
                }
            }
        } else {
            sortedAllList = allList
        }
        
        for item in sortedAllList {
            if item.convertTime() < 720 {
                morningList.append(item)
            } else if item.convertTime() < 1080 {
                dayList.append(item)
            } else {
                eveningList.append(item)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        var times: [String] = []
        for item in eveningCollectionView.indexPathsForSelectedItems ?? [] {
            times.append(eveningList[item.row])
        }
        
        for item in dayCollectionView.indexPathsForSelectedItems ?? [] {
            times.append(dayList[item.row])
        }
        
        for item in morningCollectionView.indexPathsForSelectedItems ?? [] {
            times.append(morningList[item.row])
        }
        
        delegate?.sheduleModel.datatimes?[delegate?.pos ?? 0].availableTimes = times
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
}

extension RecordTimeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return morningList.count
        case 1:
            return dayList.count
        default:
            return eveningList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecordTimeCell
        switch collectionView.tag {
        case 0:
            cell.configure(with: morningList[indexPath.row])
            if morningCollectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
                cell.cellPlate.borderWidthV = 0
                cell.cellPlate.backgroundColor = #colorLiteral(red: 0, green: 0.4347224832, blue: 0.9958541989, alpha: 1)
                cell.timeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                cell.cellPlate.borderWidthV = 1
                cell.cellPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        case 1:
            cell.configure(with: dayList[indexPath.row])
            if dayCollectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
                cell.cellPlate.borderWidthV = 0
                cell.cellPlate.backgroundColor = #colorLiteral(red: 0, green: 0.4347224832, blue: 0.9958541989, alpha: 1)
                cell.timeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                cell.cellPlate.borderWidthV = 1
                cell.cellPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        default:
            cell.configure(with: eveningList[indexPath.row])
            if eveningCollectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
                cell.cellPlate.borderWidthV = 0
                cell.cellPlate.backgroundColor = #colorLiteral(red: 0, green: 0.4347224832, blue: 0.9958541989, alpha: 1)
                cell.timeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                cell.cellPlate.borderWidthV = 1
                cell.cellPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 80)/5
        return CGSize(width: width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RecordTimeCell
        cell.cellPlate.borderWidthV = 0
        cell.cellPlate.backgroundColor = #colorLiteral(red: 0, green: 0.4347224832, blue: 0.9958541989, alpha: 1)
        cell.timeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RecordTimeCell
        cell.cellPlate.borderWidthV = 1
        cell.cellPlate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.timeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
