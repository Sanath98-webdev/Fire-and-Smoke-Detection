//
//  RaceDetailView.swift
//  F1TrackerApp
//
//  Detailed view for individual races with results
//

import SwiftUI

struct RaceDetailView: View {
    let race: Race
    
    var body: some View {
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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Race header
                    VStack(alignment: .leading, spacing: 12) {
                        Text(race.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        HStack {
                            Image(systemName: "location.fill")
                            Text("\(race.location), \(race.country)")
                        }
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.9))
                        
                        Text(race.circuitName)
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.7))
                        
                        Text(race.date, style: .date)
                            .font(.headline)
                            .foregroundStyle(.red)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
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
                    
                    // Race results (if past race)
                    if race.isPast, let results = race.raceResults {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Race Results")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            ForEach(results) { result in
                                RaceResultRow(result: result)
                            }
                        }
                        .padding(.vertical)
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
                    } else {
                        VStack(spacing: 12) {
                            Image(systemName: "flag.checkered")
                                .font(.system(size: 60))
                                .foregroundStyle(.red)
                            
                            Text("Race Upcoming")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            if let days = Calendar.current.dateComponents([.day], from: Date(), to: race.date).day {
                                Text("\(days) days until race weekend")
                                    .font(.headline)
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .padding(40)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RaceResultRow: View {
    let result: RaceResult
    
    var body: some View {
        HStack(spacing: 16) {
            // Position
            ZStack {
                if result.position <= 3 {
                    Circle()
                        .fill(positionColor)
                        .frame(width: 40, height: 40)
                } else {
                    Circle()
                        .stroke(.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 40, height: 40)
                }
                
                Text("\(result.position)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(result.driverName)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(result.constructorName)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                if let time = result.time {
                    Text(time)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                }
                
                Text("\(result.points) pts")
                    .font(.caption)
                    .foregroundStyle(.red)
                    .fontWeight(.semibold)
            }
            
            if result.fastestLap != nil {
                Image(systemName: "bolt.fill")
                    .foregroundStyle(.purple)
                    .font(.caption)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white.opacity(0.05))
        }
        .padding(.horizontal)
    }
    
    var positionColor: Color {
        switch result.position {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .clear
        }
    }
}

#Preview {
    NavigationStack {
        RaceDetailView(race: Race(
            name: "Monaco Grand Prix",
            location: "Monte Carlo",
            country: "Monaco",
            date: Date(),
            circuitName: "Circuit de Monaco",
            isPast: true,
            raceResults: [
                RaceResult(position: 1, driverName: "Max Verstappen", constructorName: "Red Bull Racing", time: "1:32:15.456", points: 25, fastestLap: "1:31.447"),
                RaceResult(position: 2, driverName: "Charles Leclerc", constructorName: "Ferrari", time: "+5.234s", points: 18),
                RaceResult(position: 3, driverName: "Carlos Sainz", constructorName: "Ferrari", time: "+12.567s", points: 15)
            ]
        ))
    }
}
