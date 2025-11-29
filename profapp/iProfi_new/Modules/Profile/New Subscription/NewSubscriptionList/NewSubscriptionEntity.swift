import Foundation

struct PaymentProduct {
    var price: Int
    var name: String
    var id: Int
}

enum PaymentType {
    case applepay
    case card
}

