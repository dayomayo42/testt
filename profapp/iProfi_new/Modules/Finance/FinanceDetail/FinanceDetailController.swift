//
//  FinanceDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import UIKit

enum FinanceType {
    case clearIncome
    case serviceIncome
    case serviceConsumption
    case productIncome
    case otherConsumption
}

struct MonthDate {
    var name: String?
    var index: String?
}

struct DoubleDate {
    let from: String?
    let to: String?
}

class FinanceDetailController: UIViewController {
    var presenter: FinanceDetailPresenterProtocol!
    let configurator: FinanceDetailConfiguratorProtocol = FinanceDetailConfigurator()
    var method: String = ""
    var type: FinanceType?
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var sumLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var gradientView: GradientView!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    var titleCategory = ""
    @IBOutlet var cardTitle: UILabel!

    @IBOutlet var changePlateView: UIView!

    @IBOutlet weak var tableOutcomeIncomeTitle: UILabel!
    
    var financeViews: [FinanceProductView] = []

    var financeList: [Finance] = []
    var sortedArray: [Finance] = []
    var years: [String] = []
    var monthNames: [MonthDate] = [MonthDate(name: "Январь", index: "01"), MonthDate(name: "Февраль", index: "02"), MonthDate(name: "Март", index: "03"), MonthDate(name: "Апрель", index: "04"), MonthDate(name: "Май", index: "05"), MonthDate(name: "Июнь", index: "06"), MonthDate(name: "Июль", index: "07"), MonthDate(name: "Август", index: "08"), MonthDate(name: "Сентябрь", index: "09"), MonthDate(name: "Октябрь", index: "10"), MonthDate(name: "Ноябрь", index: "11"), MonthDate(name: "Декабрь", index: "12")]
    var weeks: [DoubleDate] = []
    var month: [DoubleDate] = []

