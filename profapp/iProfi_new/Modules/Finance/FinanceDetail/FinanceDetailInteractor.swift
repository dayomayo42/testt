//
//  FinanceDetailInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 02.11.2020.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD

protocol FinanceDetailInteractorProtocol: class {
    func configureView()
    func addAction(income: Bool)
    func getFinance(type: String, date: String)
    func clearStack()
    func postDelete(id: Int)
}

class FinanceDetailInteractor: FinanceDetailInteractorProtocol {
    weak var viewController: FinanceDetailController!
    weak var presenter: FinanceDetailPresenterProtocol!
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    
    
    init(viewController: FinanceDetailController, presenter: FinanceDetailPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        
        switch viewController.type {
        case .clearIncome, .serviceIncome, .productIncome:
            viewController.gradientView.firstColor = #colorLiteral(red: 0.4047238827, green: 0.896815002, blue: 0.593239367, alpha: 1)
            viewController.gradientView.secondColor = #colorLiteral(red: 0, green: 0.7526802421, blue: 0.3509902954, alpha: 1)
            viewController.cardTitle.text = "Всего доходов"
            viewController.tableOutcomeIncomeTitle.text = "Доходы:"
        case .otherConsumption, .serviceConsumption:
            viewController.gradientView.firstColor = #colorLiteral(red: 1, green: 0.4529553056, blue: 0.417629391, alpha: 1)
            viewController.gradientView.secondColor = #colorLiteral(red: 1, green: 0.2163060308, blue: 0.2202395797, alpha: 1)
            viewController.cardTitle.text = "Всего расходов"
            viewController.tableOutcomeIncomeTitle.text = "Расходы:"
        default: break
        }
        
        if viewController.type == .otherConsumption || viewController.type == .productIncome {
            viewController.addButton.isHidden = false
            viewController.stackView.isHidden = false
        } else {
            viewController.addButton.isHidden = true
            viewController.stackView.isHidden = false
        }
    }
    
    func addAction(income: Bool) {
        let vc = viewController.getControllerFinance(controller: .financeadd) as! FinanceAddConsumptionController
        vc.income = income
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getFinance(type: String, date: String) {
        SVProgressHUD.show()
        
        service.getFinance(type: type, date: date).subscribe { (response) in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                if response.success ?? false {
                    self.viewController.financeList = response.data ?? []
                    self.viewController.fillWithIndex(with: self.viewController.current, type: self.viewController.segment.selectedSegmentIndex)
                } else {
                    SVProgressHUD.showError(withStatus: response.message)
                }
            }
        } onError: { (error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func clearStack() {
        let subs = viewController.stackView.arrangedSubviews
        for item in subs {
            viewController.stackView.removeArrangedSubview(item)
        }
    }
    
    func postDelete(id: Int) {
        self.viewController.showHUD(show: true)
        
        service.deleteIncome(type: viewController.method, id: id).subscribe { response in
            SVProgressHUD.dismiss()
            if self.viewController != nil {
                self.getFinance(type: self.viewController.method, date: "2020-01-01/2020-12-20")
            }
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}

