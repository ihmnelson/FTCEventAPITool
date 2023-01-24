//
//  ScheduleJSON.swift
//  FTCEventAPITool
//
//  Created by Isaac Nelson on 1/23/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let schedule = try? JSONDecoder().decode(Schedule.self, from: jsonData)

import Foundation

// MARK: - Schedule
struct Schedule: Decodable {
    let schedule: [ScheduleElement]
}

// MARK: - ScheduleElement
struct ScheduleElement: Decodable {
    let description: String
    let tournamentLevel: TournamentLevel
    let series, matchNumber: Int
    let startTime, actualStartTime, postResultTime: String?
    let scoreRedFinal, scoreRedFoul, scoreRedAuto, scoreBlueFinal: Int?
    let scoreBlueFoul, scoreBlueAuto: Int?
    let scoreBlueDriveControlled, scoreBlueEndgame: Int?
    let redWINS, blueWINS: Bool?
    let teams: [Team]
}

// MARK: - Team
struct Team: Decodable {
    let teamNumber: Int
    let station: Station
    let surrogate, noShow, dq, onField: Bool?
}

enum Station: String, Decodable {
    case blue1
    case blue2
    case red1
    case red2
}

enum TournamentLevel: String, Decodable {
    case qualification, playoff
}
