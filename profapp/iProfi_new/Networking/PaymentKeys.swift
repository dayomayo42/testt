//
//  PaymentKeys.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 04.04.2022.
//

import Foundation

public struct PaymentKeys {
    
    /// Открытый ключ для шифрования карточных данных (номер карты, срок дейсвия и секретный код)
    public static let testPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv5yse9ka3ZQE0feuGtemYv3IqOlLck8zHUM7lTr0za6lXTszRSXfUO7jMb+L5C7e2QNFs+7sIX2OQJ6a+HG8kr+jwJ4tS3cVsWtd9NXpsU40PE4MeNr5RqiNXjcDxA+L4OsEm/BlyFOEOh2epGyYUd5/iO3OiQFRNicomT2saQYAeqIwuELPs1XpLk9HLx5qPbm8fRrQhjeUD5TLO8b+4yCnObe8vy/BMUwBfq+ieWADIjwWCMp2KTpMGLz48qnaD9kdrYJ0iyHqzb2mkDhdIzkim24A3lWoYitJCBrrB2xM05sm9+OdCI1f7nPNJbl5URHobSwR94IRGT7CJcUjvwIDAQAB"   /// Уникальный идентификатор терминала, выдается Продавцу Банком на каждый магазин.
    public static let terminalKey = "1647597222076"//"1647597222076" demo "1647597222076DEMO"
    
    /// Пароль от терминала
    public static let terminalPassword = "933ribahhpoeehrk"//"933ribahhpoeehrk" demo "0efv7lb1y1zq09yc"
    
    /// Идентификатор клиента в системе продавца. Например, для этого идентификатора будут сохраняться список карт.
    public static let customerKey = UserDefaults.standard.string(forKey: "contract")

}
