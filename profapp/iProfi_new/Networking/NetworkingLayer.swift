//
//  NetworkingLayer.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import Foundation
import Moya
import RxSwift

struct NetworkingViewModel {
    private let provider: Reactive<MoyaProvider<MoyaConnector>>

    init(provider: Reactive<MoyaProvider<MoyaConnector>> = MoyaProvider<MoyaConnector>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]).rx) {
        self.provider = provider
    }

    func postSendCall(phone: String) -> Observable<SendCallModel> {
        provider.request(.postSendCall(phone: phone))
            .map(SendCallModel.self)
            .asObservable()
    }
    
    func postCheckCode(callID: String, pushToken: String) -> Observable<RegisterResponseModel> {
        provider.request(.postCheckCode(callID: callID, pushToken: pushToken))
            .map(RegisterResponseModel.self)
            .asObservable()
    }

    func postCheckSMS(phone: String, code: String, pushToken: String) -> Observable<RegisterResponseModel> {
        provider.request(.postCheckSMS(phone: phone, code: code, pushToken: pushToken))
            .map(RegisterResponseModel.self)
            .asObservable()
    }

    func getSpheres() -> Observable<SphereResponseModel> {
        provider.request(.getSphereList)
            .map(SphereResponseModel.self)
            .asObservable()
    }

    func postRegister(model: RegisterModel) -> Observable<RegisterResponseModel> {
        provider.request(.postRegister(model: model))
            .map(RegisterResponseModel.self)
            .asObservable()
    }
    
