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

    @IBOutlet weak var allButton: UIBarButtonItem!
    
    typealias Models = DashboardModels
    typealias FetchDataStoreModels = Models.FetchFromRemoteDataStore

    var scope: Models.Scope = .all

    lazy var worker = DashboardWorker()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromRemoteDataStore()
    }

    // MARK: - Buttons

    func setupButtons() {
        allButton.isEnabled = scope != .all
    }

    // MARK: - Use Case

    // MARK: Fetch From Remote Data Store

    func fetchFromRemoteDataStore() {
        let request = FetchDataStoreModels.Request(scope: scope)
        let loadingIndicator = LoadingIndicatorController()
        loadingIndicator.show(on: self)
        worker.fetchFromRemoteDataStore(with: request) { [weak self] (viewModel) in
            loadingIndicator.dismiss()
            self?.setupButtons()
            if viewModel.isSuccessful {

            } else {
                self?.showToast(with: viewModel.message)
            }
        }
    }

    @IBAction func filterButtonTapped(_ sender: Any) {
        showDashboardFilter()
    }

    @IBAction func allButtonTapped(_ sender: Any) {
        scope = .all
        fetchFromRemoteDataStore()
    }
}

// MARK: - Helpers

private extension DashboardViewController {
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

    func showToast(with message: String?) {
        let toast = ToastController(message: message)
        toast.show(on: self)
    }
}
