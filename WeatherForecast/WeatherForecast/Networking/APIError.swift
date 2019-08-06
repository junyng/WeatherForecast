//
//  APIError.swift
//  WeatherForecast
//
//  Created by BLU on 06/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidData
    case requestFailed
    case jsonConversionFailed
    case jsonParsingFailed
    case responseUnsuccessful
    
    var localizedDescription: String {
        switch self {
        case .invalidData:
            return "유효하지 않은 데이터입니다."
        case .requestFailed:
            return "요청이 실패하였습니다."
        case .jsonConversionFailed:
            return "JSON 변환에 실패하였습니다."
        case .jsonParsingFailed:
            return "JSON 파싱에 실패하였습니다.."
        case .responseUnsuccessful:
            return "응답이 요청이 실패하였습니다."
        }
    }
}
