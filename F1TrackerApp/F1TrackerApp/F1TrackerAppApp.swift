//
//  F1TrackerAppApp.swift
//  F1TrackerApp
//
//  Formula 1 Race Tracking App
//

import SwiftUI

@main
struct F1TrackerAppApp: App {
    @StateObject private var dataService = DataService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataService)
        }
    }
}
