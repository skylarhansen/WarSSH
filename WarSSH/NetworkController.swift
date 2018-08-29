//
//  NetworkController.swift
//  WarSSH
//
//  Created by Skylar Hansen on 8/24/18.
//  Copyright © 2018 Skylar Hansen. All rights reserved.
//

import Foundation

class NetworkController {

    enum HTTPMethod: String {
        case get = "GET"
    }

    static func performRequest(forURL url: URL, httpMethod: HTTPMethod, completion: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }

        dataTask.resume()
    }
}
