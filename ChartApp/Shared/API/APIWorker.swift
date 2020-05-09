//
//  APIWorker.swift
//  ChartApp
//
//  Created by Zaid Said on 08/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import Foundation

class APIWorker {

    // MARK: - Properties

    typealias Models = APIModels
    typealias APIMethod = Models.APIMethod
    typealias APIResult = Models.APIResult
    typealias APIResponse = Models.APIResponse

    // MARK: - Methods

    /// Perform API Request to server
    /// 
    /// - Parameters:
    ///   - endpoint: The API endpoint
    ///   - method: The http method of the request
    ///   - parameters: The parameters passed for the request, pass nil if none
    ///   - headers: Optional header to be added to the request
    ///   - body: Optional request body, parameters will be ignored if body is passed
    ///   - completion: Handler when request have been completed with response as the parameter
    func request(_ endpoint: String,
                 method: APIMethod,
                 parameters: [String: Any]?,
                 headers: [String: String]? = nil,
                 body: Data? = nil,
                 completion: @escaping (_ response: APIResponse) -> Void) {
        guard let url = generateURL(from: endpoint, method: method, parameters: parameters) else {
            let e = NSError(domain: "", code: 0, userInfo: [
                NSLocalizedDescriptionKey: NSLocalizedString("Error", value: Constants.Message.failureDefault, comment: "") ,
                NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", value: Constants.Message.failureDefault, comment: "")
                ])
            Log("----------------------------")
            Log("Unable to generate URL from endpoint")
            Log("----------------------------")
            let result = APIResult.failure(e)
            let r = APIResponse(request: nil, data: nil, response: nil, result: result)
            completion(r)
            return
        }
        var request = URLRequest(url: url)
        if let h = headers {
            for header in h {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        request.httpMethod = method.rawValue

        if let p = parameters, method != .get {
            do {
                if let data = try JSONSerialization.data(withJSONObject: p, options: JSONSerialization.WritingOptions(rawValue: 0)) as Data? {
                    request.httpBody = data
                }
            } catch {
                Log("----------------------------")
                Log("API url: ", url.description)
                Log("params: ", parameters ?? "")
                Log("\(url.description) Failed")
                Log("response: nil")
                Log("----------------------------")
                let result = APIResult.failure(error)
                let r = APIResponse(request: request, data: nil, response: nil, result: result)
                completion(r)
                return
            }
        } else if let data = body {
            request.httpBody = data
        }

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 12.0
        sessionConfig.timeoutIntervalForResource = 60.0
        let sessionManager = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        let dataTask = sessionManager.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let e = error {
                Log("----------------------------")
                Log("API url:", url.description)
                Log("params:", parameters ?? "")
                Log("\(url.description) Failed")
                Log("----------------------------")
                let result = APIResult.failure(e)
                let r = APIResponse(request: request, data: data, response: response, result: result)
                DispatchQueue.main.async {
                    completion(r)
                    return
                }
            } else {
                if let d = data {
                    Log("----------------------------")
                    Log("API url:", url.description)
                    Log("params:", parameters ?? "")
                    Log("\(url.description) Success")
                    if let httpResponse = response as? HTTPURLResponse {
                        Log("Result:", httpResponse.allHeaderFields as? [String: Any] ?? httpResponse)
                        Log("Status Code:", httpResponse.statusCode)
                    }
                    Log("----------------------------")
                    let result = APIResult.success(d)
                    let r = APIResponse(request: request, data: data, response: response, result: result)
                    DispatchQueue.main.async {
                        completion(r)
                        return
                    }
                } else {
                    let e = NSError(domain: "", code: 0, userInfo: [
                        NSLocalizedDescriptionKey: NSLocalizedString("Error", value: Constants.Message.failureDefault, comment: "") ,
                        NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", value: Constants.Message.failureDefault, comment: "")
                        ])
                    Log("----------------------------")
                    Log("API url:", url.description)
                    Log("params:", parameters ?? "")
                    Log("\(url.description) Failed")
                    Log("----------------------------")
                    let result = APIResult.failure(e)
                    let r = APIResponse(request: request, data: data, response: response, result: result)
                    DispatchQueue.main.async {
                        completion(r)
                        return
                    }
                }
            }
        }
        dataTask.resume()
    }
}

// MARK: - Helpers

extension APIWorker {
    func generateURL(from endpoint: String, method: APIMethod, parameters: [String: Any]?) -> URL? {
        var stringURL = Constants.URL.server + endpoint
        if method == .get, let p = parameters as? [String: String] {
            var getParameter = ""
            var isFirst = true
            for parameter in p {
                getParameter += isFirst ? "?" : "&"
                getParameter += "\(parameter.key)=\(parameter.value)"
                isFirst = false
            }
            stringURL += getParameter
        }
        return URL(string: stringURL)
    }
}
