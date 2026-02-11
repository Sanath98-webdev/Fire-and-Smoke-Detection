//
//  Race.swift
//  F1TrackerApp
//
//  Data models for F1 races and statistics
//

import Foundation

struct Race: Identifiable, Codable {
    let id: UUID
    let name: String
    let location: String
    let country: String
    let date: Date
    let circuitName: String
    let isPast: Bool
    let raceResults: [RaceResult]?
    
    init(id: UUID = UUID(), name: String, location: String, country: String, date: Date, circuitName: String, isPast: Bool, raceResults: [RaceResult]? = nil) {
        self.id = id
        self.name = name
        self.location = location
        self.country = country
        self.date = date
        self.circuitName = circuitName
        self.isPast = isPast
        self.raceResults = raceResults
    }
}

struct RaceResult: Identifiable, Codable {
    let id: UUID
    let position: Int
    let driverName: String
    let constructorName: String
    let time: String?
    let points: Int
    let fastestLap: String?
    
    init(id: UUID = UUID(), position: Int, driverName: String, constructorName: String, time: String?, points: Int, fastestLap: String? = nil) {
        self.id = id
        self.position = position
        self.driverName = driverName
        self.constructorName = constructorName
        self.time = time
        self.points = points
        self.fastestLap = fastestLap
    }
}

struct DriverStanding: Identifiable, Codable {
    let id: UUID
    let position: Int
    let driverName: String
    let constructorName: String
    let points: Int
    let wins: Int
    
    init(id: UUID = UUID(), position: Int, driverName: String, constructorName: String, points: Int, wins: Int) {
        self.id = id
        self.position = position
        self.driverName = driverName
        self.constructorName = constructorName
        self.points = points
        self.wins = wins
    }
}

struct ConstructorStanding: Identifiable, Codable {
    let id: UUID
    let position: Int
    let constructorName: String
    let points: Int
    let wins: Int
    
    init(id: UUID = UUID(), position: Int, constructorName: String, points: Int, wins: Int) {
        self.id = id
        self.position = position
        self.constructorName = constructorName
        self.points = points
        self.wins = wins
    }
}

struct LiveRaceData: Identifiable {
    let id: UUID
    let raceName: String
    let currentLap: Int
    let totalLaps: Int
    let leader: String
    let positions: [LivePosition]
    
    init(id: UUID = UUID(), raceName: String, currentLap: Int, totalLaps: Int, leader: String, positions: [LivePosition]) {
        self.id = id
        self.raceName = raceName
        self.currentLap = currentLap
        self.totalLaps = totalLaps
        self.leader = leader
        self.positions = positions
    }
}

struct LivePosition: Identifiable {
    let id: UUID
    let position: Int
    let driverName: String
    let gap: String
    
    init(id: UUID = UUID(), position: Int, driverName: String, gap: String) {
        self.id = id
        self.position = position
        self.driverName = driverName
        self.gap = gap
    }
}
