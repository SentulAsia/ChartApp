//
//  RatingTableViewCell.swift
//  ChartApp
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit
import Charts

class RatingTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "RatingTableViewCell"

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var totalRatingLabel: UILabel!
    @IBOutlet weak var ratingChartView: BarChartView!

    typealias Models = DashboardModels
    
    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCharts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Charts

    func setupCharts() {
        ratingChartView.noDataText = "No Data"

        ratingChartView.chartDescription?.enabled = false

        ratingChartView.dragEnabled = true
        ratingChartView.setScaleEnabled(true)
        ratingChartView.pinchZoomEnabled = false

        ratingChartView.drawBarShadowEnabled = false
        ratingChartView.drawValueAboveBarEnabled = true

        let xAxis = ratingChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = true

        let leftAxis = ratingChartView.leftAxis
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true

        let rightAxis = ratingChartView.rightAxis
        rightAxis.enabled = true
        rightAxis.drawAxisLineEnabled = true

        let legend = ratingChartView.legend
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.form = .square

        ratingChartView.fitBars = true
    }

    // MARK: - Methods

    func setChart(with data: Models.ChartData?) {
        guard let items = data?.chartItems, items.count > 0 else { return }

        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<items.count {
            let dataEntry = BarChartDataEntry(x: Double(items[i].key), y: items[i].value)
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: data?.chartLabel)
        chartDataSet.colors = [UIColor.gray]

        let chartData = BarChartData(dataSet: chartDataSet)

        ratingChartView.data = chartData
        ratingChartView.animate(yAxisDuration: 2)
    }
}
