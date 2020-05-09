//
//  APIManager+Dashboard.swift
//  ChartApp
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import Foundation

extension APIManager {

    // MARK: - Methods

    /// Fetch dashboard data from back end
    ///
    /// - Parameters:
    ///   - request: request model that contains scope as parameter
    ///   - success: success completion with response model as parameter
    ///   - failure: failure completion with error string as parameter
    func getDashboardData(request: FetchDashboard.Request,
                                   success: @escaping (_ response: FetchDashboard.Response) -> Void,
                                   failure: @escaping (_ serverError: String) -> Void) {
        worker.request("/v10/analytic/dashboard/operation/mock", method: .get, parameters: request.toDictionary()) { (response) in
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
