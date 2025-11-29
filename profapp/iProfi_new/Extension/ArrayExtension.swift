//
//  ArrayExtension.swift
//  iProfi_new
//
//  Created by violy on 28.02.2023.
//

import Foundation

extension Array {
    mutating func dropWhere(_ isIncluded: (Element) throws -> Bool) -> [Element] {
        do {
            let reverseArray = try filter { try isIncluded($0) }
            self = try filter { try !isIncluded($0) }

            return reverseArray
        } catch {
            return []
        }
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
