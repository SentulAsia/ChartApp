//
//  PieChartTableViewCell.swift
//  ChartApp
//
//  Created by Zaid Said on 10/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit
import Charts

class PieChartTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "PieChartTableViewCell"

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!

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
        pieChartView.noDataText = "No Data"

        pieChartView.usePercentValuesEnabled = true
        pieChartView.drawSlicesUnderHoleEnabled = false
        pieChartView.holeRadiusPercent = 0.58
        pieChartView.transparentCircleRadiusPercent = 0.61
        pieChartView.chartDescription?.enabled = false
        pieChartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)

        pieChartView.drawCenterTextEnabled = true

        pieChartView.drawHoleEnabled = true
        pieChartView.rotationAngle = 0
        pieChartView.rotationEnabled = true
        pieChartView.highlightPerTapEnabled = true

        let legend = pieChartView.legend
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = false
        legend.xEntrySpace = 7
        legend.yEntrySpace = 0
        legend.yOffset = 0
    }

    // MARK: - Methods

    func setChart(with data: [Models.ChartData]?) {
    }
}
