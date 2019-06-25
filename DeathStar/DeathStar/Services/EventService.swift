//
//  EventService.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/26/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import Foundation

public typealias FetchEventsCompletionBlock = (Bool, [Event]?, APIError?) -> Void

public enum APIError: Error {
    case missingAccessToken
    case invalidURL(String)
    case invalidRequest
    case serverError(String)
    case unauthorized
    case noData
    case parseError
    case genericFailure
    case encodingError
}

public struct APIConstants {
    static let jsonFeedEndpoint = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
}

public class EventService {
    
    public static func fetchEvents(with session: URLSession = URLSession.shared, url: URL?, completion: @escaping FetchEventsCompletionBlock) {
        guard let url = url else { completion(false, nil, nil); return }

        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else { completion(false, nil, .serverError(error?.localizedDescription ?? "server error")); return }
            guard let data = data else { completion(false, nil, .noData); return }
            
            do {
                let decoder = JSONDecoder()
                let events = try decoder.decode([Event].self, from: data)
                completion(true, events, nil)
            }
            catch {
                completion(false, nil, .parseError)
            }
        }
        task.resume()
    }
}
