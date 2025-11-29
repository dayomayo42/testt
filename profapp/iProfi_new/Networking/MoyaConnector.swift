//
//  MoyaConnector.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 31.08.2020.
//

import Foundation
import Moya

class Constants: NSObject {
    // previos - "https://profapp.pro/api/v3"
     static let serverUrl = "https://profapp.pro/api/v5"
     static let devUrl = "https://profapp.pro/api/dev"
} 

enum MoyaConnector {
    case postSendCall(phone: String)
    case postCheckCode(callID: String, pushToken: String)
    case postCheckSMS(phone: String, code: String, pushToken: String)
    case getSphereList
    case postRegister(model: RegisterModel)
    case postResetPass(phone: String)
    case postAuth(phone: String, pushToken: String)

    case getRecords
    case getSortedProducts
    case postRecord(model: CreateRecordModelV4)
    case cancelRecord(id: Int)
    case postEditedRecord(model: RecordsV4)
    
    case getProfile
    case getServices
    case getSpecs(id: String)
    case postEditedUser(model: UserModel)
    case postFeedback(name: String, mail: String, message: String)
    case getNotificationSetings
    case postNotificationSettings(list: NotificationSettingsPost)

    case postCreateService(name: String, price: Int, duration: Int)
    case postEditService(id: Int, name: String, price: Int, duration: Int)
    case postDeleteService(id: Int)
    case getAnswers

    case getProductCategory
    case postProductCategory(name: String)
    case getProductInCategory(id: Int)
    case postProduct(model: ProductCreateModel)
    case editProduct(model: Product)
    case deleteProduct(id: Int)
    case getSuppliers
    case postCreateSupplier(model: CreateSupplierModel)
    case postEditSupplier(model: Supplier)
    case postDeleteSupplier(id: Int)
    case postStockArrival(model: StockArrivalModel)
    case postStockConsumption(model: StockConsumptionModel)
    case getStockOrders
    case getDebtors
    case postUpdateDebt(id: Int, sum: Int)
    case postEndRecord(id: Int)
    case postDeleteCategory(id: Int)

    case getClients
    case getClientDetail(id: Int)
    case postCreateClient(model: CreateClientModelV3)
    case postPhoto(url: URL, compressIndex: Double)
    case postPhotoData(data: Data)
    case deleteClient(_ id: Int)
    case postEditedClient(model: Client)
    
    case getFinance(type: String, date: String)
    case postFinance(type: String, name: String, price: Int, comment: String)
    
    case getStockProduct
    case postStockProduct(model: StockProductCreateModel)
    case editStockProduct(model: StockProduct)
    case deleteStockProduct(id: Int)
    
    case postShedule(model: SheduleModel)
    case getShadule
    
    case getNotifications
    case postAcceptRecord(id: Int)
    case postCancelRecord(id: Int)
    
    case getTimes
    
    case searchRecords(phrase: String)
    case postReview(text: String, rating: Int)
    
    case postSubTrial(subID: Int)
    case getSubs
    case getMySub
    case postSub(identifier: Int, key: String)
    case getSubOrderId(id: Int)
    case refuseSub
    
    case postRecSub(reciept: String)
    
    case getReminders
    case getReadNotif(id: Int)
    
    case deleteIncome(type: String, id: Int)
    case deleteRecord(id: Int)
    
    case deleteAccount
    case getInfoBlockSpecs
    case postInfoBlockSpec(specsId: [Int])
    
    case getSliderMain(id: Int)
    case getSliderJournal(id: Int)
    case getSliderSales(id: Int)
    case getSliderStudy(id: Int )
    case getLiveJournalList(id: Int, way: String)
    case getLiveJournalItem(id: Int)
    
    case getStudyList(id: Int, way: String)
    case getStudy(id: Int)
    case getMyStudyList
    case getDistributors
    case getAllDistributorsStuff(id: Int)
    case postJoinCourse(model: JoinCourseModel)
    case getSalesCategories
    case getSalesDistributors
    case getSale(id: Int)
    case getlikeSale(id: Int)
    case getFavoriteSales
    case getSalesByCategory(id: Int)
    case getSalesByDistributors(id: Int)
    
    case checkInternet
    case getAppVersion
}

