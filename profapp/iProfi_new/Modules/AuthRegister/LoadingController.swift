//
//  LoadingControllerController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 29.01.2021.
//

import Moya
import OneSignal
import PhoneNumberKit
import RxSwift
import SVProgressHUD
import UIKit

class LoadingController: UIViewController {
    
    static var isVersionChecked = false
    
    let phoneNumberKit = PhoneNumberKit()
    private let disposeBag = DisposeBag()
    private let service = NetworkingViewModel()
    var fromDeeplink = false
    var type = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getAppVersion() {
            self.checkAuth()
        }
    }

    //MARK: Не используется
    func postAuth() {
        
        var notifications: Bool?
        var reminderClient: Bool?
        
        let setupNotif: ((UIViewController) -> ()) = { viewController in
            let viewController = viewController as? TabBarController
            if notifications ?? false || reminderClient ?? false {
                if let _ = viewController?.tabBar.items?.last {
                    viewController?.addRedDotAtTabBarItemIndex(index: (viewController?.tabBar.items!.count ?? 1) - 1)
                }
            }
        }
        
        var convertedPhone = ""
        if Authorization.phone ?? "" != "" {
            do {
                let phoneNumber = try phoneNumberKit.parse(Authorization.phone ?? "")
                convertedPhone = phoneNumberKit.format(phoneNumber, toType: .e164)
            } catch let error {
                print(error)
                return
            }
        }

        let pushToken = OneSignal.getDeviceState().userId ?? ""
        
        service.postCheckCode(callID: "", pushToken: pushToken).subscribe { response in
            if response.success ?? false {
                if Authorization.isAuthorized {
                    
                    notifications = response.data?.user?.notifications
                    reminderClient = response.data?.user?.reminderClient
                    
                    Authorization.token = response.data?.token
                    Authorization.name = response.data?.user?.name
                    Authorization.midname = response.data?.user?.midname
                    Authorization.lastame = response.data?.user?.lastname
                    Authorization.id = response.data?.user?.id
                    Settings.subType = response.data?.user?.subscription?.type?.key
                    Authorization.useraddress = response.data?.user?.address
                    Authorization.email = response.data?.user?.email
                    if self.fromDeeplink {
                        if self.type == "record" {
                            let vc = self.getControllerAppNavigation(controller: .tabbar)
                            setupNotif(vc)
                            self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                        } else if self.type == "notification" {
                            let vc = self.getControllerAppNavigation(controller: .tabbar) as! TabBarController
                            setupNotif(vc)
                            vc.type = "notification"
                            self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                        } else if self.type == "recordClient" {
                            let vc = self.getControllerAppNavigation(controller: .tabbar) as! TabBarController
                            setupNotif(vc)
                            vc.type = "recordClient"
                            self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                        }
                    } else {
                        if Settings.onboard ?? false {
                            let vc = self.getControllerAppNavigation(controller: .tabbar)
                            setupNotif(vc)
                            self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                        } else {
                            let vc = self.getController(controller: .hellogays)
                            self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                        }
                    }
                } else {
                    if Settings.onboard ?? false {
                        let vc = self.getController(controller: .launch)
                        self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                    } else {
                        let vc = self.getController(controller: .hellogays)
                        self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                    }
                }
            } else {
                if Settings.onboard ?? false {
                    let vc = self.getController(controller: .launch)
                    self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                } else {
                    let vc = self.getController(controller: .hellogays)
                    self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                }
            }
        } onError: { _ in
            let vc = self.getController(controller: .launch)
            self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }

    func checkAuth() {
            
            let failCompletion: ((String?) -> ()) = { errorMessage in
                Authorization.token = nil
                let vc = self.getController(controller: .launch)
                if errorMessage?.count ?? 0 > 0 {
                    SVProgressHUD.showError(withStatus: errorMessage)
                }
                self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
            }
            
            let succesCompletion: ((Bool?) -> ()) = { hasNotif in
                let vc = self.getControllerAppNavigation(controller: .tabbar) as! TabBarController
                
                if hasNotif ?? false {
                    if let profileTab = vc.tabBar.items?.last {
                        vc.addRedDotAtTabBarItemIndex(index: vc.tabBar.items!.count - 1)
                    }
                }
                self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
            }
        
        if Authorization.isAuthorized {
            
            service.getProfile().subscribe { response in
                
                if response.success ?? false {
                    
                    let notification = response.data?.notifications
                    let reminderClient = response.data?.reminderClient
                    
                    Settings.onlinerecord = response.data?.onlineRecord ?? 0
                    Authorization.useraddress = response.data?.address ?? ""
                    Authorization.name = response.data?.name
                    Authorization.midname = response.data?.midname
                    Authorization.lastame = response.data?.lastname
                    Authorization.email = response.data?.email
                    Authorization.useraddress = response.data?.address
                    Authorization.email = response.data?.email
                    Authorization.id = response.data?.id
                    Settings.subType = response.data?.subscription?.type?.key
                    Settings.subId = response.data?.subscription?.type?.id
                    Settings.subTrialExp = response.data?.trialExp?.description
                    
                    if Settings.onboard == false {
                        let vc = self.getController(controller: .hellogays)
                        self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
                    } else if notification ?? false || reminderClient ?? false {
                        succesCompletion(true)
                    } else {
                        succesCompletion(false)
                    }
                } else {
                    failCompletion("Что-то пошло не так")
                }
                
            } onError: { error in
                failCompletion(error.localizedDescription.after(first: ":"))
            }.disposed(by: disposeBag)
            
        } else {
            if Settings.onboard == false {
                let vc = self.getController(controller: .hellogays)
                self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
            } else {
                failCompletion(nil)
            }
        }
    }
    
    func getAppVersion(completion: @escaping () -> ()) {
        if LoadingController.isVersionChecked {
            completion()
        } else {
            service.getAppVersion().subscribe { response in
                if response.success ?? false {
                    LoadingController.isVersionChecked = true
                    if let minVersion = Double(response.data?.ios?.minVersion ?? ""),
                       let latestVersion = Double(response.data?.ios?.currentVersion ?? ""),
                       let currentVersion = Double(Bundle.main.releaseVersionNumber ?? "") {
                        if currentVersion < minVersion {
                            self.openUpdateScreen(state: .forced)
                        } else if (currentVersion >= minVersion) && (currentVersion < latestVersion) {
                            self.openUpdateScreen(state: .common)
                        } else {
                            completion()
                        }
                    } else {
                        completion()
                    }
                } else {
                    completion()
                    debugPrint(response)
                }
            } onError: { error in
                completion()
                debugPrint(error.localizedDescription)
            }.disposed(by: disposeBag)
        }
}
    
    func openUpdateScreen(state: UpdateScreenState) {
        let vc = self.getController(controller: .update) as! UpdateScreenViewController
        vc.updateScreenState = state
        self.present(NavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}
