//
//  DataService.swift
//  F1TrackerApp
//
//  Service for managing F1 race data and statistics
//

import Foundation
import Combine

class DataService: ObservableObject {
    @Published var upcomingRaces: [Race] = []
    @Published var pastRaces: [Race] = []
    @Published var driverStandings: [DriverStanding] = []
    @Published var constructorStandings: [ConstructorStanding] = []
    @Published var liveRaceData: LiveRaceData?
    @Published var isLoadingLive = false
    
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        // Upcoming races for 2024 season
        let calendar = Calendar.current
        let now = Date()
        
        upcomingRaces = [
            Race(name: "Monaco Grand Prix", location: "Monte Carlo", country: "Monaco",
                 date: calendar.date(byAdding: .day, value: 15, to: now)!,
                 circuitName: "Circuit de Monaco", isPast: false),
            Race(name: "Canadian Grand Prix", location: "Montreal", country: "Canada",
                 date: calendar.date(byAdding: .day, value: 29, to: now)!,
                 circuitName: "Circuit Gilles Villeneuve", isPast: false),
            Race(name: "Spanish Grand Prix", location: "Barcelona", country: "Spain",
                 date: calendar.date(byAdding: .day, value: 43, to: now)!,
                 circuitName: "Circuit de Barcelona-Catalunya", isPast: false),
            Race(name: "Austrian Grand Prix", location: "Spielberg", country: "Austria",
                 date: calendar.date(byAdding: .day, value: 57, to: now)!,
                 circuitName: "Red Bull Ring", isPast: false),
            Race(name: "British Grand Prix", location: "Silverstone", country: "United Kingdom",
                 date: calendar.date(byAdding: .day, value: 71, to: now)!,
                 circuitName: "Silverstone Circuit", isPast: false)
        ]
        
        // Past races with results
        pastRaces = [
            Race(name: "Bahrain Grand Prix", location: "Sakhir", country: "Bahrain",
                 date: calendar.date(byAdding: .day, value: -60, to: now)!,
                 circuitName: "Bahrain International Circuit", isPast: true,
                 raceResults: [
                    RaceResult(position: 1, driverName: "Max Verstappen", constructorName: "Red Bull Racing", time: "1:32:15.456", points: 25, fastestLap: "1:31.447"),
                    RaceResult(position: 2, driverName: "Sergio Perez", constructorName: "Red Bull Racing", time: "+22.457s", points: 18),
                    RaceResult(position: 3, driverName: "Charles Leclerc", constructorName: "Ferrari", time: "+38.123s", points: 15),
                    RaceResult(position: 4, driverName: "Carlos Sainz", constructorName: "Ferrari", time: "+52.789s", points: 12),
                    RaceResult(position: 5, driverName: "Lewis Hamilton", constructorName: "Mercedes", time: "+1:05.234s", points: 10)
                 ]),
            Race(name: "Saudi Arabian Grand Prix", location: "Jeddah", country: "Saudi Arabia",
                 date: calendar.date(byAdding: .day, value: -46, to: now)!,
                 circuitName: "Jeddah Corniche Circuit", isPast: true,
                 raceResults: [
                    RaceResult(position: 1, driverName: "Sergio Perez", constructorName: "Red Bull Racing", time: "1:21:14.894", points: 26, fastestLap: "1:30.734"),
                    RaceResult(position: 2, driverName: "Max Verstappen", constructorName: "Red Bull Racing", time: "+5.261s", points: 18),
                    RaceResult(position: 3, driverName: "Fernando Alonso", constructorName: "Aston Martin", time: "+20.728s", points: 15),
                    RaceResult(position: 4, driverName: "George Russell", constructorName: "Mercedes", time: "+25.866s", points: 12),
                    RaceResult(position: 5, driverName: "Lewis Hamilton", constructorName: "Mercedes", time: "+35.123s", points: 10)
                 ]),
            Race(name: "Australian Grand Prix", location: "Melbourne", country: "Australia",
                 date: calendar.date(byAdding: .day, value: -32, to: now)!,
                 circuitName: "Albert Park Circuit", isPast: true,
                 raceResults: [
                    RaceResult(position: 1, driverName: "Max Verstappen", constructorName: "Red Bull Racing", time: "1:38:08.619", points: 26, fastestLap: "1:20.235"),
                    RaceResult(position: 2, driverName: "Lewis Hamilton", constructorName: "Mercedes", time: "+6.147s", points: 18),
                    RaceResult(position: 3, driverName: "Fernando Alonso", constructorName: "Aston Martin", time: "+9.556s", points: 15),
                    RaceResult(position: 4, driverName: "Lando Norris", constructorName: "McLaren", time: "+12.345s", points: 12),
                    RaceResult(position: 5, driverName: "Carlos Sainz", constructorName: "Ferrari", time: "+18.901s", points: 10)
                 ])
        ]
        
