//
//  Date+Utils.swift
//  Bankey
//
//  Created by Natália Sapucaia on 22/09/22.
//

import Foundation

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "BR")
        return formatter
    }

    var dayMonthYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "d MMM, yyyy"
        return dateFormatter.string(from: self)
    }
}
