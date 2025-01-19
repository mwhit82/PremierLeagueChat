import SwiftUI

struct FixturesList: View {
    let fixtures: [Fixture]
    
    var body: some View {
        List(fixtures) { fixture in
            NavigationLink(destination: MatchChatView(fixture: fixture)) {
                FixtureRow(fixture: fixture)
            }
        }
    }
}

struct FixtureRow: View {
    let fixture: Fixture
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(fixture.homeTeam)
                    .font(.headline)
                Text(fixture.awayTeam)
                    .font(.headline)
            }
            Spacer()
            Text(fixture.kickoffTime)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    FixturesList(fixtures: PreviewData.fixtures)
}