        // Driver standings
        driverStandings = [
            DriverStanding(position: 1, driverName: "Max Verstappen", constructorName: "Red Bull Racing", points: 195, wins: 7),
            DriverStanding(position: 2, driverName: "Sergio Perez", constructorName: "Red Bull Racing", points: 156, wins: 2),
            DriverStanding(position: 3, driverName: "Fernando Alonso", constructorName: "Aston Martin", points: 139, wins: 0),
            DriverStanding(position: 4, driverName: "Lewis Hamilton", constructorName: "Mercedes", points: 121, wins: 0),
            DriverStanding(position: 5, driverName: "Charles Leclerc", constructorName: "Ferrari", points: 98, wins: 0),
            DriverStanding(position: 6, driverName: "Carlos Sainz", constructorName: "Ferrari", points: 87, wins: 0),
            DriverStanding(position: 7, driverName: "George Russell", constructorName: "Mercedes", points: 72, wins: 0),
            DriverStanding(position: 8, driverName: "Lando Norris", constructorName: "McLaren", points: 58, wins: 0)
        ]
        
        // Constructor standings
        constructorStandings = [
            ConstructorStanding(position: 1, constructorName: "Red Bull Racing", points: 351, wins: 9),
            ConstructorStanding(position: 2, constructorName: "Mercedes", points: 193, wins: 0),
            ConstructorStanding(position: 3, constructorName: "Ferrari", points: 185, wins: 0),
            ConstructorStanding(position: 4, constructorName: "Aston Martin", points: 149, wins: 0),
            ConstructorStanding(position: 5, constructorName: "McLaren", points: 92, wins: 0)
        ]
    }
    
    func startLiveRace() {
        isLoadingLive = true
        
        // Simulate live race data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.liveRaceData = LiveRaceData(
                raceName: "Monaco Grand Prix",
                currentLap: 42,
                totalLaps: 78,
                leader: "Max Verstappen",
                positions: [
                    LivePosition(position: 1, driverName: "Max Verstappen", gap: "Leader"),
                    LivePosition(position: 2, driverName: "Charles Leclerc", gap: "+2.456s"),
                    LivePosition(position: 3, driverName: "Carlos Sainz", gap: "+8.123s"),
                    LivePosition(position: 4, driverName: "Lewis Hamilton", gap: "+15.678s"),
                    LivePosition(position: 5, driverName: "George Russell", gap: "+22.901s"),
                    LivePosition(position: 6, driverName: "Lando Norris", gap: "+35.234s"),
                    LivePosition(position: 7, driverName: "Fernando Alonso", gap: "+42.567s"),
                    LivePosition(position: 8, driverName: "Oscar Piastri", gap: "+48.890s")
                ]
            )
            self?.isLoadingLive = false
        }
    }
    
    func stopLiveRace() {
        liveRaceData = nil
        isLoadingLive = false
    }
    
    func updateLiveRace() {
        guard var currentData = liveRaceData else { return }
        
        // Simulate lap progression
        if currentData.currentLap < currentData.totalLaps {
            liveRaceData = LiveRaceData(
                raceName: currentData.raceName,
                currentLap: currentData.currentLap + 1,
                totalLaps: currentData.totalLaps,
                leader: currentData.leader,
                positions: currentData.positions
            )
        }
    }
}
