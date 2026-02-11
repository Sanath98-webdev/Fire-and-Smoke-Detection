# F1 Tracker App

A modern iOS application for tracking Formula 1 races, statistics, and live race updates with a stunning liquid glass UI design.

## Features

### 🏁 Race Tracking
- **Upcoming Races**: View all scheduled F1 races with dates, locations, and circuit information
- **Past Races**: Browse historical race results with complete standings and winner information
- **Race Details**: Detailed view of each race including full results, driver positions, and timing data

### 📊 Statistics & Standings
- **Driver Standings**: Current championship standings with points, wins, and positions
- **Constructor Standings**: Team rankings with cumulative points and victories
- **Historical Data**: Access to past race results and performance statistics

### ⚡ Live Race Updates
- **Real-time Updates**: Live race information with current lap, positions, and gaps
- **Dynamic Island Integration**: Compact and expanded views showing live race data (iOS 17+)
- **Live Positions**: Real-time driver positions and time gaps during races

### 🎨 iOS 26 Liquid Glass UI
- Modern glassmorphism design with blur effects
- Gradient backgrounds with smooth color transitions
- Ultra-thin material overlays for depth and elegance
- Smooth animations and transitions
- Dark mode optimized interface

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Sanath98-webdev/Fire-and-Smoke-Detection.git
cd Fire-and-Smoke-Detection/F1TrackerApp
```

2. Open the project in Xcode:
```bash
open F1TrackerApp.xcodeproj
```

3. Select your target device or simulator

4. Build and run (⌘R)

## Project Structure

```
F1TrackerApp/
├── F1TrackerApp/
│   ├── F1TrackerAppApp.swift          # Main app entry point
│   ├── ContentView.swift              # Root view with tab navigation
│   ├── Models/
│   │   └── Race.swift                 # Data models for races and statistics
│   ├── Views/
│   │   ├── RaceListView.swift         # List of upcoming and past races
│   │   ├── RaceDetailView.swift       # Detailed race information
│   │   ├── StatsView.swift            # Driver and constructor standings
│   │   └── LiveActivityView.swift     # Live race updates and Dynamic Island
│   ├── Services/
│   │   └── DataService.swift          # Data management and API integration
│   ├── Assets.xcassets/               # App icons and colors
│   └── Info.plist                     # App configuration
└── F1TrackerApp.xcodeproj/            # Xcode project file
```

## Features Breakdown

### Race List View
- Segmented control to switch between upcoming and past races
- Glass-effect cards with race information
- Countdown to upcoming races
- Quick access to race winners for past events

### Race Detail View
- Complete race information including circuit name and location
- Full race results with positions, times, and points
- Fastest lap indicators
- Medal indicators for podium finishes

### Statistics View
- Driver championship standings with team information
- Constructor championship rankings
- Win counts and point totals
- Championship leader badges

### Live Activity View
- Start/stop live race simulation
- Real-time lap counter
- Current race leader display
- Live driver positions with time gaps
- Dynamic Island preview (compact and expanded states)

## Data Management

The app currently uses mock data provided by `DataService`. To integrate with real F1 API:

1. Replace mock data methods in `DataService.swift`
2. Add API networking layer
3. Update models to match API response structure
4. Consider adding Ergast F1 API or OpenF1 API integration

## UI Design

The app features a modern "liquid glass" UI design inspired by iOS 26 concepts:

- **Glassmorphism**: Ultra-thin material effects with blur
- **Gradients**: Smooth color transitions for backgrounds
- **Depth**: Layered UI with subtle shadows
- **Animations**: Smooth transitions and interactions
- **Dark Mode**: Optimized for dark environments

## Dynamic Island Support

The app includes a Dynamic Island simulation showing:
- **Compact View**: Live race indicator with lap number and leader
- **Expanded View**: Detailed race information with current positions

*Note: Real Dynamic Island integration requires Live Activities API and proper entitlements*

## Future Enhancements

- [ ] Real F1 API integration (Ergast or OpenF1)
- [ ] Push notifications for race start times
- [ ] Race calendar integration
- [ ] Driver and team profiles
- [ ] Circuit information and maps
- [ ] Historical season comparisons
- [ ] Weather information
- [ ] Real Live Activities implementation
- [ ] Widget support for home screen

## Technologies Used

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming for data flow
- **Swift**: Primary programming language
- **Live Activities**: Dynamic Island support (simulated)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.

## Acknowledgments

- Formula 1 for the inspiration
- Apple for SwiftUI and iOS frameworks
- Community for F1 data APIs

## Support

For issues, questions, or suggestions, please open an issue on GitHub.

---

Made with ❤️ for Formula 1 fans
