import Foundation

enum APIConfig {
    static let baseURL = "https://api.statsperform.com/v1"
    static let apiKey = "YOUR_API_KEY"
    
    enum Endpoints {
        static let fixtures = "/fixtures"
        static let teamStats = "/team-stats"
        static let playerStats = "/player-stats"
    }
}
