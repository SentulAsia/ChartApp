//
//  DashboardModels.swift
//  ChartApp
//
//  Created by Zaid Said on 08/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit

enum DashboardModels {

    // MARK: - Use Cases

    enum FetchFromRemoteDataStore {
        struct Request: Encodable {
            var scope: Scope

            enum CodingKeys: String, CodingKey {
                case scope
            }

            func toDictionary() -> [String: Any] {
                let keys = CodingKeys.self
                var dictionary = [String: Any]()
                dictionary[keys.scope.rawValue] = scope.rawValue
                return dictionary
            }

            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encodeIfPresent(scope, forKey: .scope)
            }
        }

        struct Response: Decodable {
            var httpStatus: Int?
            var response: ResponseClass?

            enum CodingKeys: String, CodingKey {
                case httpStatus
                case response
            }

            init(from dictionary: [String: Any]) {
                let keys = CodingKeys.self
                httpStatus = dictionary[keys.httpStatus.rawValue] as? Int
                if let responseData = dictionary[keys.response.rawValue] as? [String: Any] {
                    response = ResponseClass(from: responseData)
                } else {
                    response = nil
                }
            }

            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                httpStatus = try values.decodeIfPresent(Int.self, forKey: .httpStatus)
                response = try values.decodeIfPresent(ResponseClass.self, forKey: .response)
            }

            struct ResponseClass: Decodable {
                var data: DataClass?
                var message: String?

                enum CodingKeys: String, CodingKey {
                    case data
                    case message
                }

                init(from dictionary: [String: Any]) {
                    let keys = CodingKeys.self
                    if let dataData = dictionary[keys.data.rawValue] as? [String: Any] {
                        data = DataClass(from: dataData)
                    } else {
                        data = nil
                    }
                    message = dictionary[keys.message.rawValue] as? String
                }

                init(from decoder: Decoder) throws {
                    let values = try decoder.container(keyedBy: CodingKeys.self)
                    data = try values.decodeIfPresent(DataClass.self, forKey: .data)
                    message = try values.decodeIfPresent(String.self, forKey: .message)
                }

                struct DataClass: Decodable {
                    var analytics: Analytics?

                    enum CodingKeys: String, CodingKey {
                        case analytics
                    }

                    init(from dictionary: [String: Any]) {
                        let keys = CodingKeys.self
                        if let analyticsData = dictionary[keys.analytics.rawValue] as? [String: Any] {
                            analytics = Analytics(from: analyticsData)
                        } else {
                            analytics = nil
                        }
                    }

                    init(from decoder: Decoder) throws {
                        let values = try decoder.container(keyedBy: CodingKeys.self)
                        analytics = try values.decodeIfPresent(Analytics.self, forKey: .analytics)
                    }

                    struct Analytics: Decodable {
                        var job: Job?
                        var lineCharts: [[LineCharts]]? // TODO: check with back end why array wrapped twice
                        var pieCharts: [PieCharts]?
                        var rating: Rating?
                        var service: Service?

                        enum CodingKeys: String, CodingKey {
                            case job
                            case lineCharts
                            case pieCharts
                            case rating
                            case service
                        }

                        init(from dictionary: [String: Any]) {
                            let keys = CodingKeys.self
                            if let jobData = dictionary[keys.job.rawValue] as? [String: Any] {
                                job = Job(from: jobData)
                            } else {
                                job = nil
                            }
                            lineCharts = [[LineCharts]]()
                            if let lineChartsArrays = dictionary[keys.lineCharts.rawValue] as? [[[String: Any]]], let lineChartsArray = lineChartsArrays.first {
                                for dic in lineChartsArray {
                                    lineCharts?[0].append(LineCharts(from: dic))
                                }
                            }
                            pieCharts = [PieCharts]()
                            if let pieChartsArray = dictionary[keys.pieCharts.rawValue] as? [[String: Any]] {
                                for dic in pieChartsArray {
                                    pieCharts?.append(PieCharts(from: dic))
                                }
                            }
                            if let ratingData = dictionary[keys.rating.rawValue] as? [String: Any] {
                                rating = Rating(from: ratingData)
                            } else {
                                rating = nil
                            }
                            if let serviceData = dictionary[keys.service.rawValue] as? [String: Any] {
                                service = Service(from: serviceData)
                            } else {
                                service = nil
                            }
                        }

