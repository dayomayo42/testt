//
//  SVProgressHUD.swift
//  iProfi_new
//
//  Created by violy on 23.08.2022.
//


import Foundation
import SVProgressHUD

extension SVProgressHUD {
    
    public static func showDismissableError(withStatus status: String) {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(hudTapped(_:)), name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
        nc.addObserver(self, selector: #selector(hudDisappeared(_:)), name: NSNotification.Name.SVProgressHUDDidDisappear, object: nil)
        if !status.contains("Failed to map data") {
            SVProgressHUD.showError(withStatus: status)
        }
    }
    
    public static func showDismissableSuccess(withStatus status: String) {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(hudTapped(_:)), name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
        nc.addObserver(self, selector: #selector(hudDisappeared(_:)), name: NSNotification.Name.SVProgressHUDDidDisappear, object: nil)
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    @objc
    private static func hudTapped(_ notification: Foundation.Notification) {
        SVProgressHUD.dismiss()
    }
    
    @objc
    private static func hudDisappeared(_ notification: Foundation.Notification) {
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
        nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDDidDisappear, object: nil)
    }
    
}
