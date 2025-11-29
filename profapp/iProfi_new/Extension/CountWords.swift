//
//  CountWords.swift
//  iProfi_new
//
//  Created by violy on 27.02.2023.
//

import Foundation

class CountWords {

    static func word(for count: Int, from: [String]) -> String {
        if from.count == 1 { return from[0] }
        guard from.count == 3 else { return "" }

        var resultString = ""
        let count = count % 100
        if (count >= 11 && count <= 19) {
            resultString = from[2]
        } else {
            let i = count % 10
            switch i {
            case 1:
                resultString = from[0]
            case 2,
                 3,
                 4:
                resultString = from[1]
            default:
                resultString = from[2]
            }

        }
        return resultString
    }
}
