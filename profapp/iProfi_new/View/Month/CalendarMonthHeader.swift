//
//  CalendarMonthHeader.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.11.2020.
//

import Foundation
import UIKit
import FSCalendar

class CalendarMonthHeader: UIView {
    private weak var contentView: UIView?
    private weak var bottomBorder: UIView?
    private weak var weekdayView: FSCalendarWeekdayView?
    @IBOutlet weak var titleLabel: UILabel!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        fromNib()
            
        var view: UIView?
        var label: UILabel?

        view = UIView(frame: CGRect.zero)
        view?.backgroundColor = UIColor.clear
        addSubview(view!)
        contentView = view

        label = UILabel(frame: CGRect.zero)
        label?.textAlignment = .center
        label?.numberOfLines = 0
        if let label = label {
            contentView?.addSubview(label)
        }
        titleLabel = label

        view = UIView(frame: CGRect.zero)
        view?.backgroundColor = .white
        if let view = view {
            contentView?.addSubview(view)
        }
        bottomBorder = view
    }
}


class FSCalendarStickyHeader {
    private weak var contentView: UIView?
    private weak var bottomBorder: UIView?
    private weak var weekdayView: FSCalendarWeekdayView?

    init(frame: CGRect) {
        super.init(frame: frame)
        var view: UIView?
        var label: UILabel?

        view = UIView(frame: CGRect.zero)
        view?.backgroundColor = UIColor.clear
        addSubview(view)
        contentView = view

        label = UILabel(frame: CGRect.zero)
        label?.textAlignment = .center
        label?.numberOfLines = 0
        if let label = label {
            contentView?.addSubview(label)
        }
        titleLabel = label

        view = UIView(frame: CGRect.zero)
        view?.backgroundColor = FSCalendarStandardLineColor
        if let view = view {
            contentView?.addSubview(view)
        }
        bottomBorder = view

        let weekdayView = FSCalendarWeekdayView()
        contentView?.addSubview(weekdayView)
        self.weekdayView = weekdayView
    }
    
    
    
    
    
}

