//
//  DashboardWorker.swift
//  ChartApp
//
//  Created by Zaid Said on 08/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit

class DashboardWorker {

    // MARK: - Properties

    typealias Models = DashboardModels
    typealias FetchDataStoreModels = Models.FetchFromRemoteDataStore

    lazy var apiManager = APIManager()

    // MARK: - Methods

    /// Fetch dashboard data from remote data store
    ///
    /// - Parameters:
    ///   - request: request model
    ///   - completion: completion handler with the view model
    func fetchFromRemoteDataStore(with request: FetchDataStoreModels.Request, completion: @escaping (_ viewModel: FetchDataStoreModels.ViewModel) -> Void) {
        apiManager.getDashboardData(request: request, success: { [weak self] (response) in
            self?.handleFetchFromRemoteDataStore(isSuccessful: true, completion: completion)
        }) { [weak self] (serverError) in
            self?.handleFetchFromRemoteDataStore(isSuccessful: false, completion: completion)
        }
    }

    private func handleFetchFromRemoteDataStore(isSuccessful: Bool, completion: @escaping (_ viewModel: FetchDataStoreModels.ViewModel) -> Void) {
        let viewModel = FetchDataStoreModels.ViewModel(isSuccessful: isSuccessful)
        completion(viewModel)
    }
}
