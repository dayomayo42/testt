//
//  NewSubscriptionListInteractor.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 18.05.2022.
//

import Foundation
import UIKit
import Moya
import RxSwift
import SVProgressHUD
import TinkoffASDKCore
import TinkoffASDKUI
import AVFAudio

protocol NewSubscriptionListInteractorProtocol {
    func configureView()
    func subscribe(pos: Int)
}

class NewSubscriptionListInteractor: NewSubscriptionListInteractorProtocol {
    var viewController: NewSubscriptionListController!
    var presenter: NewSubscriptionListPresenterProtocol!
    private let networkingLayer = NetworkingViewModel()
    private let disposeBag = DisposeBag()
    
    var sdk: AcquiringUISDK!
    var acquiringSDKConfiguration: AcquiringSdkConfiguration?
    weak var scaner: AcquiringScanerProtocol?
    
    let customerKey = Authorization.id
    var customerEmail: String = Authorization.email ?? ""
    
    private var rebuidIdCards: [PaymentCard]?
    var products: [PaymentProduct] = []

    var summa = ""
    var orderId = ""

    var paymentCardId: PaymentCard?
    var paymentCardParentPaymentId: PaymentCard?
    lazy var paymentApplePayConfiguration = AcquiringUISDK.ApplePayConfiguration()
    
    init(viewController: NewSubscriptionListController, presenter: NewSubscriptionListPresenterProtocol) {
        self.viewController = viewController
        self.presenter = presenter
    }
    
