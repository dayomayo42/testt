//
//  RecordTimeШтеукфсещк.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 05.11.2020.
//

import Foundation
import UIKit

protocol RecordTimeInteractorProtocol: class {
    func configureView()
}

class RecordTimeInteractor: RecordTimeInteractorProtocol {
    weak var viewController: RecordTimeController!
    weak var presenter: RecordTimePresenterProtocol!
    
    init(viewController: RecordTimeController, presenter: RecordTimePresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        viewController.morningCollectionView.allowsMultipleSelection = true
        viewController.dayCollectionView.allowsMultipleSelection = true
        viewController.eveningCollectionView.allowsMultipleSelection = true
        
        let times = viewController.delegate?.sheduleModel.datatimes?[viewController.delegate?.pos ?? 0].availableTimes
        
        for item in times ?? [] {
            if viewController.morningList.contains(item) {
                let i = viewController.morningList.firstIndex(of: item) ?? 0
                viewController.morningCollectionView.selectItem(at: IndexPath(row: i, section: 0), animated: true, scrollPosition: .bottom)
            } else if viewController.dayList.contains(item) {
                let i = viewController.dayList.firstIndex(of: item) ?? 0
                viewController.dayCollectionView.selectItem(at: IndexPath(row: i, section: 0), animated: true, scrollPosition: .bottom)
            } else if viewController.eveningList.contains(item) {
                let i = viewController.eveningList.firstIndex(of: item) ?? 0
                viewController.eveningCollectionView.selectItem(at: IndexPath(row: i, section: 0), animated: true, scrollPosition: .bottom)
            }
        }
        
        
        
        let linesMorning = CGFloat(viewController.morningList.count)/5
        var morningHeight = 40 * Int(linesMorning)
        if linesMorning > CGFloat(Int(linesMorning)) {
            morningHeight = 40 * Int(linesMorning + 1)
        }
        viewController.moringHeight.constant = CGFloat(morningHeight)
        
        let linesDay = CGFloat(viewController.dayList.count)/5
        var dayHeight = 40 * Int(linesDay)
        if linesDay > CGFloat(Int(linesDay)) {
            dayHeight = 40 * Int(linesDay + 1)
        }
        viewController.dayHeight.constant = CGFloat(dayHeight)
        
        let linesEve = CGFloat(viewController.eveningList.count)/5
        var eveHeight = 40 * Int(linesEve)
        if linesEve > CGFloat(Int(linesEve)) {
            eveHeight = 40 * Int(linesEve + 1)
        }
        viewController.eveningHeight.constant = CGFloat(eveHeight)
    }
}

