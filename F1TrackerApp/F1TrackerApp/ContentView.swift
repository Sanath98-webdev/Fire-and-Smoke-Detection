//
//  ContentView.swift
//  F1TrackerApp
//
//  Main view with iOS 26 liquid glass UI
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataService: DataService
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RaceListView()
                .tabItem {
                    Label("Races", systemImage: "flag.checkered")
                }
                .tag(0)
            
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            LiveActivityView()
                .tabItem {
                    Label("Live", systemImage: "bolt.fill")
                }
                .tag(2)
        }
        .tint(.red)
    }
}

#Preview {
    ContentView()
        .environmentObject(DataService())
}
