//
//  PieChartTableViewCell.swift
//  ChartApp
//
//  Created by Zaid Said on 10/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit

class PieChartTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "PieChartTableViewCell"

    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