    func configureView() {
        
        viewController.subObject?.subs?.reverse()
        
        let subViews = viewController.typesStack.arrangedSubviews
        var localizedMonth = ""
        
        for index in stride(from: subViews.count-1, through: 0, by: -1) {
            print(index)
            let recognizer = SubscribeRecognizer(target: viewController, action: #selector(viewController.subscribeAction))
            recognizer.pos = index
            
            let subscribeView = subViews[index] as? SubscribeView
    
            print(viewController.subObject?.subs?[index].duration)
    
            if viewController.subObject?.subs?[index].duration != 1 {
                localizedMonth = " месяцев"
            } else {
                localizedMonth = " месяц"
            }
            
            subscribeView?.intervalLabel.text = (viewController.subObject?.subs?[index].duration?.description ?? "") + localizedMonth
            subscribeView?.fullPriceLabel.text = (viewController.subObject?.subs?[index].total?.description ?? "") + " \(Settings.currencyCym ?? "")"
            subscribeView?.pricePerMonthLabel.text = (viewController.subObject?.subs?[index].price?.description ?? "") + " \(Settings.currencyCym ?? "") / мес."
            if viewController.subObject?.subs?[index].economy != 0 {
            subscribeView?.economyLabel.text = "Экономия " + (viewController.subObject?.subs?[index].economy?.description ?? "") + " \(Settings.currencyCym ?? "")"
            } else {
                subscribeView?.economyLabel.removeFromSuperview()
            }
            subViews[index].isUserInteractionEnabled = true
            subViews[index].addGestureRecognizer(recognizer)
            
            if Settings.subId == viewController.subObject?.subs?[index].id {
                viewController.mySubscriptionView.isHidden = false
                if Settings.subTrial {
                    viewController.mySubscriptioLabel.text = "Активна пробная подписка на 14 дней"
                } else {
                    viewController.mySubscriptioLabel.text = "Активна подписка на \(viewController.subObject?.subs?[index].duration?.description ?? "")\(localizedMonth)"
                }
            }
        }
        
        viewController.titleLabel.text = viewController.subObject?.name?.uppercased()
        viewController.descriptionLabel.text = viewController.subObject?.convertDescriptionToString()
        
        initOleg()
    }
    
    func subscribe(pos: Int) {
        let price = viewController.subObject?.subs?[pos].total ?? 1
        let id = viewController.subObject?.subs?[pos].id ?? 1
        let name = viewController.subObject?.name?.uppercased() ?? ""
        products = [PaymentProduct(price: price, name: name, id: id)]
        openCard(pos: pos)
    }
    
    func initOleg() {
        let credentional = AcquiringSdkCredential(terminalKey: PaymentKeys.terminalKey,
                                                  publicKey: PaymentKeys.testPublicKey)

        acquiringSDKConfiguration = AcquiringSdkConfiguration(credential: credentional, server: .prod)
        acquiringSDKConfiguration?.logger = AcquiringLoggerDefault()
        
        if let sdk = try? AcquiringUISDK(configuration: acquiringSDKConfiguration!) {
            self.sdk = sdk
        }

        sdk.setupCardListDataProvider(for: "\(customerKey ?? 0)", statusListener: viewController)
        try! sdk?.cardListReloadData()
        sdk.addCardNeedSetCheckTypeHandler = {
            return AppSetting.shared.addCardChekType
        }
    }
    
    func openCard(pos: Int) {
        getOrderIdFromBackend(id: viewController.subObject?.subs?[pos].id ?? 0) { data in
            self.orderId = data?.orderID ?? ""
            self.selectRebuildCard()
            var paymentData = self.createPaymentData()
            paymentData.savingAsParentPayment = false
            self.presentPaymentView(paymentData: paymentData, viewConfigration: self.acquiringViewConfiguration(pos: pos))
        }
    }
    
    private func presentPaymentView(paymentData: PaymentInitData, viewConfigration: AcquiringViewConfiguration) {
        sdk.presentPaymentView(on: viewController, paymentData: paymentData, configuration: viewConfigration) { [weak self] response in
            self?.responseReviewing(response)
        }
    }
    
    private func acquiringViewConfiguration(pos: Int) -> AcquiringViewConfiguration {
        let viewConfigration = AcquiringViewConfiguration()
        viewConfigration.scaner = scaner

        viewConfigration.fields = []
        let title = NSAttributedString(string: "Profapp", attributes: [.font: UIFont.boldSystemFont(ofSize: 22)])
        let amountString = Utils.formatAmount(NSDecimalNumber(value: Int(productsAmount())))
        let amountTitle = NSAttributedString(string: "Сумма: \(products.first?.price ?? 1)\(Settings.currencyCym ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 17)])
        viewConfigration.fields.append(AcquiringViewConfiguration.InfoFields.amount(title: title, amount: amountTitle))

        let productsDetatils = NSMutableAttributedString()
        productsDetatils.append(NSAttributedString(string: "Оплата подписки\n", attributes: [.font: UIFont.systemFont(ofSize: 17)]))
        

        let productsDetails = products.map { (product) -> String in
            product.name
        }.joined(separator: ", ")

        productsDetatils.append(NSAttributedString(string: productsDetails, attributes: [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor(red: 0.573, green: 0.6, blue: 0.635, alpha: 1)]))

        viewConfigration.fields.append(AcquiringViewConfiguration.InfoFields.detail(title: productsDetatils))

        if AppSetting.shared.showEmailField {
            viewConfigration.fields.append(AcquiringViewConfiguration.InfoFields.email(value: nil, placeholder: NSLocalizedString("plaseholder.email", comment: "Отправить квитанцию по адресу")))
        }

        viewConfigration.viewTitle = NSLocalizedString("Оплата подписки", comment: "Оплата")
        viewConfigration.localizableInfo = AcquiringViewConfiguration.LocalizableInfo(lang: AppSetting.shared.languageId)

        return viewConfigration
    }

    private func responseReviewing(_ response: Result<PaymentStatusResponse, Error>) {
        switch response {
        case let .success(result):
            if result.status != .cancelled {
                presenter.backToRootVCAction()
            }
            break
        case .failure:
            let alert = UIAlertController(title: "Ошибка", message: "Ошибка оплаты", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default))
            viewController.present(alert, animated: true)
            break
        }
    }

    private func productsAmount() -> Int {
        var amount: Int = 0

        products.forEach { product in
            amount += product.price
        }
        
        return amount
    }

    private func createPaymentData() -> PaymentInitData {
        let amount = productsAmount()
        var paymentData = PaymentInitData(amount: NSDecimalNumber(value: amount), orderId: "\(orderId)", customerKey: "\(customerKey ?? 0)")
        paymentData.description = "ProfApp"
        var receiptItems: [Item] = []
        
        receiptItems.append(Item(amount: NSDecimalNumber(value: products.first?.price ?? 0), price: NSDecimalNumber(value: products.first?.price ?? 0), name: products.first?.name ?? "", tax: .vat10))
        
        paymentData.receipt = Receipt(shopCode: nil,
                                      email: customerEmail,
                                      taxation: .patent,
                                      phone: Authorization.phone ?? "",
                                      items: receiptItems,
                                      agentData: nil,
                                      supplierInfo: nil,
                                      customer: "\(customerKey ?? 0)",
                                      customerInn: nil)

        return paymentData
    }
    
    private func getOrderIdFromBackend(id: Int, completion: @escaping (SubInfo?) -> ()) {
        SVProgressHUD.show()
        networkingLayer.getSubOrderId(id: id).subscribe { (response) in
            SVProgressHUD.dismiss()
            guard self.viewController != nil else { return }
            guard let data = response.data else { return }
            completion(data)
        } onError: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
            completion(nil)
        }
    }

    private func selectRebuildCard() {
        if let cards: [PaymentCard] = rebuidIdCards, cards.isEmpty == false {
            let cardVC = SelectRebuildCardViewController()
            cardVC.cards = cards
            cardVC.onSelectCard = { card in
                self.paymentCardParentPaymentId = card
            }

            viewController.present(UINavigationController(rootViewController: cardVC), animated: true, completion: nil)
        }
    }
}

