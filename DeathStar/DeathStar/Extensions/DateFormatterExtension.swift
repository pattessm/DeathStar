//
//  DateFormatterExtension.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/26/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import Foundation

public class DateFormatterHelper {
    private static let shared = DateFormatterHelper()
    private let dateFormatter = DateFormatter()
    public let isoDateFormatter = ISO8601DateFormatter()
    
    private init() {}
    
    public static func happyFormatter() -> DateFormatter {
        DateFormatterHelper.shared.dateFormatter.timeZone = .current
        DateFormatterHelper.shared.dateFormatter.dateStyle = .medium
        DateFormatterHelper.shared.dateFormatter.timeStyle = .short
        return DateFormatterHelper.shared.dateFormatter
    }
    
    public static func iso8601DateFormatter() -> DateFormatter {
        DateFormatterHelper.shared.dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        DateFormatterHelper.shared.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        DateFormatterHelper.shared.dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return DateFormatterHelper.shared.dateFormatter
    }
}
