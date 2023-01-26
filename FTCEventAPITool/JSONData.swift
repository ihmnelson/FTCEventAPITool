//
//  ScheduleJSON.swift
//  FTCEventAPITool
//
//  Created by Isaac Nelson on 1/23/23.
//  Using app.quicktype.io
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let schedule = try? JSONDecoder().decode(Schedule.self, from: jsonData)

import Foundation

// MARK: - Schedule
class Schedule: Codable, ObservableObject {
    @Published var schedule: [ScheduleElement]

    enum CodingKeys: String, CodingKey {
        case schedule
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        schedule = try container.decode([ScheduleElement].self, forKey: .schedule)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(schedule, forKey: .schedule)
    }
}

// MARK: - ScheduleElement
class ScheduleElement: Codable, Identifiable, ObservableObject {
    var id: Int {matchNumber}
    
    @Published var description: String
    @Published var tournamentLevel: TournamentLevel
    @Published var series: Int
    @Published var matchNumber: Int
    @Published var startTime: String
    @Published var actualStartTime: String
    @Published var postResultTime: String
    @Published var scoreRedFinal: Int
    @Published var scoreRedFoul: Int
    @Published var scoreRedAuto: Int
    @Published var scoreBlueFinal: Int
    @Published var scoreBlueFoul: Int
    @Published var scoreBlueAuto: Int
    @Published var scoreBlueDriveControlled: JSONNull?
    @Published var scoreBlueEndgame: JSONNull?
    @Published var redWins: Bool
    @Published var blueWins: Bool
    @Published var teams: [Team]

    enum CodingKeys: String, CodingKey {
        case description
        case tournamentLevel
        case series
        case matchNumber
        case startTime
        case actualStartTime
        case postResultTime
        case scoreRedFinal
        case scoreRedFoul
        case scoreRedAuto
        case scoreBlueFinal
        case scoreBlueFoul
        case scoreBlueAuto
        case scoreBlueDriveControlled
        case scoreBlueEndgame
        case redWins
        case blueWins
        case teams
    }

    // Added required
    required init(from decoder : Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        description = try container.decode(String.self, forKey: .description)
        tournamentLevel = try container.decode(TournamentLevel.self, forKey: .tournamentLevel)
        series = try container.decode(Int.self, forKey: .series)
        matchNumber = try container.decode(Int.self, forKey: .matchNumber)
        startTime = try container.decode(String.self, forKey: .startTime)
        actualStartTime = try container.decode(String.self, forKey: .actualStartTime)
        postResultTime = try container.decode(String.self, forKey: .postResultTime)
        scoreRedFinal = try container.decode(Int.self, forKey: .scoreRedFinal)
        scoreRedFoul = try container.decode(Int.self, forKey: .scoreRedFoul)
        scoreRedAuto = try container.decode(Int.self, forKey: .scoreRedAuto)
        scoreBlueFinal = try container.decode(Int.self, forKey: .scoreBlueFinal)
        scoreBlueFoul = try container.decode(Int.self, forKey: .scoreBlueFoul)
        scoreBlueAuto = try container.decode(Int.self, forKey: .scoreBlueAuto)
        scoreBlueDriveControlled = try container.decode(JSONNull.self, forKey: .scoreBlueDriveControlled)
        scoreBlueEndgame = try container.decode(JSONNull.self, forKey: .scoreBlueEndgame)
        redWins = try container.decode(Bool.self, forKey: .redWins)
        blueWins = try container.decode(Bool.self, forKey: .blueWins)
        teams = try container.decode([Team].self, forKey: .teams)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(description, forKey: .description)
        try container.encode(tournamentLevel, forKey: .tournamentLevel)
        try container.encode(series, forKey: .series)
        try container.encode(matchNumber, forKey: .matchNumber)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(actualStartTime, forKey: .actualStartTime)
        try container.encode(postResultTime, forKey: .postResultTime)
        try container.encode(scoreRedFinal, forKey: .scoreRedFinal)
        try container.encode(scoreRedFoul, forKey: .scoreRedFoul)
        try container.encode(scoreRedAuto, forKey: .scoreRedAuto)
        try container.encode(scoreBlueFinal, forKey: .scoreBlueFinal)
        try container.encode(scoreBlueFoul, forKey: .scoreBlueFoul)
        try container.encode(scoreBlueAuto, forKey: .scoreBlueAuto)
        try container.encode(scoreBlueDriveControlled, forKey: .scoreBlueDriveControlled)
        try container.encode(scoreBlueEndgame, forKey: .scoreBlueEndgame)
        try container.encode(redWins, forKey: .redWins)
        try container.encode(blueWins, forKey: .blueWins)
        try container.encode(teams, forKey: .teams)
    }
    
}

