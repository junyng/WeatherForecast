//
//  APIError.swift
//  WeatherForecast
//
//  Created by BLU on 06/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// API 호출 에러 정의
public enum APIError: Error {
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

extension APIError: LocalizedError {
    // Review: Error 를 설명하는것을 선호합니다.
    // LocalizedError 프로토콜을 채택하여 현지화 된 오류 설명을 제공 할 수 있습니다.
    // 중간맛 효과: 개인의 취향 옵션이 포함됩니다.
    var errorDescription: String {
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
