import Foundation

class StatsRepository {
    static let shared = StatsRepository()
    private let networkService = NetworkService.shared
    private let cache = NSCache<NSString, CacheEntry>()
    
    private init() {}
    
    func getFixtures(for date: Date) async throws -> [Fixture] {
        let dateString = DateFormatter.yyyyMMdd.string(from: date)
        let parameters = ["date": dateString]
        
        return try await networkService.fetch(APIConfig.Endpoints.fixtures, parameters: parameters)
    }
    
    func getTeamStats(teamId: String) async throws -> TeamStats {
        if let cachedStats = getCachedStats(for: teamId) {
            return cachedStats
        }
        
        let stats: TeamStats = try await networkService.fetch(
            APIConfig.Endpoints.teamStats,
            parameters: ["teamId": teamId]
        )
        
        cacheStats(stats, for: teamId)
        return stats
    }
    
    private func getCachedStats(for teamId: String) -> TeamStats? {
        guard let entry = cache.object(forKey: teamId as NSString),
              !entry.isExpired else {
            return nil
        }
        return entry.stats
    }
    
    private func cacheStats(_ stats: TeamStats, for teamId: String) {
        let entry = CacheEntry(stats: stats)
        cache.setObject(entry, forKey: teamId as NSString)
    }
}

private class CacheEntry {
    let stats: TeamStats
    let timestamp: Date
    let expirationInterval: TimeInterval = 300 // 5 minutes
    
    var isExpired: Bool {
        Date().timeIntervalSince(timestamp) > expirationInterval
    }
    
    init(stats: TeamStats) {
        self.stats = stats
        self.timestamp = Date()
    }
}

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