    var current = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        daysGet()
        monthGet()
    }

    @IBAction func changeAction(_ sender: Any) {
        financeViews.forEach { finview in
            finview.showHideCross()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.getFinance(type: method, date: "2020-01-01/2020-12-20")
    }

    func monthGet() {
        let dateInWeek = Date().getCurrentGmtDate()

        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: dateInWeek) - 1
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: dateInWeek)!

        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .month, value: $0 - dayOfWeek, to: dateInWeek) }

        print(days)
    }

    func daysGet() {
        let dateInWeek = Date().getCurrentGmtDate()

        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: dateInWeek) - 1
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: dateInWeek)!

        for index in 0 ..< 100 {
            let days = (weekdays.lowerBound ..< weekdays.upperBound)
                .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek - (index * 7), to: dateInWeek) }

            let week = DoubleDate(from: convertDateToString(date: days.first!), to: convertDateToString(date: days.last!))
            weeks.append(week)
        }

        let year = Calendar.current.component(.year, from: Date())
        let curmonth = Date().getMonth()
        for item in 2018 ... year {
            years.append("\(item)")
            for mon in monthNames {
                if item == year {
                    if mon.index?.toInt() ?? 0 <= curmonth.toInt() ?? 0 {
                        if mon.index?.toInt() == 12 {
                            month.append(DoubleDate(from: "01.\(mon.index ?? "").\(item)", to: "01.01.\(item + 1)"))
                        } else {
                            let newMonth = (mon.index?.toInt() ?? 0) + 1 < 10 ? "0\((mon.index?.toInt() ?? 0) + 1)" : "\((mon.index?.toInt() ?? 0) + 1)"
                            month.append(DoubleDate(from: "01.\(mon.index ?? "").\(item)", to: "01.\(newMonth).\(item)"))
                        }
                    }
                } else {
                    if mon.index?.toInt() == 12 {
                        month.append(DoubleDate(from: "01.\(mon.index ?? "").\(item)", to: "01.01.\(item + 1)"))
                    } else {
                        let newMonth = (mon.index?.toInt() ?? 0) + 1 < 10 ? "0\((mon.index?.toInt() ?? 0) + 1)" : "\((mon.index?.toInt() ?? 0) + 1)"
                        month.append(DoubleDate(from: "01.\(mon.index ?? "").\(item)", to: "01.\(newMonth).\(item)"))
                    }
                }
            }
        }
        month.reverse()
        years.reverse()

        fillWithIndex(with: current, type: segment.selectedSegmentIndex)
    }

    func convertDateToString(date: Date) -> String {
        let dateFormatterTo = DateFormatter()
        dateFormatterTo.dateFormat = "dd.MM.yyyy"
        return dateFormatterTo.string(from: date)
    }

    func fillWithIndex(with index: Int, type: Int) {
        dateLabel.text = ""
        if type == 0 {
            dateLabel.text = "\(weeks[index].from ?? "") - \(weeks[index].to ?? "")"
            filterToDates(from: weeks[index].from ?? "", to: weeks[index].to ?? "")
        } else if type == 1 {
            dateLabel.text = month[index].from?.convertDate(to: 5).capitalized
            filterToDates(from: month[index].from ?? "", to: month[index].to ?? "")
        } else if type == 2 {
            dateLabel.text = "\(years[index])"
            filterToDates(from: "1.01.\(years[index])", to: "31.12.\(years[index])")
        }
    }

    func filterToDates(from: String, to: String) {
        sortedArray = []
        var sum = 0
        for item in financeList {
            let dateString = item.date?.split(separator: "T").first
            let miles = "\(dateString ?? "")".convertDate(to: 4).convertDateToDateWTime().timeIntervalSince1970
            //   print("\(dateString ?? "")".convertDate(to: 4), miles)

            if miles >= from.convertDateToDateWTime().timeIntervalSince1970 && miles <= to.convertDateToDateWTime().timeIntervalSince1970 {
                sortedArray.append(item)
                sum += item.price ?? 0
            }
        }

        presenter.clearStack()
        financeViews = []
        if sortedArray.contains(where: { $0.id ?? 0 != 0 }) {
            let products = sortedArray.filter { item in
                item.id ?? 0 > 0
            }

            if products.count > 0 {
                changePlateView.isHidden = false
                stackView.isHidden = false
                for stackItem in products {
                    let view = FinanceProductView()
                    if (stackItem.elems?.count ?? 0) > 0 {
                        stackItem.elems?.forEach({ item in
                            view.nameLabel.text = item.name
                            view.priceLabel.text = "\(item.price ?? 0) \(Settings.currencyCym ?? "")"
                            view.object = item
                            let recognizer = FinanceDeleteRecognizer(target: self, action: #selector(self.deleteShit(_:)))
                            recognizer.headline = view
                            view.deleteButton.addGestureRecognizer(recognizer)
                            financeViews.append(view)
                            stackView.addArrangedSubview(view)
                        })
                    } else {
                        view.nameLabel.text = stackItem.name
                        view.priceLabel.text = "\(stackItem.price ?? 0) \(Settings.currencyCym ?? "")"
                        view.object = stackItem
                        let recognizer = FinanceDeleteRecognizer(target: self, action: #selector(self.deleteShit(_:)))
                        recognizer.headline = view
                        view.deleteButton.addGestureRecognizer(recognizer)
                        financeViews.append(view)
                        stackView.addArrangedSubview(view)
                    }
                }
            } else {
                changePlateView.isHidden = true
                stackView.isHidden = true
            }
        } else {
            changePlateView.isHidden = true
            stackView.isHidden = true
        }

        sumLabel.text = "\(sum) \(Settings.currencyCym ?? "")"
    }
    
    
    @objc func deleteShit(_ recognizer: FinanceDeleteRecognizer) {
        let itemView = recognizer.headline
        presenter.postDelete(id: itemView?.object?.id ?? 0)
    }

    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }

    @IBAction func addAction(_ sender: Any) {
        presenter.addAction(income: type == .productIncome ? true : false)
    }

    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        current = 0
        fillWithIndex(with: current, type: segment.selectedSegmentIndex)
    }

    @IBAction func nextAction(_ sender: Any) {
        if current > 0 {
            current -= 1
            fillWithIndex(with: current, type: segment.selectedSegmentIndex)
        }
    }

    @IBAction func lastAction(_ sender: Any) {
        if current < (segment.selectedSegmentIndex == 0 ? weeks.count - 1 : segment.selectedSegmentIndex == 1 ? month.count - 1 : years.count - 1) {
            current += 1
            fillWithIndex(with: current, type: segment.selectedSegmentIndex)
        }
    }
}

class FinanceDeleteRecognizer: UITapGestureRecognizer {
    var headline: FinanceProductView?
}
