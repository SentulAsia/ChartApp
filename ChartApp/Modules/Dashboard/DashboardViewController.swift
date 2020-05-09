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

    var scope: Models.Scope = .all

    lazy var worker = DashboardWorker()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Use Case

    // MARK: Fetch From Remote Data Store

    func fetchFromRemoteDataStore() {
        let request = FetchDataStoreModels.Request(scope: scope)
        worker.fetchFromRemoteDataStore(with: request) { (viewModel) in
        }
    }

    @IBAction func filterButtonTapped(_ sender: Any) {
        showDashboardFilter()
    }

    func showDashboardFilter() {
        let actionSheet = UIAlertController(title: "Dashboard Filter", message: "Dashboard data will be filtered based on this options:", preferredStyle: .actionSheet)

        for s in Models.Scope.allCases {
            let action = UIAlertAction(title: s.rawValue.prettyPrinted(), style: .default) { [weak self] (action) in
                self?.scope = s
                self?.fetchFromRemoteDataStore()
            }
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true)
    }
}

