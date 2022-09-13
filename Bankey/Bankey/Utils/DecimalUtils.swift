//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Natália Sapucaia on 17/09/22.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
