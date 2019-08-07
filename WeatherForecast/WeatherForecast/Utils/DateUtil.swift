//
//  DateUtil.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 날짜 및 시간 편의 유틸
struct DateUtil {
    private static let calendar = Calendar.current
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        return dateFormatter
    }()
    
    /// Date 객체의 현재 시간 문자열 반환
    static func currentTime(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    /// Date 객체를 입력 받아 현재 요일 문자열 반환
    static func weekDay(from date: Date) -> String? {
        let day = calendar.dateComponents([.weekday], from: date).weekday!
        return Weekday(rawValue: day)?.day ?? ""
    }
}

extension DateUtil {
    enum Weekday: Int {
        case sun = 1, mon, tue, wed, thu, fri, sat
        
        var day: String {
            switch self {
            case .sun:
                return "일요일"
            case .mon:
                return "월요일"
            case .tue:
                return "화요일"
            case .wed:
                return "수요일"
            case .thu:
                return "목요일"
            case .fri:
                return "금요일"
            case .sat:
                return "토요일"
            }
        }
    }
}
