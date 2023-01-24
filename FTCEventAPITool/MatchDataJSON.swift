//
//  MatchDataJSON.swift
//  FTCEventAPITool
//
//  Created by Isaac Nelson on 1/23/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let matchData = try? JSONDecoder().decode(MatchData.self, from: jsonData)

import Foundation

// MARK: - MatchData
struct MatchData: Decodable {
    let matches: [Match]
}

// MARK: - Match
struct Match: Decodable {
    let actualStartTime, description, tournamentLevel: String
    let series, matchNumber, scoreRedFinal, scoreRedFoul: Int
    let scoreRedAuto, scoreBlueFinal, scoreBlueFoul, scoreBlueAuto: Int
    let postResultTime: String
    let teams: [Team]  // Declared in ScheduleJSON.swift
    let modifiedOn: String
}
