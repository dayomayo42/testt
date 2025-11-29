//
//  NotificationsExtension.swift
//  iProfi_new
//
//  Created by violy on 10.02.2023.
//

import Foundation

extension NSNotification.Name {
    public static var ClientsUpdate: NSNotification.Name = NSNotification.Name("ClientsUpdate")
    public static var ServicesUpdate: NSNotification.Name = NSNotification.Name("ServicesUpdate")
    public static var ProductsUpdate: NSNotification.Name = NSNotification.Name("ProductsUpdate")
    public static var RecordsUpdate: NSNotification.Name = NSNotification.Name("RecordsUpdate")
}
