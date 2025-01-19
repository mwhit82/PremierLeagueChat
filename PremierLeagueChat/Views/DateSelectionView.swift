import SwiftUI

struct DateSelectionView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack(spacing: 16) {
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding()
            .onChange(of: selectedDate) { newDate in
                viewModel.fetchFixtures(for: newDate)
            }
            
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                ContentUnavailableView(
                    "Error",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )
            } else if viewModel.fixtures.isEmpty {
                ContentUnavailableView(
                    "No Fixtures",
                    systemImage: "sportscourt",
                    description: Text("There are no matches scheduled for this date")
                )
            } else {
                FixturesList(fixtures: viewModel.fixtures)
            }
        }
        .onAppear {
            viewModel.fetchFixtures(for: selectedDate)
        }
    }
}
