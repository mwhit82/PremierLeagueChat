import Foundation

struct TeamStats: Codable {
    let teamId: String
    let matches: Int
    let wins: Int
    let draws: Int
    let losses: Int
    let goalsScored: Int
    let goalsConceded: Int
    let cleanSheets: Int
    let form: [MatchResult]
}

struct MatchResult: Codable {
    let matchId: String
    let result: String
    let score: String
    let opponent: String
    let date: Date
}
