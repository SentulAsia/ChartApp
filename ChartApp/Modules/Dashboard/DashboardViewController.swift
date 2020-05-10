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

    @IBOutlet weak var chartsTableView: UITableView!
    @IBOutlet weak var allButton: UIBarButtonItem!
    
    typealias Models = DashboardModels
    typealias FetchDataStoreModels = Models.FetchFromRemoteDataStore

    var scope: Models.Scope = .all
    var header: [String?] = []
    var rating: Models.Rating?
    var jobItems: [Models.Item] = []
    var serviceItems: [Models.Item] = []
    var lineChart: [Models.LineChart] = []
    var pieChart: [Models.PieChart] = [] {
        didSet {
            updateUI()
        }
    }

    lazy var worker = DashboardWorker()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromRemoteDataStore()
    }

    // MARK: - Buttons

    func setupTableView() {
        chartsTableView.isHidden = true
        chartsTableView.dataSource = self
        chartsTableView.delegate = self
        chartsTableView.estimatedRowHeight = 250
        chartsTableView.rowHeight = UITableView.automaticDimension
        chartsTableView.register(UINib(nibName: Constants.Xib.Dashboard.rating, bundle: nil), forCellReuseIdentifier: RatingTableViewCell.identifier)
        chartsTableView.register(UINib(nibName: Constants.Xib.Dashboard.item, bundle: nil), forCellReuseIdentifier: ItemTableViewCell.identifier)
        chartsTableView.register(UINib(nibName: Constants.Xib.Dashboard.lineChart, bundle: nil), forCellReuseIdentifier: LineChartTableViewCell.identifier)
        chartsTableView.register(UINib(nibName: Constants.Xib.Dashboard.pieChart, bundle: nil), forCellReuseIdentifier: PieChartTableViewCell.identifier)
    }

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
                self?.header = viewModel.header
                self?.rating = viewModel.rating
                self?.jobItems = viewModel.jobItems
                self?.serviceItems = viewModel.serviceItems
                self?.lineChart = viewModel.lineChart
                self?.pieChart = viewModel.pieChart
            } else {
                self?.showToast(with: viewModel.message)
            }
        }
    }

    // MARK: - Update UI

    func updateUI() {
        chartsTableView.isHidden = jobItems.count == 0 && serviceItems.count == 0 && lineChart.count == 0 && pieChart.count == 0
        chartsTableView.reloadData()
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
