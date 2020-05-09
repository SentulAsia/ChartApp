//
//  APIModels.swift
//  ChartApp
//
//  Created by Zaid Said on 08/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import Foundation

enum APIModels {

    // MARK: - Types

    enum APIMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
        case delete  = "DELETE"
    }

    enum APIResult {
        case success(Any)
        case failure(Error)

        var isSuccess: Bool {
            switch self {
            case .success:
                return true
            case .failure:
                return false
            }
        }

        var isFailure: Bool {
            return !isSuccess
        }

        var value: Any? {
            switch self {
            case .success(let value):
                return value
            case .failure:
                return nil
            }
        }

        var error: Error? {
            switch self {
            case .success:
                return nil
            case .failure(let error):
                return error
            }
        }
    }

    struct APIResponse {
        let request: URLRequest?
        let data: Data?
        let response: URLResponse?
        let result: APIResult

        var value: Any? { return self.result.value }
        var error: Error? { return self.result.error }

        init(request: URLRequest?, data: Data?, response: URLResponse?, result: APIResult) {
            self.request = request
            self.response = response
            self.data = data
            self.result = result
        }
    }
}
