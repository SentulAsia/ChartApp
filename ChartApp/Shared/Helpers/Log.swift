//
//  Log.swift
//  ChartApp
//
//  Created by Zaid Said on 08/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import Foundation

struct Log {
    @discardableResult
    init(_ items: Any...) {
        #if targetEnvironment(simulator)
        for item in items {
            print(item)
        }
        #else
        // TODO: Log to Crashlytics
        #endif
    }
}
