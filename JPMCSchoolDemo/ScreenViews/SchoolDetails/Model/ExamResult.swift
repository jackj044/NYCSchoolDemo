//
//  ExamResult.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import Foundation

typealias ExamResults = [ExamResult]

// MARK: - TestResult
struct ExamResult: Codable {
    let dbn, schoolName, numOfSatTestTakers, satCriticalReadingAvgScore: String?
    let satMathAvgScore, satWritingAvgScore: String?

    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}

extension ExamResult {
    static let sampleData = [
        ExamResult(dbn: "21K728",schoolName:"LIBERATION DIPLOMA PLUS", numOfSatTestTakers: "10", satCriticalReadingAvgScore: "411", satMathAvgScore: "369", satWritingAvgScore: "373"),
        ExamResult(dbn: "08X282",schoolName:"LIBERATION DIPLOMA PLUS", numOfSatTestTakers: "44", satCriticalReadingAvgScore: "407", satMathAvgScore: "386", satWritingAvgScore: "378")
    ]
}

