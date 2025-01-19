import Foundation

@MainActor
class ChatViewModel: ObservableObject {
    @Published var fixtures: [Fixture] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let repository = StatsRepository.shared
    
    func fetchFixtures(for date: Date) {
        isLoading = true
        error = nil
        
        Task {
            do {
                fixtures = try await repository.getFixtures(for: date)
            } catch {
                self.error = error.localizedDescription
            }
            isLoading = false
        }
    }
}
