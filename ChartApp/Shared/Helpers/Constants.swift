//
//  Constants.swift
//  ChartApp
//
//  Created by Zaid Said on 08/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import Foundation

enum Constants {
    enum Storyboard {
        static let main = "Main"
    }

    enum Xib {
        enum Dashboard {
            static let rating = "RatingTableViewCell"
            static let item = "ItemTableViewCell"
            static let lineChart = "LineChartTableViewCell"
            static let pieChart = "PieChartTableViewCell"
        }
    }

    enum URL {
        static let server = "https://skyrim.whipmobility.io"
    }

    enum Message {
        static let failureDefault = "We're sorry, but something went wrong."
    }
}
