import Foundation

enum PreviewData {
    static let fixtures = [
        Fixture(
            id: "1",
            homeTeam: "Arsenal",
            awayTeam: "Chelsea",
            kickoffTime: "15:00",
            date: Date(),
            competition: "Premier League",
            venue: "Emirates Stadium"
        ),
        Fixture(
            id: "2",
            homeTeam: "Liverpool",
            awayTeam: "Manchester United",
            kickoffTime: "17:30",
            date: Date(),
            competition: "Premier League",
            venue: "Anfield"
        )
    ]
    
    static let messages = [
        Message(content: "How's Arsenal's recent form?", isUser: true, timestamp: Date()),
        Message(content: "Arsenal's last 5 matches:\nW-W-D-W-L\n\nThey've won 3, drawn 1, and lost 1 of their last 5 games.", isUser: false, timestamp: Date()),
        Message(content: "What about their goal scoring record?", isUser: true, timestamp: Date()),
        Message(content: "Arsenal have scored 45 goals in 25 matches this season, averaging 1.8 goals per game.", isUser: false, timestamp: Date())
    ]
}
