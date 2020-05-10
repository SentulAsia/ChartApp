//
//  LineChartTableViewCell.swift
//  ChartApp
//
//  Created by Zaid Said on 10/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit
import Charts

class LineChartTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "LineChartTableViewCell"

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lineChartView: BarChartView!

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
        lineChartView.chartDescription?.enabled =  false

        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(true)
        lineChartView.pinchZoomEnabled = false
    }

    // MARK: - Methods

    func setChart(with data: [Models.ChartData]) {
        guard data.count > 0 else { return }

        var dataSets: [BarChartDataSet] = []

        var i = 0
        for datum in data {
            var dataEntries: [BarChartDataEntry] = []
            var j = 0
            for value in datum.allValues {
                let dataEntry = BarChartDataEntry(x: datum.chartItems[j].key, y: value)
                dataEntries.append(dataEntry)
                j += 1
            }
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: datum.chartLabel)
            chartDataSet.setColor(Color().allValues[i])
            dataSets.append(chartDataSet)
            i += 1
        }

        let chartData = BarChartData(dataSets: dataSets)

        lineChartView.data = chartData
        lineChartView.animate(yAxisDuration: 2)
    }
}
