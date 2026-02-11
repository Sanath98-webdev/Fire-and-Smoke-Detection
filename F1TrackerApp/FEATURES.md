# F1 Tracker App - Feature Overview

## App Architecture

```
F1TrackerApp
├── Main Entry Point
│   └── F1TrackerAppApp.swift (App lifecycle, environment setup)
│
├── Root View
│   └── ContentView.swift (TabView with 3 tabs)
│
├── Data Layer
│   ├── Models/
│   │   ├── Race (upcoming & past)
│   │   ├── RaceResult
│   │   ├── DriverStanding
│   │   ├── ConstructorStanding
│   │   ├── LiveRaceData
│   │   └── LivePosition
│   │
│   └── Services/
│       └── DataService (ObservableObject)
│           ├── Mock data generation
│           ├── Live race simulation
│           └── Data updates
│
└── View Layer
    ├── RaceListView
    │   ├── Upcoming races list
    │   └── Past races with results
    │
    ├── RaceDetailView
    │   ├── Race information
    │   └── Complete results table
    │
    ├── StatsView
    │   ├── Driver standings
    │   └── Constructor standings
    │
    └── LiveActivityView
        ├── Live race updates
        ├── Dynamic Island simulation
        └── Real-time positions
```

## Key Features

### 1. Race List (RaceListView)
**Upcoming Races**
- Race name, location, and country
- Circuit name
- Date and time
- Countdown timer (days until race)
- Glass-effect cards with gradients

**Past Races**
- Complete race information
- Winner display with trophy icon
- Race results preview
- Historical data access

### 2. Race Details (RaceDetailView)
- Comprehensive race information
- Full results table with:
  - Position (with podium medals)
  - Driver name
  - Constructor name
  - Race time/gap
  - Points earned
  - Fastest lap indicator
- Beautiful glass-effect cards

### 3. Statistics (StatsView)
**Driver Standings**
- Current championship position
- Driver name and team
- Total points
- Number of wins
- Championship leader badge
- Podium position highlights

**Constructor Standings**
- Team rankings
- Cumulative points
- Team wins
- Leading constructor badge

### 4. Live Race Updates (LiveActivityView)
**Live Race Display**
- LIVE indicator with pulsing animation
- Current lap counter (X/Total)
- Race leader display
- Real-time driver positions
- Time gaps between drivers

**Dynamic Island Simulation**
- Compact view: Lap number + Leader
- Expanded view: Detailed race info
- Simulates iOS 17+ Dynamic Island
- Black capsule design matching system UI

## UI Design System

### iOS 26 Liquid Glass UI
```
Color Scheme:
├── Backgrounds
│   ├── Red/Black gradients (Race List)
│   ├── Blue/Purple gradients (Stats)
│   └── Green/Blue gradients (Live)
│
├── Materials
│   ├── .ultraThinMaterial (primary cards)
│   ├── Gradient overlays
│   └── White strokes with opacity
│
└── Accents
    ├── Red (primary action)
    ├── Yellow (winners, leaders)
    ├── Green (championship leader)
    └── Purple (fastest lap)
```

### Card Design Pattern
All cards feature:
- Rounded corners (20px radius)
- Ultra-thin material background
- Gradient stroke overlay
- Shadow with color tint
- Smooth padding and spacing

### Typography
- Titles: Large, bold, white
- Body: Medium weight, white
- Captions: Small, white with opacity
- Highlights: Accent colors

## Data Models

### Race Model
```swift
Race {
    - id: UUID
    - name: String (e.g., "Monaco Grand Prix")
    - location: String (e.g., "Monte Carlo")
    - country: String (e.g., "Monaco")
    - date: Date
    - circuitName: String
    - isPast: Bool
    - raceResults: [RaceResult]?
}
```

### RaceResult Model
```swift
RaceResult {
    - id: UUID
    - position: Int
    - driverName: String
    - constructorName: String
    - time: String?
    - points: Int
    - fastestLap: String?
}
```

### DriverStanding Model
```swift
DriverStanding {
    - id: UUID
    - position: Int
    - driverName: String
    - constructorName: String
    - points: Int
    - wins: Int
}
```

### LiveRaceData Model
```swift
LiveRaceData {
    - id: UUID
    - raceName: String
    - currentLap: Int
    - totalLaps: Int
    - leader: String
    - positions: [LivePosition]
}
```

## User Interactions

### Navigation
1. Tab-based navigation (3 tabs)
2. List-to-detail navigation for races
3. Segmented controls for filtering
4. Smooth transitions

### Live Race Features
1. Start live race button
2. Auto-updating lap counter (every 3 seconds)
3. Stop live race button
4. Real-time position updates
5. Dynamic Island preview

### Data Updates
- ObservableObject pattern
- @Published properties
- Automatic UI updates
- Combine framework integration

## Mock Data Included

### Upcoming Races (5)
- Monaco Grand Prix
- Canadian Grand Prix
- Spanish Grand Prix
- Austrian Grand Prix
- British Grand Prix

### Past Races (3)
- Bahrain Grand Prix (with results)
- Saudi Arabian Grand Prix (with results)
- Australian Grand Prix (with results)

### Standings
- 8 Driver standings
- 5 Constructor standings

### Live Race Simulation
- Monaco Grand Prix
- 42/78 laps
- 8 driver positions
- Time gaps

## Future API Integration Points

The app is structured to easily integrate with real F1 APIs:

1. **Ergast F1 API**
   - Historical race data
   - Championship standings
   - Race schedules

2. **OpenF1 API**
   - Live timing data
   - Real-time positions
   - Telemetry

3. **Integration Steps**
   - Add URLSession networking
   - Create API client in Services
   - Update DataService methods
   - Add error handling
   - Implement caching

## Performance Considerations

- Lazy loading with LazyVStack
- Efficient list rendering
- Mock data for instant loading
- Observable object for state management
- Minimal view hierarchies

## Accessibility

- Semantic colors
- Clear contrast ratios
- Readable font sizes
- Label support for icons
- VoiceOver compatible

## Testing Recommendations

1. Test on iPhone 14 Pro+ for Dynamic Island
2. Verify on different screen sizes
3. Test dark mode appearance
4. Validate all navigation paths
5. Test live race updates
6. Check SwiftUI previews

---

This documentation provides a complete overview of the F1 Tracker app's architecture, features, and design system.
