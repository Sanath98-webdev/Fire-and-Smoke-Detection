//
//  StatsView.swift
//  F1TrackerApp
//
//  View for displaying driver and constructor standings
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var dataService: DataService
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Liquid glass background
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.3),
                        Color.black.opacity(0.8),
                        Color.purple.opacity(0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Segment control
                    Picker("Standing Type", selection: $selectedSegment) {
                        Text("Drivers").tag(0)
                        Text("Constructors").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .background(.ultraThinMaterial)
                    
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            if selectedSegment == 0 {
                                ForEach(dataService.driverStandings) { standing in
                                    DriverStandingCard(standing: standing)
                                }
                            } else {
                                ForEach(dataService.constructorStandings) { standing in
                                    ConstructorStandingCard(standing: standing)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Standings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct DriverStandingCard: View {
    let standing: DriverStanding
    
    var body: some View {
        HStack(spacing: 16) {
            // Position badge
            ZStack {
                if standing.position <= 3 {
                    Circle()
                        .fill(positionColor)
                        .frame(width: 50, height: 50)
                } else {
                    Circle()
                        .stroke(.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 50, height: 50)
                }
                
                Text("\(standing.position)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(standing.driverName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Text(standing.constructorName)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                
                HStack(spacing: 12) {
                    Label("\(standing.wins)", systemImage: "trophy.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    
                    if standing.position == 1 {
                        Text("Championship Leader")
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.green.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(standing.points)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("points")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
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
    
    var positionColor: Color {
        switch standing.position {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .clear
        }
    }
}

struct ConstructorStandingCard: View {
    let standing: ConstructorStanding
    
    var body: some View {
        HStack(spacing: 16) {
            // Position badge
            ZStack {
                if standing.position <= 3 {
                    Circle()
                        .fill(positionColor)
                        .frame(width: 50, height: 50)
                } else {
                    Circle()
                        .stroke(.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 50, height: 50)
                }
                
                Text("\(standing.position)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(standing.constructorName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                HStack(spacing: 12) {
                    Label("\(standing.wins)", systemImage: "trophy.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    
                    if standing.position == 1 {
                        Text("Leading Constructor")
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.green.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(standing.points)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("points")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
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
    
    var positionColor: Color {
        switch standing.position {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .clear
        }
    }
}

#Preview {
    StatsView()
        .environmentObject(DataService())
}
