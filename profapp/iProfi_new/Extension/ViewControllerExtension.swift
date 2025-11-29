//
//  ViewControllerExtension.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 28.08.2020.
//

import Foundation
import UIKit
import SVProgressHUD
enum ControllersID: String {
    //main
    case launch = "LaunchController"
    case auth = "AuthController"
    case country = "ChooseCountryController"
    case remember = "RememberPassController"
    case remembersuccess = "RememberSuccessController"
    case regphone = "RegPhoneController"
    case regpass = "RegPassController"
    case reginfo = "RegInfoController"
    case regsphere = "RegSphereController"
    case hellogays = "HelloGaysController"
    case onboarding = "OnboardingController"
    case update = "UpdateScreenViewController"
    case subTrial = "SubscribeTrialViewController"
    //nav
    case tabbar = "TabBarController"
    //records
    case createRecord = "RecordsCreateController"
    case recordsSearch = "RecordsSearchController"
    case clients = "ClientsController"
    case recordservices = "RecordsServiceController"
    case recordsproduct = "RecordsProductsController"
    case recordsNotificAlert = "RecordsNotificAlert"
    case recorddetail = "RecordDetailController"
    case recordscalendar = "RecordsCalendarController"
    case recordsCreateProduct = "RecordsProductCategoryController"
    //
    case calendarday = "CalendarDayController"
    case calendarweek = "CalendarWeekController"
    case calendarmonth = "RecordsCalendarMonthController"
    case calendartimes = "CalendarTimesController"
    case newcalendarweek = "RecordsCalendarWeekViewController"
    //clients
    case clientDetail = "ClientDetailController"
    case clientEdit = "ClientEditController"
    case addClient = "AddClientController"
    case addClientAlert = "AddClientBottom"
    case contactList = "ContactListController"
    case clientStatus = "ClientStatusController"
    //profile
    case profiledetail = "ProfileDetailController"
    case spec = "SpecController"
    case products = "ProductController"
    case categoryadd = "ProductCategoryAddController"
    case categorudetail = "CategoryDetailController"
    case productadd = "ProductAddController"
    case productdetail = "ProductDetailController"
    case notifications = "NotificationsController"
    case notificationdetail = "NotificationDetailController"
    case notificationsettings = "NotificationSettingsController"
    case notificationsettingsdetail = "NotificationSettingsDetailController"
    case notificationties = "TimeAlertController"
    case usernotif = "UserNotificationsController"
    case notifalert = "UserNotificationAlert"
    
    case stockarrival = "StockArrivalController"
    case stockconsuption = "StockConsumptionController"
    case stockbalance = "StockBalanceController"
    case updatedebt = "StockUpdateDebtController"
    case stockdetail = "StockAllOrderDetailController"
    case stock = "StockController"
    //
    case suppliers = "SuppliersController"
    case supplieradd = "SupplierAddController"
    case supplierdetail = "SupplierDetailController"
    case productstock = "StockProdutsController"
    case productstockadd = "StockProductAddController"
    case productstockdetail = "StockProductDetailController"
    case stockorders = "StockOrdersController"
    case stockallorders = "StockAllOrdersController"
    case filtertype = "FilterTypeAlert"
    case stockdebts = "StockDebtsController"
    case debtsdetail = "StockDebtsDetailController"
    //
    case services = "ServicesController"
    case serviceDetail = "ServiceDetailController"
    case serviceAdd = "ServiceAddController"
    case sharealert = "ShareAlert"
    //
    case support = "SupportController"
    case answer = "AnswerController"
    case answerdeatiled = "AnswerDetailController"
    case feedback = "FeedbackController"
    //
    case shedule = "SheduleController"
    case onlinesettings = "OnlineRecordSettingsController"
    case onlinerecords = "OnlineRecordController"
    case recordtime = "RecordTimeController"
    case singleAlert = "SheduleSingleBottom"
    case doubleAlert = "SheduleDoubleBottom"
    //
    case settings = "SettingsController"
    case currency = "CurrencyBottom"
    //
    case financedetail = "FinanceDetailController"
    case financeadd = "FinanceAddConsumptionController"
    
    case review = "ReviewController"
    case subscription = "NewSubscriptionController"//"SubscriptionController"
    case subscriptionList = "NewSubscriptionListController"
    case subscriptionDetails = "NewSubscriptionDetailsViewController"
    case specializationsList = "SpecializationsListController"
    case study = "StudyViewController"
    case studyDetail = "StudyDetailController"
    case studyList = "StudyListController"
    case myStudy = "MyStudyController"
    case myStudyDetail = "MyStudyDetailController"
    case sales = "SalesController"
    case salesCategory = "SalesCategoryController"
    case salesCategoryNext = "SalesCategoryNextController"
    case salesCategoryDetail = "SalesCategoryDetailController"
    case salesDistributors = "SalesDistributorsController"
    case salesDistributorsNext = "SalesDistributorsNextController"
    case salesDistributorsDetail = "SalesDistributorsDetailController"
    case liveJournal = "LiveJournalController"
    case liveJournalList = "LiveJournalListController"
    case liveJournalDetail = "LiveJournalDetailController"
    case webParthner = "WebParthnerController"
}

extension UIViewController {
    func getController(controller: ControllersID) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: controller.rawValue)
        return vc
    }
    
    func getControllerInfoBlock(controller: ControllersID) -> UIViewController {
        let vc = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: controller.rawValue)
        return vc
    }
    
    func getControllerAppNavigation(controller: ControllersID) -> UIViewController {
        let vc = UIStoryboard(name: "AppNavigation", bundle: nil).instantiateViewController(withIdentifier: controller.rawValue)
        return vc
    }
    
    func getControllerRecord(controller: ControllersID) -> UIViewController {
        let vc = UIStoryboard(name: "Records", bundle: nil).instantiateViewController(withIdentifier: controller.rawValue)
        return vc
    }
    
    func getControllerClients(controller: ControllersID) -> UIViewController {
        let vc = UIStoryboard(name: "Clients", bundle: nil).instantiateViewController(withIdentifier: controller.rawValue)
        return vc
    }
    
    func getControllerProfile(controller: ControllersID) -> UIViewController {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: controller.rawValue)
        return vc
    }
    
    func getControllerFinance(controller: ControllersID) -> UIViewController {
        let vc = UIStoryboard(name: "Finance", bundle: nil).instantiateViewController(withIdentifier: controller.rawValue)
        return vc
    }
    
    func showHUD(show: Bool) {
        if show {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
    
    func showError(_ error: String) {
        SVProgressHUD.showError(withStatus: error)
    }
}

extension UIViewController {
    func presentOnRoot(_ viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: true, completion: nil)
    }
}
