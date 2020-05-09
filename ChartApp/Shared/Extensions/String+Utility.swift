//
//  String+Utility.swift
//  ChartApp
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import Foundation

extension String {

    /// Convert underscored string to presentation string
    func prettyPrinted() -> String {
        let prettyString = self.replacingOccurrences(of: "_", with: " ")
        return prettyString.capitalized
    }
}