//    func postAuth(phone: String, pushToken: String) -> Observable<RegisterResponseModel> {
//        provider.request(.postAuth(phone: phone, pushToken: pushToken))
//            .map(RegisterResponseModel.self)
//            .asObservable()
//    }

    func postRememberPass(phone: String) -> Observable<SuccessModel> {
        provider.request(.postResetPass(phone: phone))
            .map(SuccessModel.self)
            .asObservable()
    }

    func getRecords() -> Observable<RecordsModel> {
        provider.request(.getRecords)
            .map(RecordsModel.self)
            .asObservable()
    }

    func getProfile() -> Observable<ProfileModel> {
        provider.request(.getProfile)
            .map(ProfileModel.self)
            .asObservable()
    }

    func getServices() -> Observable<ServiceModel> {
        provider.request(.getServices)
            .map(ServiceModel.self)
            .asObservable()
    }

    func postService(name: String, price: Int, duration: Int) -> Observable<SuccessModel> {
        provider.request(.postCreateService(name: name, price: price, duration: duration))
            .map(SuccessModel.self)
            .asObservable()
    }

    func postEditService(id: Int, name: String, price: Int, duration: Int) -> Observable<SuccessModel> {
        provider.request(.postEditService(id: id, name: name, price: price, duration: duration))
            .map(SuccessModel.self)
            .asObservable()
    }

    func postDeleteService(id: Int) -> Observable<SuccessModel> {
        provider.request(.postDeleteService(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }

    func getCategories() -> Observable<CategoryModel> {
        provider.request(.getProductCategory)
            .map(CategoryModel.self)
            .asObservable()
    }

    func postCategories(name: String) -> Observable<SuccessModel> {
        provider.request(.postProductCategory(name: name))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getInfoBlockSpecs() -> Observable<SpecsModel> {
        provider.request(.getInfoBlockSpecs)
            .map(SpecsModel.self)
            .asObservable()
    }
    
    func postInfoBlockSpecs(specsId:[Int]) -> Observable<SuccessModel> {
        provider.request(.postInfoBlockSpec(specsId: specsId))
            .map(SuccessModel.self)
            .asObservable()
    }

    func getProducts(id: Int) -> Observable<ProductModel> {
        provider.request(.getProductInCategory(id: id))
            .map(ProductModel.self)
            .asObservable()
    }

    func postProduct(model: ProductCreateModel) -> Observable<SuccessModel> {
        provider.request(.postProduct(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }

    func postDeleteProduct(id: Int) -> Observable<SuccessModel> {
        provider.request(.deleteProduct(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }

    func postEditProduct(model: Product) -> Observable<SuccessModel> {
        provider.request(.editProduct(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }

    func getSpecs(id: String) -> Observable<SpecsModel> {
        provider.request(.getSpecs(id: id))
            .map(SpecsModel.self)
            .asObservable()
    }

    func postEditedModel(model: UserModel) -> Observable<SuccessModel> {
        provider.request(.postEditedUser(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }

    func getClients() -> Observable<ClientModel> {
        provider.request(.getClients)
            .map(ClientModel.self)
            .asObservable()
    }
    
    func getClientDetail(id: Int) -> Observable<ClietDetailModel> {
        provider.request(.getClientDetail(id: id))
            .map(ClietDetailModel.self)
            .asObservable()
    }

    func postCreateClient(model: CreateClientModelV3) -> Observable<SuccessModel> {
        provider.request(.postCreateClient(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }

    func postPhoto(url: URL, compressIndex: Double = 0.5) -> Observable<PhotoModel> {
        provider.request(.postPhoto(url: url, compressIndex: compressIndex))
            .map(PhotoModel.self)
            .asObservable()
    }
    
    func postPhotoData(data: Data) -> Observable<PhotoModel> {
        provider.request(.postPhotoData(data: data))
            .map(PhotoModel.self)
            .asObservable()
    }

    func getSotedProduct() -> Observable<SortedProductModel> {
        provider.request(.getSortedProducts)
            .map(SortedProductModel.self)
            .asObservable()
    }

    func postRecord(model: CreateRecordModelV4) -> Observable<RecordsModelV4Single> {
        provider.request(.postRecord(model: model))
            .map(RecordsModelV4Single.self)
            .asObservable()
    }
    
    func postDeleteClient(_ id: Int) -> Observable<SuccessModel> {
        provider.request(.deleteClient(id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postEditClient(model: Client) -> Observable<SuccessModel> {
        provider.request(.postEditedClient(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postDeleteRecord(_ id: Int) -> Observable<SuccessModel> {
        provider.request(.cancelRecord(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getSuppliers() -> Observable<SupplierModel> {
        provider.request(.getSuppliers)
            .map(SupplierModel.self)
            .asObservable()
    }
    
    func postCreateSupplier(model: CreateSupplierModel) -> Observable<SuccessModel> {
        provider.request(.postCreateSupplier(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postDeleteSupplier(id: Int) -> Observable<SuccessModel> {
        provider.request(.postDeleteSupplier(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postEditSupplier(model: Supplier) -> Observable<SuccessModel> {
        provider.request(.postEditSupplier(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postEditRecord(model: RecordsV4) -> Observable<SuccessModel> {
        provider.request(.postEditedRecord(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postFeedback(name: String, mail: String, message: String) -> Observable<SuccessModel> {
        provider.request(.postFeedback(name: name, mail: mail, message: message))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getAnswers() -> Observable<AnswerQuestModel> {
        provider.request(.getAnswers)
            .map(AnswerQuestModel.self)
            .asObservable()
    }
    
    func getFinance(type: String, date: String) -> Observable<FinanceModel> {
        provider.request(.getFinance(type: type, date: date))
            .map(FinanceModel.self)
            .asObservable()
    }
    
    func postFinance(type: String, name: String, price: Int, comment: String) -> Observable<SuccessModel> {
        provider.request(.postFinance(type: type, name: name, price: price, comment: comment))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getStockProduct() -> Observable<StockProductModel> {
        provider.request(.getStockProduct)
            .map(StockProductModel.self)
            .asObservable()
    }
    
    func postStockProduct(model: StockProductCreateModel) -> Observable<SuccessModel> {
        provider.request(.postStockProduct(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func editStockProduct(model: StockProduct) -> Observable<SuccessModel> {
        provider.request(.editStockProduct(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func deleteStockProduct(id: Int) -> Observable<SuccessModel> {
        provider.request(.deleteStockProduct(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postShedule(model: SheduleModel) -> Observable<SuccessModel> {
        provider.request(.postShedule(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getShadule() -> Observable<SheduleRespModel> {
        provider.request(.getShadule)
            .map(SheduleRespModel.self)
            .asObservable()
    }
    
    func getNotifications() -> Observable<NotificationModel> {
        provider.request(.getNotifications)
            .map(NotificationModel.self)
            .asObservable()
    }
    
    func postAcceptRecord(id: Int) -> Observable<SuccessModel> {
        provider.request(.postAcceptRecord(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
     
    func postCancelRecord(id: Int) -> Observable<SuccessModel> {
        provider.request(.postCancelRecord(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getCalendarTimes() -> Observable<SheduleRespModel> {
        provider.request(.getTimes)
            .map(SheduleRespModel.self)
            .asObservable()
    }
    
    func getNotificationSettings() -> Observable<NotificationSettingsModel> {
        provider.request(.getNotificationSetings)
            .map(NotificationSettingsModel.self)
            .asObservable()
    }
    
    func postNotificationSettings(list: NotificationSettingsPost) -> Observable<SuccessModel> {
        provider.request(.postNotificationSettings(list: list))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postStockArrival(model: StockArrivalModel) -> Observable<SuccessModel> {
        provider.request(.postStockArrival(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postStockConsumption(model: StockConsumptionModel) -> Observable<SuccessModel> {
        provider.request(.postStockConsumption(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getStockOrders() -> Observable<StockOrderModel> {
        provider.request(.getStockOrders)
            .map(StockOrderModel.self)
            .asObservable()
    }
    
    func getDebtors() -> Observable<ClientModel> {
        provider.request(.getDebtors)
            .map(ClientModel.self)
            .asObservable()
    }
    
    func postUpdateDebt(id: Int, sum: Int) -> Observable<SuccessModel> {
        provider.request(.postUpdateDebt(id: id, sum: sum))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func searchRecords(phrase: String) -> Observable<RecordsModel> {
        provider.request(.searchRecords(phrase: phrase))
            .map(RecordsModel.self)
            .asObservable()
    }
    
    func endRecord(id: Int) -> Observable<SuccessModel> {
        provider.request(.postEndRecord(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postReview(text: String, rating: Int) -> Observable<SuccessModel> {
        provider.request(.postReview(text: text, rating: rating))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getSubs() -> Observable<SubscriptionModel> {
        provider.request(.getSubs)
            .map(SubscriptionModel.self)
            .asObservable()
    }
    
    func getSubOrderId(id: Int) -> Observable<GetSubOrderIdModel> {
        provider.request(.getSubOrderId(id: id))
            .map(GetSubOrderIdModel.self)
            .asObservable()
    }
    
    func postSubTrial(id: Int) -> Observable<SuccessModel> {
        provider.request(.postSubTrial(subID: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getMySub() -> Observable<MySubscribtionModel> {
        provider.request(.getMySub)
            .map(MySubscribtionModel.self)
            .asObservable()
    }
    
    func postSub(identifier: Int, key: String) -> Observable<SuccessModel> {
        provider.request(.postSub(identifier: identifier, key: key))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func postRecSub(reciept: String) -> Observable<SuccessModel> {
        provider.request(.postRecSub(reciept: reciept))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func refuseSub() -> Observable<RefuseSubModel> {
        provider.request(.refuseSub)
            .map(RefuseSubModel.self)
            .asObservable()
    }
    
    func deleteAccount() -> Observable<RefuseSubModel> {
        provider.request(.deleteAccount)
            .map(RefuseSubModel.self)
            .asObservable()
    }
    
    func postDeleteCategory(id: Int) -> Observable<SuccessModel> {
        provider.request(.postDeleteCategory(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getReminders() -> Observable<ClientNotifModel> {
        provider.request(.getReminders)
            .map(ClientNotifModel.self)
            .asObservable()
    }
    
    func getReadNotif(id: Int) -> Observable<SuccessModel> {
        provider.request(.getReadNotif(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func deleteIncome(type: String, id: Int) -> Observable<SuccessModel> {
        provider.request(.deleteIncome(type: type, id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func deleteRecord(id: Int) -> Observable<SuccessModel> {
        provider.request(.deleteRecord(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getSliderMain(id: Int) -> Observable<SliderModelSales> {
        provider.request(.getSliderMain(id: id))
            .map(SliderModelSales.self)
            .asObservable()
    }
    
    func getSliderJournal(id: Int) -> Observable<SliderModelLJ> {
        provider.request(.getSliderJournal(id: id))
            .map(SliderModelLJ.self)
            .asObservable()
    }
    
    func getSliderStudy(id: Int) -> Observable<SliderModelStudy> {
        provider.request(.getSliderStudy(id: id))
            .map(SliderModelStudy.self)
            .asObservable()
    }
    
    func getSliderSales(id: Int) -> Observable<SliderModelSales> {
        provider.request(.getSliderSales(id: id))
            .map(SliderModelSales.self)
            .asObservable()
    }
    
    func getLiveJournalList(id: Int, way: String) -> Observable<LiveJournalListModel> {
        provider.request(.getLiveJournalList(id: id, way: way))
            .map(LiveJournalListModel.self)
            .asObservable()
    }
    
    func getLiveJournalItem(id: Int) -> Observable<SliderModelLJ> {
        provider.request(.getLiveJournalItem(id: id))
            .map(SliderModelLJ.self)
            .asObservable()
    }
    
    func getStudyList(id: Int, way: String) -> Observable<SliderModelStudy> {
        provider.request(.getStudyList(id: id, way: way))
            .map(SliderModelStudy.self)
            .asObservable()
    }
                         
    func getStudy(id: Int) -> Observable<SliderModelStudy> {
        provider.request(.getStudy(id: id))
            .map(SliderModelStudy.self)
            .asObservable()
    }
    
    func getMyStudyList() -> Observable<MyStudyModelList> {
        provider.request(.getMyStudyList)
            .map(MyStudyModelList.self)
            .asObservable()
    }
    
    func getDistributors() -> Observable<DistributorsModel> {
        provider.request(.getDistributors)
            .map(DistributorsModel.self)
            .asObservable()
    }
    
    func getAllDistributorsStuff(id: Int) -> Observable<SliderModelStudy> {
        provider.request(.getAllDistributorsStuff(id: id))
            .map(SliderModelStudy.self)
            .asObservable()
    }
    
    func postJoinCourse(model: JoinCourseModel) -> Observable<SuccessModel> {
        provider.request(.postJoinCourse(model: model))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getSalesDistributors() -> Observable<DistributorsModel> {
        provider.request(.getSalesDistributors)
            .map(DistributorsModel.self)
            .asObservable()
    }
    
    func getSale(id: Int) -> Observable<SliderModelSales> {
        provider.request(.getSale(id: id))
            .map(SliderModelSales.self)
            .asObservable()
    }
    
    func getLikeSale(id: Int) -> Observable<SuccessModel> {
        provider.request(.getlikeSale(id: id))
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getFavoriteSales() -> Observable<SliderModelSales> {
        provider.request(.getFavoriteSales)
            .map(SliderModelSales.self)
            .asObservable()
    }
    
    func getSalesCategories() -> Observable<SaleCategoryModel> {
        provider.request(.getSalesCategories)
            .map(SaleCategoryModel.self)
            .asObservable()
    }
    
    func getSalesByCategory(id: Int) -> Observable<SliderModelSales> {
        provider.request(.getSalesByCategory(id: id))
            .map(SliderModelSales.self)
            .asObservable()
    }
    
    func getSalesByDistributors(id: Int) -> Observable<SliderModelSales> {
        provider.request(.getSalesByDistributors(id: id))
            .map(SliderModelSales.self)
            .asObservable()
    }
    
    func checkInternet() -> Observable<SuccessModel> {
        provider.request(.checkInternet)
            .map(SuccessModel.self)
            .asObservable()
    }
    
    func getAppVersion() -> Observable<AppVersionModel> {
        provider.request(.getAppVersion)
            .map(AppVersionModel.self)
            .asObservable()
    }
}
