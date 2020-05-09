//
//  APIManager.swift
//  ChartApp
//
//  Created by Zaid Said on 08/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import Foundation

class APIManager {

    // MARK: - Properties

    typealias Models = APIModels
    typealias APIMethod = Models.APIMethod
    typealias APIResult = Models.APIResult
    typealias APIResponse = Models.APIResponse
    typealias FetchDashboard = DashboardModels.FetchFromRemoteDataStore

    lazy var worker = APIWorker()

    // MARK: - Methods

    func getDashboardData(request: FetchDashboard.Request,
                                   success: @escaping (_ response: FetchDashboard.Response) -> Void,
                                   failure: @escaping (_ serverError: String) -> Void) {
        worker.request("v10/analytic/dashboard/operation/mock", method: .get, parameters: request.toDictionary()) { (response) in
            let defaultError = response.result.error?.localizedDescription ?? Constants.Message.failureDefault
            guard response.result.isSuccess else {
                failure(defaultError)
                return
            }

            let decoder = JSONDecoder()
            guard let rawData = response.data, let decodedData = try? decoder.decode(FetchDashboard.Response.self, from: rawData) else {
                failure(defaultError)
                return
            }
            success(decodedData)
            return
        }
    }
}
