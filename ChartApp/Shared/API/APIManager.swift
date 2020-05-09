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
}
