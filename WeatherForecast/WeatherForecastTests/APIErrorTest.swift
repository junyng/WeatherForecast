//
//  Test123.swift
//  WeatherForecastTests
//
//  Created by tskim on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherForecast

class APIErrorTest: XCTestCase {
    func testLocalizedDescription() {
        XCTAssertEqual(APIError.invalidData.errorDescription, "유효하지 않은 데이터입니다.")
    }
}
