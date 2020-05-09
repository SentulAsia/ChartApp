//
//  ItemTableViewCell.swift
//  ChartApp
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ItemTableViewCell"

    @IBOutlet weak var contentBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var growthImageView: UIImageView!
    @IBOutlet weak var growthPercentageLabel: UILabel!

    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Shadow

    func setupShadow() {
        contentBackgroundView.layer.cornerRadius = 10
        contentBackgroundView.layer.shadowColor = UIColor.black.cgColor
        contentBackgroundView.layer.shadowOpacity = 0.5
        contentBackgroundView.layer.shadowOffset = CGSize.zero
        contentBackgroundView.layer.shadowRadius = 3
    }
}
