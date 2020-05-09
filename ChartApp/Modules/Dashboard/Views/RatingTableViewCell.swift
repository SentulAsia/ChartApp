//
//  RatingTableViewCell.swift
//  ChartApp
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "RatingTableViewCell"

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var totalRatingLabel: UILabel!
    
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
