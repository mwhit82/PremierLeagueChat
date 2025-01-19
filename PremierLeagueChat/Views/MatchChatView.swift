import SwiftUI

struct MatchChatView: View {
    let fixture: Fixture
    @StateObject private var viewModel: MatchChatViewModel
    @State private var messageText = ""
    
    init(fixture: Fixture) {
        self.fixture = fixture
        _viewModel = StateObject(wrappedValue: MatchChatViewModel(fixture: fixture))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        MessageBubble(message: message)
                    }
                }
                .padding()
            }
            
            QuickQuestions(onQuestionSelected: { question in
                viewModel.sendMessage(question)
            })
            
            HStack {
                TextField("Ask about the match...", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: {
                    guard !messageText.isEmpty else { return }
                    viewModel.sendMessage(messageText)
                    messageText = ""
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title2)
                }
            }
            .padding()
        }
        .navigationTitle("\(fixture.homeTeam) vs \(fixture.awayTeam)")
    }
}
