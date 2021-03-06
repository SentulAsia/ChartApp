//
//  DashboardViewController+TableView.swift
//  ChartApp
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit

extension DashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        header.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // Rating
            return 1
        } else if section == 1 {
            // Jobs
            return jobItems.count
        } else if section == 2 {
            // Services
            return serviceItems.count
        } else if section == 3 {
            // Line Chart
            return lineChart.count
        } else if section == 4 {
            // Pie Chart
            return pieChart.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Rating
            let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.identifier, for: indexPath) as! RatingTableViewCell
            cell.descriptionLabel.text = rating?.description
            cell.averageLabel.text = rating?.average
            cell.totalItemsLabel.text = rating?.totalItems
            cell.totalRatingLabel.text = rating?.totalRating
            cell.setChart(with: rating?.chartData)
            return cell
        } else if indexPath.section == 1 {
            // Jobs
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
            cell.titleLabel.text = jobItems[indexPath.row].title
            cell.descriptionLabel.text = jobItems[indexPath.row].description
            cell.growthImageView.image = jobItems[indexPath.row].image
            cell.growthPercentageLabel.text = jobItems[indexPath.row].percentage
            return cell
        } else if indexPath.section == 2 {
            // Services
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
            cell.titleLabel.text = serviceItems[indexPath.row].title
            cell.descriptionLabel.text = serviceItems[indexPath.row].description
            cell.growthImageView.image = serviceItems[indexPath.row].image
            cell.growthPercentageLabel.text = serviceItems[indexPath.row].percentage
            return cell
        } else if indexPath.section == 3 {
            // Line Chart
            let cell = tableView.dequeueReusableCell(withIdentifier: LineChartTableViewCell.identifier, for: indexPath) as! LineChartTableViewCell
            cell.descriptionLabel.text = lineChart[indexPath.row].description
            cell.setChart(with: lineChart[indexPath.row].chartData)
            return cell
        } else if indexPath.section == 4 {
            // Pie Chart
            let cell = tableView.dequeueReusableCell(withIdentifier: PieChartTableViewCell.identifier, for: indexPath) as! PieChartTableViewCell
            cell.descriptionLabel.text = pieChart[indexPath.row].description
            cell.setChart(with: pieChart[indexPath.row].chartData)
            return cell
        }

        return UITableViewCell()
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        header[section]
    }
}
