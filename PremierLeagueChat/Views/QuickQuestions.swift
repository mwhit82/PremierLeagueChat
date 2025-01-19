import SwiftUI

struct QuickQuestions: View {
    let onQuestionSelected: (String) -> Void
    
    private let questions = [
        "How's the recent form?",
        "Goal scoring record?",
        "Clean sheet record?",
        "Head to head history?",
        "Injury news?"
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(questions, id: \.self) { question in
                    Button(action: {
                        onQuestionSelected(question)
                    }) {
                        Text(question)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