extension MoyaConnector: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "\(Constants.serverUrl)")!
        }
    }

    var path: String {
        switch self {
        case .postSendCall:
            return "sendCall"
        case .postCheckCode:
            return "checkCode"
        case .postCheckSMS:
            return "checkCode"
        case .getSphereList:
            return "spheres"
        case .postRegister:
            return "register"
        case .postAuth:
            return "login"
        case .postResetPass:
            return "reset"
        case .getRecords:
            return "records"
        case .getProfile:
            return "profile"
        case .getServices:
            return "services"
        case .postCreateService:
            return "create/service"
        case .postEditService:
            return "update/service"
        case .postDeleteService:
            return "delete/service"
        case .getProductCategory:
            return "expandable/categories"
        case .postProductCategory:
            return "expandable/create/category"
        case let .getProductInCategory(id: id):
            return "expandable/by/category/\(id)"
        case .postProduct:
            return "create/expandable"
        case .editProduct:
            return "update/expandable"
        case .deleteProduct:
            return "delete/expandable"
        case let .getSpecs(id: id):
            return "specs\(id)"
        case .postEditedUser:
            return "update/profile"
        case .getClients:
            return "clients"
        case .postCreateClient:
            return "create/client"
        case .postPhoto:
            return "upload"
        case .postPhotoData:
            return "upload"
        case .getSortedProducts:
            return "expandables"
        case .postRecord:
            return "create/record"
        case .deleteClient:
            return "delete/client"
        case .postEditedClient:
            return "update/client"
        case .cancelRecord:
            return "cancel/record"
        case .getSuppliers:
            return "stock/dealers"
        case .postCreateSupplier:
            return "stock/create/dealer"
        case .postEditSupplier:
            return "stock/update/dealer"
        case .postDeleteSupplier:
            return "stock/delete/dealer"
        case .postEditedRecord:
            return "update/record"
        case .postFeedback:
            return "create/feedback"
        case .getAnswers:
            return "questions"
        case let .getFinance(type: type, date: _):
            return "\(type)"
        case let .postFinance(type: type, name: _, price: _, comment: _):
            return "\(type)"
        case .getStockProduct:
            return "stock/products"
        case .postStockProduct:
            return "stock/create/product"
        case .editStockProduct:
            return "stock/update/product"
        case .deleteStockProduct:
            return "stock/delete/product"
        case .postShedule:
            return "settings/datatimes"
        case .getShadule:
            return "settings/datatimes"
        case .getNotifications:
            return "notifications"
        case .postAcceptRecord:
            return "online/confirm"
        case .postCancelRecord:
            return "online/cancel"
        case .getTimes:
            return "online/availables/\(Authorization.id ?? 0)"
        case .getNotificationSetings:
            return "reminders"
        case .postNotificationSettings:
            return "reminders/update"
        case let .getClientDetail(id: id):
            return "client/\(id)"
        case .postStockArrival:
            return "stock/create/arrival"
        case .postStockConsumption:
            return "stock/create/consumption"
        case .getStockOrders:
            return "stock/orders"
        case .getDebtors:
            return "stock/orders/debtors"
        case .postUpdateDebt:
            return "stock/update/consumption"
        case let .searchRecords(phrase: phrase):
            return "search/records/\(phrase)"
        case .postEndRecord:
            return "end/record"
        case .postReview:
            return "rating/create"
        case .postSubTrial:
            return "subscriptions/trial"
        case .getSubs:
            return "subscriptions/all"
        case .getMySub:
            return "subscriptions/existed"
        case .postSub:
            return "subscriptions/create"
        case .postRecSub:
            return "subscriptions/renewable"
        case .refuseSub:
            return "subscriptions/stop"
        case let .getSubOrderId(id: id):
            return "subscriptions/init/\(id)"
        case .postDeleteCategory:
            return "delete/expandable/category"
        case .getReminders:
            return "remiders/profile"
        case let .getReadNotif(id: id):
            return "remiders/profile/\(id)/read"
        case let .deleteIncome(type: type, id: _):
            return "\(type)"
        case .deleteRecord:
            return "delete/record"
        case .deleteAccount:
            return "delete/profile"
        case .getInfoBlockSpecs:
            return "infoblock/user/specs"
        case .postInfoBlockSpec:
            return "infoblock/spec/toggle"
        case let .getSliderMain(id: id):
            return "infoblock/slider/main/\(id)"
        case let .getSliderJournal(id: id):
            return "infoblock/slider/journal/\(id)"
        case let .getSliderSales(id: id):
            return "infoblock/slider/shares/\(id)"
        case let .getSliderStudy(id: id):
            return "infoblock/slider/learning/\(id)"
        case let .getLiveJournalList(id: id, way: way):
            return "infoblock/journals/\(way)/\(id)"
        case let .getLiveJournalItem(id: id):
            return "infoblock/journal/\(id)"
        case let .getStudyList(id: id, way: way):
            return "infoblock/courses/\(way)/\(id)"
        case let .getStudy(id: id):
            return "infoblock/courses/\(id)"
        case .getMyStudyList:
            return "infoblock/my/courses"
        case .getDistributors:
            return "infoblock/courses/distributors"
        case let .getAllDistributorsStuff(id: id):
            return "infoblock/company/courses/\(id)"
        case .postJoinCourse:
            return "join/infoblock/course"
        case .getSalesCategories:
            return "infoblock/shares/categories"
        case .getSalesDistributors:
            return "infoblock/shares/distributors"
        case let .getSale(id: id):
            return "infoblock/shares/\(id)"
        case let .getlikeSale(id: id):
            return "infoblock/like/share/\(id)"
        case .getFavoriteSales:
            return "infoblock/favorites"
        case let .getSalesByCategory(id: id):
            return "infoblock/shares/categories/\(id)"
        case let .getSalesByDistributors(id: id):
            return "infoblock/shares/distributors/\(id)"
        case .checkInternet:
            return "connection"
        case .getAppVersion:
            return "update_app"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postSendCall, .postCheckCode, .postCheckSMS, .postRegister, .postAuth, .postResetPass, .postCreateService, .postEditService, .postDeleteService, .postProductCategory, .postProduct, .editProduct, .deleteProduct, .postEditedUser, .postCreateClient, .postPhoto, .postRecord, .deleteClient, .postEditedClient, .cancelRecord, .postCreateSupplier, .postEditSupplier, .postDeleteSupplier, .postEditedRecord, .postFeedback, .postFinance, .postStockProduct, .editStockProduct, .deleteStockProduct, .postShedule, .postAcceptRecord, .postCancelRecord, .postNotificationSettings, .postStockArrival, .postStockConsumption, .postUpdateDebt, .postEndRecord, .postReview, .postSub, .postRecSub, .postDeleteCategory, .postPhotoData, .deleteRecord, .postInfoBlockSpec, .postJoinCourse, .postSubTrial:
            return .post
        case .deleteIncome, .deleteAccount:
            return .delete
        default:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getSphereList, .getRecords, .getProfile, .getServices, .getProductCategory, .getProductInCategory, .getSpecs, .getClients, .getSortedProducts, .getSuppliers, .getAnswers, .getFinance, .getStockProduct, .getShadule, .getNotifications, .getTimes, .getNotificationSetings, .getClientDetail, .getStockOrders, .getDebtors, .searchRecords, .getSubs, .getMySub, .getSubOrderId, .refuseSub, .getReminders, .getReadNotif, .deleteAccount, .getInfoBlockSpecs, .getSliderMain, .getSliderJournal, .getSliderSales, .getSliderStudy, .getLiveJournalList, .getLiveJournalItem, .getStudy, .getStudyList, .getMyStudyList, .getDistributors, .getAllDistributorsStuff, .getSalesCategories, .getSalesDistributors, .getSale, .getlikeSale, .getFavoriteSales, .getSalesByCategory, .getSalesByDistributors, .checkInternet, .getAppVersion:
            return .requestPlain
        case let .deleteProduct(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .editProduct(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postRegister(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postSendCall(phone: phone):
            return .requestParameters(parameters: ["phone": phone], encoding: JSONEncoding.default)
        case let .postCheckCode(callID: callID, pushToken: pushToken):
            return .requestParameters(parameters: ["call_id": callID, "push_token": pushToken], encoding: JSONEncoding.default)
        case let .postCheckSMS(phone: phone, code: code, pushToken: pushToken):
            return .requestParameters(parameters: ["phone": phone, "password": code, "push_token": pushToken], encoding: JSONEncoding.default)
        case let .postResetPass(phone: phone):
            return .requestParameters(parameters: ["phone": phone], encoding: JSONEncoding.default)
        case let .postAuth(phone: phone, pushToken: pushToken):
            return .requestParameters(parameters: ["phone": phone, "push_token": pushToken], encoding: JSONEncoding.default)
        case let .postCreateService(name: name, price: price, duration: duration):
            return .requestParameters(parameters: ["name": name, "price": price, "duration": duration], encoding: JSONEncoding.default)
        case let .postEditService(id: id, name: name, price: price, duration: duration):
            return .requestParameters(parameters: ["id": id, "name": name, "price": price, "duration": duration], encoding: JSONEncoding.default)
        case let .postDeleteService(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .postProductCategory(name: name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        case let .postProduct(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postEditedUser(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postCreateClient(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postPhoto(url: url, compressIndex: compressIndex):
            var formData = [MultipartFormData]()
            let time = Date().getCurrentGmtDate()
            
            do {
                let data = try Data(contentsOf: url)
                let origImage = UIImage(data: data)
                if let compressedData = origImage?.jpegData(compressionQuality: compressIndex) {
                    let image = MultipartFormData(provider: .data(compressedData), name: "image", fileName: "\(time.timeIntervalSince1970)")
                    formData.append(image)
                }
            } catch {
                let image = MultipartFormData(provider: .file(url), name: "image", fileName: "\(time.timeIntervalSince1970)")
                formData.append(image)
            }
            
            return .uploadMultipart(formData)
        case let .postPhotoData(data: data):
            var formData = [MultipartFormData]()
            let time = Date().getCurrentGmtDate()
            let image = MultipartFormData(provider: .data(data), name: "image", fileName: "\(time.timeIntervalSince1970)")
            formData.append(image)
            return .uploadMultipart(formData)
        case let .postRecord(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .deleteClient(id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .postEditedClient(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .cancelRecord(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .postCreateSupplier(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postDeleteSupplier(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .postEditSupplier(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postEditedRecord(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postFeedback(name: name, mail: mail, message: message):
            return .requestParameters(parameters: ["name": name, "email": mail, "message": message], encoding: JSONEncoding.default)
        case let .postFinance(type: _, name: name, price: price, comment: comment):
            return .requestParameters(parameters: ["name": name, "price": price, "comment": comment], encoding: JSONEncoding.default)
        case let .postStockProduct(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .editStockProduct(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .deleteStockProduct(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .postShedule(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postAcceptRecord(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .postCancelRecord(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .postNotificationSettings(list: list):
            return .requestParameters(parameters: list.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postStockArrival(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postStockConsumption(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postUpdateDebt(id: id, sum: sum):
            return .requestParameters(parameters: ["id": id, "paid" : sum], encoding: JSONEncoding.default)
        case let .postEndRecord(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .postReview(text: text, rating: rating):
            return .requestParameters(parameters: ["text": text, "rating" : rating], encoding: JSONEncoding.default)
        case let .postSub(identifier: identifier, key: key):
            return .requestParameters(parameters: ["identifier": identifier, "key" : key, "provider" : "app_store"], encoding: JSONEncoding.default)
        case let .postRecSub(reciept: reciept):
            return .requestParameters(parameters: ["receiptData": reciept], encoding: JSONEncoding.default)
        case let .postDeleteCategory(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .deleteIncome(type: _, id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .deleteRecord(id: id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case let .postInfoBlockSpec(specsId: specsId):
            return .requestParameters(parameters: ["spec_ids": specsId], encoding: JSONEncoding.default)
        case let .postJoinCourse(model: model):
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: JSONEncoding.default)
        case let .postSubTrial(subID: subID):
            return .requestParameters(parameters: ["sub_list_id": subID], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
       
        
        switch self {
        case .postSendCall, .postCheckSMS:
            return ["accept": "application/json"]
        default:
            if let token = Authorization.token {
                return ["Authorization": "Bearer \(token)", "accept": "application/json"]
            } else {
                return ["accept": "application/json"]
            }
        }
        
    }

    var authorizationType: AuthorizationType? {
        return .basic
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
