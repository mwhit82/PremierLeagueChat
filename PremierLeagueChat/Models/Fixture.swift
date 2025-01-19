import Foundation

struct Fixture: Identifiable, Codable {
    let id: String
    let homeTeam: String
    let awayTeam: String
    let kickoffTime: String
    let date: Date
    let competition: String
    let venue: String
}