// MARK: - Team
class Team: Codable, Identifiable {
    var id: Int {teamNumber}
    
    var teamNumber: Int
    var station: Station
    var surrogate: Bool
    var noShow: Bool
    var dq: Bool
    var onField: Bool

    enum CodingKeys: String, CodingKey {
        case teamNumber
        case station
        case surrogate
        case noShow
        case dq
        case onField
    }

    init(teamNumber: Int, station: Station, surrogate: Bool, noShow: Bool, dq: Bool, onField: Bool) {
        self.teamNumber = teamNumber
        self.station = station
        self.surrogate = surrogate
        self.noShow = noShow
        self.dq = dq
        self.onField = onField
    }
}

enum Station: String, Codable {
    case blue1 = "Blue1"
    case blue2 = "Blue2"
    case red1 = "Red1"
    case red2 = "Red2"
}

enum TournamentLevel: String, Codable {
    case qualification = "QUALIFICATION"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let matchData = try? JSONDecoder().decode(MatchData.self, from: jsonData)

// MARK: - MatchData
class MatchData: Codable, ObservableObject {
    var matches: [Match]

    enum CodingKeys: String, CodingKey {
        case matches
    }

    init(matches: [Match]) {
        self.matches = matches
    }
}

// MARK: - Match
class Match: Codable, Identifiable, ObservableObject {
    var id: Int {matchNumber}
    
    var actualStartTime: String
    var description: String
    var tournamentLevel: String
    var series: Int
    var matchNumber: Int
    var scoreRedFinal: Int
    var scoreRedFoul: Int
    var scoreRedAuto: Int
    var scoreBlueFinal: Int
    var scoreBlueFoul: Int
    var scoreBlueAuto: Int
    var postResultTime: String
    var teams: [Team]
    var modifiedOn: String

    enum CodingKeys: String, CodingKey {
        case actualStartTime
        case description
        case tournamentLevel
        case series
        case matchNumber
        case scoreRedFinal
        case scoreRedFoul
        case scoreRedAuto
        case scoreBlueFinal
        case scoreBlueFoul
        case scoreBlueAuto
        case postResultTime
        case teams
        case modifiedOn
    }

    init(actualStartTime: String, description: String, tournamentLevel: String, series: Int, matchNumber: Int, scoreRedFinal: Int, scoreRedFoul: Int, scoreRedAuto: Int, scoreBlueFinal: Int, scoreBlueFoul: Int, scoreBlueAuto: Int, postResultTime: String, teams: [Team], modifiedOn: String) {
        self.actualStartTime = actualStartTime
        self.description = description
        self.tournamentLevel = tournamentLevel
        self.series = series
        self.matchNumber = matchNumber
        self.scoreRedFinal = scoreRedFinal
        self.scoreRedFoul = scoreRedFoul
        self.scoreRedAuto = scoreRedAuto
        self.scoreBlueFinal = scoreBlueFinal
        self.scoreBlueFoul = scoreBlueFoul
        self.scoreBlueAuto = scoreBlueAuto
        self.postResultTime = postResultTime
        self.teams = teams
        self.modifiedOn = modifiedOn
    }
}
