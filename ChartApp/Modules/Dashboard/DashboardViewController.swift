//
//  DashboardViewController.swift
//  ChartApp
//
//  Created by Zaid Said on 08/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    // MARK: - Properties

    typealias Models = DashboardModels
    typealias FetchDataStoreModels = Models.FetchFromRemoteDataStore

    lazy var worker = DashboardWorker()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Use Case

    // MARK: Fetch From Remote Data Store

    func fetchFromRemoteDataStore() {
        let request = FetchDataStoreModels.Request(scope: .all)
        worker.fetchFromRemoteDataStore(with: request) { (viewModel) in
        }
    }
}

