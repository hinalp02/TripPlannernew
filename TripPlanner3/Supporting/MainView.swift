

import SwiftUI

struct MainView: View {
    @StateObject var appState = AppState()
    var userUID: String

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            PastTripsView(userUID: userUID)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.pastTrips)
            
            SecondView(userUID: userUID)
                .tabItem {
                    Label("Plan Trip", systemImage: "globe")
                }
                .tag(Tab.planTrip)
            
            SettingsView(userUID: userUID)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
        .environmentObject(appState)
    }
}

#Preview {
    MainView(userUID: "exampleUID")
}
