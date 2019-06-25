//
//  Event.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/26/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import Foundation

public struct Event: Codable {
    
    public let eventId: Int
    public let desc: String
    public let title: String
    public let timestamp: String
    public let imageString: String?
    public let phone: String?
    public let scheduledDate: String
    public let loc1: String
    public let loc2: String
    
    func formattedDate() -> String {
        guard let date = DateFormatterHelper.iso8601DateFormatter().date(from: scheduledDate) else { return "" }
        return DateFormatterHelper.happyFormatter().string(from: date)
    }
    
    public enum CodingKeys: String, CodingKey {
        case eventId = "id"
        case desc = "description"
        case title
        case timestamp
        case imageString = "image"
        case phone
        case scheduledDate = "date"
        case loc1 = "locationline1"
        case loc2 = "locationline2"
    }
}
