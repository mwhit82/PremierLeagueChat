import Foundation

@MainActor
class MatchChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let repository = StatsRepository.shared
    private let fixture: Fixture
    
    init(fixture: Fixture) {
        self.fixture = fixture
        addWelcomeMessage()
    }
    
    private func addWelcomeMessage() {
        let welcome = Message(
            content: "Welcome! Ask me anything about \(fixture.homeTeam) vs \(fixture.awayTeam)!",
            isUser: false,
            timestamp: Date()
        )
        messages.append(welcome)
    }
    
    func sendMessage(_ content: String) {
        let userMessage = Message(content: content, isUser: true, timestamp: Date())
        messages.append(userMessage)
        
        Task {
            await processMessage(content)
        }
    }
    
    private func processMessage(_ content: String) async {
        isLoading = true
        error = nil
        
        do {
            let homeTeamStats = try await repository.getTeamStats(teamId: "home_team_id") // Replace with actual ID
            let awayTeamStats = try await repository.getTeamStats(teamId: "away_team_id") // Replace with actual ID
            
            let response = generateResponse(
                question: content,
                homeTeamStats: homeTeamStats,
                awayTeamStats: awayTeamStats
            )
            
            let botMessage = Message(content: response, isUser: false, timestamp: Date())
            messages.append(botMessage)
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func generateResponse(
        question: String,
        homeTeamStats: TeamStats,
        awayTeamStats: TeamStats
    ) -> String {
        // Simple response generation
        let lowercaseQuestion = question.lowercased()
        
        if lowercaseQuestion.contains("form") {
            return generateFormResponse(homeTeamStats: homeTeamStats, awayTeamStats: awayTeamStats)
        } else if lowercaseQuestion.contains("goals") {
            return generateGoalsResponse(homeTeamStats: homeTeamStats, awayTeamStats: awayTeamStats)
        }
        
        return "I'm not sure about that. Try asking about team form or goals!"
    }
    
    private func generateFormResponse(homeTeamStats: TeamStats, awayTeamStats: TeamStats) -> String {
        let homeForm = homeTeamStats.form.prefix(5).map { $0.result }.joined(separator: "-")
        let awayForm = awayTeamStats.form.prefix(5).map { $0.result }.joined(separator: "-")
        
        return """
        Last 5 matches:
        \(fixture.homeTeam): \(homeForm)
        \(fixture.awayTeam): \(awayForm)
        """
    }
    
    private func generateGoalsResponse(homeTeamStats: TeamStats, awayTeamStats: TeamStats) -> String {
        return """
        Goals this season:
        \(fixture.homeTeam): \(homeTeamStats.goalsScored) scored, \(homeTeamStats.goalsConceded) conceded
        \(fixture.awayTeam): \(awayTeamStats.goalsScored) scored, \(awayTeamStats.goalsConceded) conceded
        """
    }
}