                        init(from decoder: Decoder) throws {
                            let values = try decoder.container(keyedBy: CodingKeys.self)
                            job = try values.decodeIfPresent(Job.self, forKey: .job)
                            lineCharts = try values.decodeIfPresent([[LineCharts]].self, forKey: .lineCharts)
                            pieCharts = try values.decodeIfPresent([PieCharts].self, forKey: .pieCharts)
                            rating = try values.decodeIfPresent(Rating.self, forKey: .rating)
                            service = try values.decodeIfPresent(Service.self, forKey: .service)
                        }

                        struct Items: Decodable {
                            var description: String?
                            var growth: Int?
                            var title: String?
                            var total: Int?

                            enum CodingKeys: String, CodingKey {
                                case description
                                case growth
                                case title
                                case total
                            }

                            init(from dictionary: [String: Any]) {
                                let keys = CodingKeys.self
                                description = dictionary[keys.description.rawValue] as? String
                                growth = dictionary[keys.growth.rawValue] as? Int
                                title = dictionary[keys.title.rawValue] as? String
                                total = dictionary[keys.total.rawValue] as? Int
                            }

                            init(from decoder: Decoder) throws {
                                let values = try decoder.container(keyedBy: CodingKeys.self)
                                description = try values.decodeIfPresent(String.self, forKey: .description)
                                growth = try values.decodeIfPresent(Int.self, forKey: .growth)
                                title = try values.decodeIfPresent(String.self, forKey: .title)
                                total = try values.decodeIfPresent(Int.self, forKey: .total)
                            }
                        }

                        struct Job: Decodable {
                            var description: String?
                            var items: [Items]?
                            var title: String?

                            enum CodingKeys: String, CodingKey {
                                case description
                                case items
                                case title
                            }

                            init(from dictionary: [String: Any]) {
                                let keys = CodingKeys.self
                                description = dictionary[keys.description.rawValue] as? String
                                items = [Items]()
                                if let itemsArray = dictionary[keys.items.rawValue] as? [[String: Any]] {
                                    for dic in itemsArray {
                                        items?.append(Items(from: dic))
                                    }
                                }
                                title = dictionary[keys.title.rawValue] as? String
                            }

                            init(from decoder: Decoder) throws {
                                let values = try decoder.container(keyedBy: CodingKeys.self)
                                description = try values.decodeIfPresent(String.self, forKey: .description)
                                items = try values.decodeIfPresent([Items].self, forKey: .items)
                                title = try values.decodeIfPresent(String.self, forKey: .title)
                            }
                        }

                        struct ChartItems: Decodable {
                            var key: String?
                            var value: Decimal?

                            enum CodingKeys: String, CodingKey {
                                case key
                                case value
                            }

                            init(from dictionary: [String: Any]) {
                                let keys = CodingKeys.self
                                key = dictionary[keys.key.rawValue] as? String
                                value = (dictionary[keys.value.rawValue] as? NSNumber)?.decimalValue
                            }

                            init(from decoder: Decoder) throws {
                                let values = try decoder.container(keyedBy: CodingKeys.self)
                                key = try values.decodeIfPresent(String.self, forKey: .key)
                                value = try values.decodeIfPresent(Decimal.self, forKey: .value)
                            }
                        }

                        struct LineCharts: Decodable {
                            var chartType: String?
                            var description: String?
                            var items: [LineChartItems]?
                            var title: String?

                            enum CodingKeys: String, CodingKey {
                                case chartType
                                case description
                                case items
                                case title
                            }

                            init(from dictionary: [String: Any]) {
                                let keys = CodingKeys.self
                                chartType = dictionary[keys.chartType.rawValue] as? String
                                description = dictionary[keys.description.rawValue] as? String
                                items = [LineChartItems]()
                                if let itemsArray = dictionary[keys.items.rawValue] as? [[String: Any]] {
                                    for dic in itemsArray {
                                        items?.append(LineChartItems(from: dic))
                                    }
                                }
                                title = dictionary[keys.title.rawValue] as? String
                            }

                            init(from decoder: Decoder) throws {
                                let values = try decoder.container(keyedBy: CodingKeys.self)
                                chartType = try values.decodeIfPresent(String.self, forKey: .chartType)
                                description = try values.decodeIfPresent(String.self, forKey: .description)
                                items = try values.decodeIfPresent([LineChartItems].self, forKey: .items)
                                title = try values.decodeIfPresent(String.self, forKey: .title)
                            }

                            struct LineChartItems: Decodable {
                                var key: String?
                                var value: [ChartItems]?

