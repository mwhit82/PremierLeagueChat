import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationStack {
            DateSelectionView()
                .navigationTitle("Premier League Chat")
        }
    }
}

#Preview {
    ContentView()
}
