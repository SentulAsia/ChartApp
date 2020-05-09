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

    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Methods

    func setChart() {
    }
}
