//
//  APIManagerStub.swift
//  ChartAppTests
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import XCTest
@testable import ChartApp

class APIManagerStub: APIManager {
    let data: Data
    let result: APIModels.APIResult

    override var worker: APIWorker {
        get {
            APIWorkerStub(data: data, result: result)
        }
        set {
        }
    }

    init(response: [String: Any] = [:], status: Int = 200) {
        let e = NSError(domain: "", code: 0, userInfo: [
        NSLocalizedDescriptionKey: NSLocalizedString("Error", value: Constants.Message.failureDefault, comment: "") ,
        NSLocalizedFailureReasonErrorKey: NSLocalizedString("Error", value: Constants.Message.failureDefault, comment: "")
        ])
        let data = try! JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions(rawValue: 0))
        self.data = data
        self.result = status == 200 || status == 201 ? .success(data) : .failure(e)
    }

    class APIWorkerStub: APIWorker {
        let data: Data
        let result: APIModels.APIResult

        init(data: Data, result: APIModels.APIResult) {
            self.data = data
            self.result = result
        }

        override func request(_ endpoint: String, method: APIWorker.APIMethod, parameters: [String : Any]?, headers: [String : String]? = nil, body: Data? = nil, completion: @escaping (APIWorker.APIResponse) -> Void) {
            let response = APIWorker.APIResponse(request: nil, data: data, response: nil, result: result)
            completion(response)
        }
    }
}
