//
//  LiveActivityView.swift
//  F1TrackerApp
//
//  Live race updates view with Dynamic Island simulation
//

import SwiftUI

struct LiveActivityView: View {
    @EnvironmentObject var dataService: DataService
    @State private var timer: Timer?
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Liquid glass background
                LinearGradient(
                    colors: [
                        Color.green.opacity(0.3),
                        Color.black.opacity(0.8),
                        Color.blue.opacity(0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    if dataService.isLoadingLive {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .scaleEffect(1.5)
                    } else if let liveData = dataService.liveRaceData {
                        ScrollView {
                            VStack(spacing: 20) {
                                // Dynamic Island Simulation
                                DynamicIslandSimulation(liveData: liveData)
                                
                                // Live race header
                                VStack(spacing: 12) {
                                    HStack {
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 12, height: 12)
                                            .overlay {
                                                Circle()
                                                    .fill(.red)
                                                    .frame(width: 12, height: 12)
                                                    .opacity(0.5)
                                                    .scaleEffect(1.5)
                                            }
                                        
                                        Text("LIVE")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.red)
                                    }
                                    
                                    Text(liveData.raceName)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    
                                    HStack(spacing: 20) {
                                        VStack {
                                            Text("LAP")
                                                .font(.caption)
                                                .foregroundStyle(.white.opacity(0.7))
                                            Text("\(liveData.currentLap)/\(liveData.totalLaps)")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                        }
                                        
                                        Divider()
                                            .frame(height: 40)
                                        
                                        VStack {
                                            Text("LEADER")
                                                .font(.caption)
                                                .foregroundStyle(.white.opacity(0.7))
                                            Text(liveData.leader)
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.yellow)
                                        }
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
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
                                
                                // Live positions
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Current Positions")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal)
                                    
                                    ForEach(liveData.positions) { position in
                                        LivePositionRow(position: position)
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
                                
                                Button(action: {
                                    stopLiveRace()
                                }) {
                                    Text("Stop Live Updates")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(.red)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                            .padding()
                        }
                    } else {
                        VStack(spacing: 24) {
                            Image(systemName: "bolt.fill")
                                .font(.system(size: 80))
                                .foregroundStyle(.yellow)
                            
                            Text("No Live Race")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                            Text("Start live race updates to see real-time positions and lap information")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                            
                            Button(action: {
                                startLiveRace()
                            }) {
                                Text("Start Live Race")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 32)
                                    .padding(.vertical, 16)
                                    .background(.green)
                                    .clipShape(Capsule())
                            }
                            .padding(.top)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Live Race")
            .navigationBarTitleDisplayMode(.large)
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func startLiveRace() {
        dataService.startLiveRace()
        
        // Simulate lap updates
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            dataService.updateLiveRace()
        }
    }
    
    func stopLiveRace() {
        timer?.invalidate()
        timer = nil
        dataService.stopLiveRace()
    }
}

struct DynamicIslandSimulation: View {
    let liveData: LiveRaceData
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Dynamic Island Preview")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
            
            // Compact view simulation
            HStack {
                Circle()
                    .fill(.red)
                    .frame(width: 8, height: 8)
                
                Text("Lap \(liveData.currentLap)")
                    .font(.caption)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(liveData.leader)
                    .font(.caption)
                    .fontWeight(.medium)
                    .lineLimit(1)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background {
                Capsule()
                    .fill(.black)
            }
            .frame(width: 200)
            
            // Expanded view simulation
            VStack(spacing: 8) {
                HStack {
                    Circle()
                        .fill(.red)
                        .frame(width: 10, height: 10)
                    Text("LIVE")
                        .font(.caption2)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(liveData.raceName)")
                        .font(.caption2)
                        .lineLimit(1)
                }
                .foregroundStyle(.white)
                
                Divider()
                    .background(.white.opacity(0.3))
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("LAP")
                            .font(.caption2)
                            .foregroundStyle(.white.opacity(0.6))
                        Text("\(liveData.currentLap)/\(liveData.totalLaps)")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("LEADER")
                            .font(.caption2)
                            .foregroundStyle(.white.opacity(0.6))
                        Text(liveData.leader)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.yellow)
                            .lineLimit(1)
                    }
                }
                .foregroundStyle(.white)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 32)
                    .fill(.black)
            }
            .frame(width: 280)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [.purple.opacity(0.5), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                }
        }
        .shadow(color: .purple.opacity(0.3), radius: 15, x: 0, y: 5)
    }
}

struct LivePositionRow: View {
    let position: LivePosition
    
    var body: some View {
        HStack(spacing: 12) {
            Text("\(position.position)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 30)
            
            Text(position.driverName)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.white)
            
            Spacer()
            
            Text(position.gap)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(position.position == 1 ? .yellow : .white.opacity(0.7))
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white.opacity(position.position == 1 ? 0.15 : 0.05))
        }
        .padding(.horizontal)
    }
}

#Preview {
    LiveActivityView()
        .environmentObject(DataService())
}