                                enum CodingKeys: String, CodingKey {
                                    case key
                                    case value
                                }

                                init(from dictionary: [String: Any]) {
                                    let keys = CodingKeys.self
                                    key = dictionary[keys.key.rawValue] as? String
                                    value = [ChartItems]()
                                    if let valueArray = dictionary[keys.value.rawValue] as? [[String: Any]] {
                                        for dic in valueArray {
                                            value?.append(ChartItems(from: dic))
                                        }
                                    }
                                }

                                init(from decoder: Decoder) throws {
                                    let values = try decoder.container(keyedBy: CodingKeys.self)
                                    key = try values.decodeIfPresent(String.self, forKey: .key)
                                    value = try values.decodeIfPresent([ChartItems].self, forKey: .value)
                                }
                            }
                        }

                        struct PieCharts: Decodable {
                            var chartType: String?
                            var description: String?
                            var items: [ChartItems]?
                            var title: String?

                            enum CodingKeys: String, CodingKey {
                                case chartType
                                case description
                                case items
                                case title
                            }

                            init(from dictionary: [String: Any]) {
                                let keys = CodingKeys.self
                                chartType = dictionary[keys.chartType.rawValue] as? String
                                description = dictionary[keys.description.rawValue] as? String
                                items = [ChartItems]()
                                if let itemsArray = dictionary[keys.items.rawValue] as? [[String: Any]] {
                                    for dic in itemsArray {
                                        items?.append(ChartItems(from: dic))
                                    }
                                }
                                title = dictionary[keys.title.rawValue] as? String
                            }

                            init(from decoder: Decoder) throws {
                                let values = try decoder.container(keyedBy: CodingKeys.self)
                                chartType = try values.decodeIfPresent(String.self, forKey: .chartType)
                                description = try values.decodeIfPresent(String.self, forKey: .description)
                                items = try values.decodeIfPresent([ChartItems].self, forKey: .items)
                                title = try values.decodeIfPresent(String.self, forKey: .title)
                            }
                        }

                        struct Rating: Decodable {
                            var avg: Int?
                            var description: String?
                            var items: [String: Int]?
                            var title: String?

                            enum CodingKeys: String, CodingKey {
                                case avg
                                case description
                                case items
                                case title
                            }

                            init(from dictionary: [String: Any]) {
                                let keys = CodingKeys.self
                                avg = dictionary[keys.avg.rawValue] as? Int
                                description = dictionary[keys.description.rawValue] as? String
                                if let itemsData = dictionary[keys.items.rawValue] as? [String: Int] {
                                    items = itemsData
                                } else {
                                    items = nil
                                }
                                title = dictionary[keys.title.rawValue] as? String
                            }

                            init(from decoder: Decoder) throws {
                                let values = try decoder.container(keyedBy: CodingKeys.self)
                                avg = try values.decodeIfPresent(Int.self, forKey: .avg)
                                description = try values.decodeIfPresent(String.self, forKey: .description)
                                items = try values.decodeIfPresent([String: Int].self, forKey: .items)
                                title = try values.decodeIfPresent(String.self, forKey: .title)
                            }
                        }

                        struct Service: Decodable {
                            var description: String?
                            var items: [Items]?
                            var title: String?

                            enum CodingKeys: String, CodingKey {
                                case description
                                case items
                                case title
                            }

                            init(from dictionary: [String: Any]) {
                                let keys = CodingKeys.self
                                description = dictionary[keys.description.rawValue] as? String
                                items = [Items]()
                                if let itemsArray = dictionary[keys.items.rawValue] as? [[String: Any]] {
                                    for dic in itemsArray {
                                        items?.append(Items(from: dic))
                                    }
                                }
                                title = dictionary[keys.title.rawValue] as? String
                            }

                            init(from decoder: Decoder) throws {
                                let values = try decoder.container(keyedBy: CodingKeys.self)
                                description = try values.decodeIfPresent(String.self, forKey: .description)
                                items = try values.decodeIfPresent([Items].self, forKey: .items)
                                title = try values.decodeIfPresent(String.self, forKey: .title)
                            }
                        }
                    }
                }
            }
        }

        struct ViewModel {
            var isSuccessful: Bool
            var message: String?
        }
    }

    // MARK: - Types

    enum Scope: String, Encodable, CaseIterable {
        case all = "ALL"
        case today = "TODAY"
        case last7Days = "LAST_7_DAYS"
        case last30Days = "LAST_30_DAYS"
    }
}
