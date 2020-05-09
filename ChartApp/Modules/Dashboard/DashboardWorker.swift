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
    typealias AnalyticsModels = FetchDataStoreModels.Response.ResponseClass.DataClass.Analytics

    lazy var apiManager = APIManager()

    // MARK: - Methods

    /// Fetch dashboard data from remote data store
    ///
    /// - Parameters:
    ///   - request: request model with scope as parameter
    ///   - completion: completion handler with the view model parsed from back end
    func fetchFromRemoteDataStore(with request: FetchDataStoreModels.Request, completion: @escaping (_ viewModel: FetchDataStoreModels.ViewModel) -> Void) {
        apiManager.getDashboardData(request: request, success: { [weak self] (response) in
            self?.handleFetchFromRemoteDataStore(isSuccessful: true, response: response, completion: completion)
        }) { [weak self] (serverError) in
            self?.handleFetchFromRemoteDataStore(isSuccessful: false, response: nil, completion: completion)
        }
    }

    private func handleFetchFromRemoteDataStore(isSuccessful: Bool, response: FetchDataStoreModels.Response?, completion: @escaping (_ viewModel: FetchDataStoreModels.ViewModel) -> Void) {
        let message = response?.response?.message ?? Constants.Message.failureDefault
        let analytics = response?.response?.data?.analytics
        let header = [analytics?.rating?.title, analytics?.job?.title, analytics?.service?.title, "Line Charts", "Pie Charts"]
        let rating = generateRating(from: analytics?.rating)
        let jobItems = generateItems(from: analytics?.job?.items)
        let serviceItems = generateItems(from: analytics?.service?.items)
        let lineChart = generateLineChart(from: analytics?.lineCharts?.first)
        let pieChart = generatePieChart(from: analytics?.pieCharts)
        let viewModel = FetchDataStoreModels.ViewModel(isSuccessful: isSuccessful, message: message, header: header, rating: rating, jobItems: jobItems, serviceItems: serviceItems, lineChart: lineChart, pieChart: pieChart)
        completion(viewModel)
    }
}

// MARK: - Helpers

private extension DashboardWorker {
    func generateRating(from rating: AnalyticsModels.Rating?) -> Models.Rating {
        let description = rating?.description
        let average = rating?.avg?.description
        let totalItems = "out of " + (rating?.items?.count.description ?? "")
        let totalRating = calculateTotalRating(items: rating?.items).description + " Ratings"
        let rating = Models.Rating(description: description, average: average, totalItems: totalItems, totalRating: totalRating)
        return rating
    }

    func calculateTotalRating(items: [String : Int]?) -> Int {
        guard let i = items else { return 0 }

        var total = 0
        for item in i {
            total += item.value
        }

        return total
    }

    func generateItems(from items: [AnalyticsModels.Items]?) -> [Models.Item] {
        guard let items = items else { return [] }
        var jobItems: [Models.Item] = []
        for item in items {
            let title = item.title
            let description = item.description
            let image = generateItemImage(from: item.growth)
            let percentage = abs(item.growth ?? 0).description + "%"
            let jobItem = Models.Item(title: title, description: description, image: image, percentage: percentage)
            jobItems.append(jobItem)
        }
        return jobItems
    }

    func generateItemImage(from growth: Int?) -> UIImage? {
        guard let growth = growth else { return nil }
        let image = growth < 0 ? #imageLiteral(resourceName: "arrow-down") : #imageLiteral(resourceName: "arrow-up")
        return image
    }

    func generateLineChart(from lineCharts: [AnalyticsModels.LineCharts]?) -> [Models.LineChart] {
        guard let lineCharts = lineCharts else { return [] }
        var lineChartViewModel: [Models.LineChart] = []
        for lineChart in lineCharts {
            let description = lineChart.description
            let lineChartObject = Models.LineChart(description: description)
            lineChartViewModel.append(lineChartObject)
        }
        return lineChartViewModel
    }

    func generatePieChart(from pieCharts: [AnalyticsModels.PieCharts]?) -> [Models.PieChart] {
        guard let pieCharts = pieCharts else { return [] }
        var pieChartViewModel: [Models.PieChart] = []
        for pieChart in pieCharts {
            let description = pieChart.description
            let pieChartObject = Models.PieChart(description: description)
            pieChartViewModel.append(pieChartObject)
        }
        return pieChartViewModel
    }
}
