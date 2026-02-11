//
//  RaceListView.swift
//  F1TrackerApp
//
//  View for displaying upcoming and past races with liquid glass UI
//

import SwiftUI

struct RaceListView: View {
    @EnvironmentObject var dataService: DataService
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Liquid glass background
                LinearGradient(
                    colors: [
                        Color.red.opacity(0.3),
                        Color.black.opacity(0.8),
                        Color.red.opacity(0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Segment control with glass effect
                    Picker("Race Type", selection: $selectedSegment) {
                        Text("Upcoming").tag(0)
                        Text("Past").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .background(.ultraThinMaterial)
                    
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            if selectedSegment == 0 {
                                ForEach(dataService.upcomingRaces) { race in
                                    NavigationLink(destination: RaceDetailView(race: race)) {
                                        UpcomingRaceCard(race: race)
                                    }
                                    .buttonStyle(.plain)
                                }
                            } else {
                                ForEach(dataService.pastRaces) { race in
                                    NavigationLink(destination: RaceDetailView(race: race)) {
                                        PastRaceCard(race: race)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("F1 Races")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct UpcomingRaceCard: View {
    let race: Race
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(race.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    HStack {
                        Image(systemName: "location.fill")
                            .font(.caption)
                        Text("\(race.location), \(race.country)")
                            .font(.subheadline)
                    }
                    .foregroundStyle(.white.opacity(0.8))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(race.date, style: .date)
                        .font(.headline)
                    Text(race.date, style: .time)
                        .font(.caption)
                }
                .foregroundStyle(.white)
            }
            
            Text(race.circuitName)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
            
            // Days until race
            if let days = Calendar.current.dateComponents([.day], from: Date(), to: race.date).day {
                HStack {
                    Image(systemName: "calendar")
                    Text("\(days) days until race")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .foregroundStyle(.red)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.red.opacity(0.2))
                .clipShape(Capsule())
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.3), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct PastRaceCard: View {
    let race: Race
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(race.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    HStack {
                        Image(systemName: "location.fill")
                            .font(.caption)
                        Text("\(race.location), \(race.country)")
                            .font(.subheadline)
                    }
                    .foregroundStyle(.white.opacity(0.8))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(race.date, style: .date)
                        .font(.headline)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
                .foregroundStyle(.white)
            }
            
            if let results = race.raceResults, let winner = results.first {
                HStack {
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.yellow)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Winner")
                            .font(.caption2)
                            .foregroundStyle(.white.opacity(0.6))
                        Text(winner.driverName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    Text(winner.constructorName)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.3), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    RaceListView()
        .environmentObject(DataService())
}
