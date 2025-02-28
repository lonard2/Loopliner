//
//  MapView.swift
//  Loopliner
//
//  Created by Lonard Steven on 22/01/25.
//

import SwiftUI
import SwiftData
import UIKit

struct MapView: View {
    // SwiftData
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    
    @EnvironmentObject private var dataManager: SwiftDataManager
    
    @StateObject private var audioManager = AudioManager.helper
    @StateObject private var timeHelper = TimeHelper.shared
    
    @EnvironmentObject var advViewModel: ADVStoryViewModel
    @EnvironmentObject var trainViewModel: TrainViewModel
    @EnvironmentObject var messageViewModel: MessageViewModel
    
    @State private var selectedStationId: Int?
    @State private var selectedLine: TrainLine?
    
    @State private var goToInteractive: Bool = false
    @State private var goToADV: Bool = false
    @State private var interactiveMode: InteractiveViewMode = .unknown
    @State private var journeyStationIds: [String] = []
    
    @State private var backgroundColor: Color = Color("EarlyPlayColor")
    
    @Binding var showJourneySheet: Bool
    
    @AppStorage("colorblindModeEnabled") private var isColorblindModeEnabled = false
    
    var lapsedStations: [String]? // use stationID to highlight lapsed stations for the post-ADV
    var mapViewMode: MapViewMode = .interactive
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                switch mapViewMode {
                case .interactive:
                    InteractiveMapView(geo: geo, mapView: self, selectedStationId: $selectedStationId, trainViewModel: trainViewModel)
                            
                case .journey:
                    JourneyMapView(geo: geo, mapView: self, goToInteractive: $goToInteractive, goToADV: $goToADV, interactiveMode: $interactiveMode, showJourneySheet: $showJourneySheet, selectedLine: $selectedLine, timeHelper: timeHelper)
                    
                case .unknown:
                    VStack {
                        Text("MapView Mode: unknown")
                    }
                }
            }
        }
        .onChange(of: selectedStationId) {
            if mapViewMode == .interactive {
                DispatchQueue.main.async {
                    if !isColorblindModeEnabled {
                        if let selectedColor = selectedLine?.color {
                            backgroundColor = selectedColor
                        }
                    } else {
                        if let selectedColor = selectedLine?.colorAccessible {
                            backgroundColor = selectedColor
                        }
                    }
                }
            }
        }
        .onAppear {
            if mapViewMode == .journey {
                DispatchQueue.main.async {
                    if !isColorblindModeEnabled {
                        if let journeyColor = trainViewModel.getLatestJourney(modelContext: modelContext)?.currentBackgroundColor {
                            backgroundColor = journeyColor
                        }
                    } else {
                        if let journeyColor = trainViewModel.getLatestJourney(modelContext: modelContext)?.currentBackgroundColorAccessible {
                            backgroundColor = journeyColor
                        }
                    }
                }
            }
            
            switch mapViewMode {
            case .journey:
                DispatchQueue.main.async {
                    interactiveMode = .paymentTapIn
                }
                
            case .interactive:
                DispatchQueue.main.async {
                    interactiveMode = .unknown
                }
                
            default:
                DispatchQueue.main.async {
                    interactiveMode = .unknown
                }
            }
        }
        .background(backgroundColor.opacity(0.5))
        .animation(mapViewMode == .interactive ? .easeInOut(duration: 0.5) : nil, value: backgroundColor)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
    }
    
    struct JourneyMapView: View {
        let geo: GeometryProxy
        let mapView: MapView
        
        @StateObject private var audioManager = AudioManager.helper
        @AppStorage("musicEnabled") private var isMusicEnabled: Bool = true
        
        @Binding var goToInteractive: Bool
        @Binding var goToADV: Bool
        @Binding var interactiveMode: InteractiveViewMode
        
        @Binding var showJourneySheet: Bool
        @Binding var selectedLine: TrainLine?
        
        @EnvironmentObject var trainViewModel: TrainViewModel
        @EnvironmentObject var advViewModel: ADVStoryViewModel
        @EnvironmentObject var messageViewModel: MessageViewModel
        @ObservedObject var timeHelper: TimeHelper
        // SwiftData
        @Environment(\.modelContext) private var modelContext
        
        var body: some View {
            if let playerJourney: PlayerJourney = trainViewModel.getLatestJourney(modelContext: modelContext) {
                ZStack {
                        ZStack(alignment: .topLeading) {
                            StopButton(showJourneySheet: $showJourneySheet)
                                .padding(.all, geo.size.width * 0.048)
                                .accessibilityLabel("Stop button")
                                .accessibilityHint("Select to stop the journey and back to main menu.")
                        }
                        .zIndex(1)
                        
                        VStack {
                            VStack(alignment: .center) {
                                TimelineView(.animation(minimumInterval: 0.1)) { timeline in
                                    let time = timeline.date.timeIntervalSinceReferenceDate
                                    let blinkingSpeed = 3.0
                                    let pulseEffect = 0.5 + 0.5 * sin(time * blinkingSpeed)
                                    
                                    Canvas { context, size in
                                        for line in trainViewModel.trainLines {
                                            mapView.drawTrainLine(line: line, in: geo, context: context)
                                        }
                                        
                                        for station in trainViewModel.stations where !station.isHidden {
                                            mapView.drawStation(station: station, in: geo, context: context, pulseEffect: pulseEffect, playerJourney: playerJourney)
                                        }
                                    }
                                    .sensoryFeedback(.levelChange, trigger: pulseEffect)
                                    .accessibilityLabel("Jakarta's commuter line train system map")
                                }
                            }
                            .frame(minHeight: geo.size.height * 0.55)
                            .minimumScaleFactor(0.6)
                            
                            var stationIdInt = Int(playerJourney.currentStation?.id ?? "16") ?? 16
                            
                            if let station = trainViewModel.stations.first(where: { Int($0.id) == stationIdInt }) {
                                
                                VStack() {
                                    mapView.stationInfoView(station: station, geo: geo)
                                    
                                    VStack(alignment: .center) {
                                        TimelineView(.animation(minimumInterval: 0.1)) { timeline in
                                            let time = timeline.date.timeIntervalSinceReferenceDate
                                            let blinkingSpeed = 3.0
                                            let pulseEffect = 0.5 + 0.5 * sin(time * blinkingSpeed)
                                            Canvas { context, size in
                                                mapView.drawJourneyLine(in: geo, context: context, playerJourney: playerJourney, pulseEffect: pulseEffect)
                                            }
                                            .accessibilityLabel("Robert's commute journey line, currently at: \(playerJourney.currentStation?.name ?? "Unknown")")
                                        }
                                    }
                                    .frame(minHeight: geo.size.height * 0.2)
                                    .offset(y: -geo.size.height * 0.05)
                                    
                                    NavigationLink("", destination: InteractiveView(advImage: playerJourney.currentAdvImage, interactiveMode: $interactiveMode, showJourneySheet: $showJourneySheet), isActive: Binding(get: { goToInteractive }, set: { newValue in
                                        if goToInteractive != newValue {
                                            goToInteractive = newValue
                                        }
                                    }))
                                    .hidden()
                                    
                                    NavigationLink("", destination: ADVView(showJourneySheet: $showJourneySheet), isActive: $goToADV)
                                        .hidden()
                                        .onChange(of: goToADV) {
                                            let isAfterTransit = playerJourney.hasMoved
                                            let isEnd = playerJourney.shouldTriggerEndEvent
                                            let selectedEvent = (!isAfterTransit ? "thiefIntro" : !isEnd ? "priorityIntro" : "endPreArrival")
                                            advViewModel.startStoryline(selectedEvent)
                                        }
                                }
                                .onAppear {
                                    if let playerJourney = trainViewModel.getLatestJourney(modelContext: modelContext),
                                       let associatedLine = trainViewModel.trainLines.first (where: {
                                           $0.stationID.contains(station.id)
                                       }) {
                                        playerJourney.currentBackgroundColorHex = associatedLine.colorHex
                                        playerJourney.currentBackgroundColorAccessibleHex = associatedLine.colorAccessibleHex
                                        try? modelContext.save()
                                    }
                                }
                                .padding(.horizontal, 64)
                            }
                        }
                }
                .onAppear {
                    var predeterminedTime = Date()
                    
                    switch playerJourney.arrivalTime {
                    case .train1035:
                        predeterminedTime = Calendar.current.date(bySettingHour: 10, minute: 45, second: 0, of: Date())!
                    case .train1109:
                        predeterminedTime = Calendar.current.date(bySettingHour: 11, minute: 09, second: 0, of: Date())!
                    case .train1134:
                        predeterminedTime = Calendar.current.date(bySettingHour: 11, minute: 34, second: 0, of: Date())!
                    case .nonselected:
                        predeterminedTime = Calendar.current.date(bySettingHour: 10, minute: 45, second: 0, of: Date())!
                    }
                    
                    DispatchQueue.main.async {
                        audioManager.playBackgroundMusic(assetName: "Loopliner Transport Wait", loopStartTime: 0.0, loopEndTime: 17.4)
                        timeHelper.setRandomTime(around: predeterminedTime, rangeInSeconds: 600)
                        timeHelper.startTime()
                        
                        if playerJourney.shouldTriggerTransitEvent {
                            trainViewModel.handleTransitStationEvent(playerJourney.currentStation) { mode in
                                interactiveMode = mode
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    if !goToADV {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            goToInteractive = true
                                        }
                                    }
                                }
                            }
                        } else if playerJourney.currentStationIndex == 0 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                if !goToADV {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        goToInteractive = true
                                    }
                                }
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.9) {
                                goToADV = false
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    goToADV = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    struct InteractiveMapView: View {
        let geo: GeometryProxy
        let mapView: MapView
        
        @Environment(\.colorScheme) private var colorScheme
        @Binding var selectedStationId: Int?
        var trainViewModel: TrainViewModel
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                BackButton()
                    .padding(.all, geo.size.width * 0.032)
                    .accessibilityLabel("Back button")
                    .accessibilityHint("Select to back to the main menu.")
            }
            
            ZStack(alignment: .topTrailing) {
                Text("MAP")
                    .font(.custom("UnicaOne-Regular", size: geo.size.width * 0.072))
                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                    .padding(.top, geo.size.width * 0.016)
                    .padding(.trailing, geo.size.width * 0.032)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            VStack {
                VStack(alignment: .center) {
                    ZStack {
                        Canvas { context, size in
                            for line in trainViewModel.trainLines {
                                mapView.drawTrainLine(line: line, in: geo, context: context)
                            }
                            
                            for station in trainViewModel.stations where !station.isHidden {
                                mapView.drawStation(station: station, in: geo,  context: context)
                            }
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        mapView.handleTap(at: value.location, geo: geo)

                                    }
                                }
                        )
                    }
                    .accessibilityLabel("Jakarta's commuter line train system map.")
                    .accessibilityHint("Tap at one of a station to see its detail.")
                }
                .frame(maxHeight: geo.size.height * 0.55)
                
                if let selectedStationId = selectedStationId,
                   let station = trainViewModel.stations.first(where: { Int($0.id) == selectedStationId }) {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Station • \(station.stationType?.rawValue ?? "Regular")")
                                    .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.024))
                                
                                Text("\(station.name)")
                                    .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.064))
                                
                                Text("\(station.stationCode ?? "Code") • Opened \(station.dateOpened ?? "on Date") • \(station.lanes ?? 2) lanes")
                                    .font(.custom("SpaceGrotesk-SemiBold", size: geo.size.width * 0.020))
                            }
                            .minimumScaleFactor(0.85)
                            .accessibilityElement(children: .ignore)
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "lines.measurement.vertical")
                                        .font(.system(size: geo.size.width * 0.024))
                                        .padding(.horizontal, 16)
                                        .accessibilityHidden(true)
                                    
                                    Text("+ \(station.heightMeasurement ?? 0) m")
                                        .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.020))
                                }
                                .accessibilityLabel("Station height measurement from the sea: \(station.heightMeasurement ?? 0) meters")
                                .padding(.all, 4)
                                
                                HStack {
                                    Image(systemName: "building.fill")
                                        .font(.system(size: geo.size.width * 0.024))
                                        .padding(.horizontal, 16)
                                        .accessibilityHidden(true)
                                    
                                    Text("\(station.stationBuiltType?.rawValue ?? "N/A")")
                                        .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.020))
                                }
                                .accessibilityLabel("Station built type: \(station.stationBuiltType?.rawValue ?? "Not available")")
                                .padding(.all, 4)
                                
                                HStack {
                                    Image(systemName: "bolt.badge.checkmark.fill")
                                        .font(.system(size: geo.size.width * 0.024))
                                        .padding(.horizontal, 16)
                                        .accessibilityHidden(true)
                                    
                                    Text("\(station.electrifiedYear ?? "")")
                                        .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.020))
                                }
                                .accessibilityLabel("This station was electrified in \(station.stationBuiltType?.rawValue ?? "")")
                                .padding(.all, 4)
                                
                                HStack {
                                    Image(systemName: "square.resize.up")
                                        .font(.system(size: geo.size.width * 0.024))
                                        .padding(.horizontal, 16)
                                    
                                    Text("\(station.stationSize?.rawValue ?? "Small")")
                                        .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.020))
                                }
                                .accessibilityLabel("This station size is \(station.stationBuiltType?.rawValue ?? "Small")")
                                .padding(.all, 4)
                            }
                        }
                        
                        let associatedLines = trainViewModel.trainLines.filter {
                            $0.stationID.contains(station.id)
                        }
                        
                        ForEach(associatedLines, id: \.self) { line in
                            HStack(alignment: .center) {
                                ZStack {
                                    Circle()
                                        .stroke(line.color, lineWidth: 10)
                                        .fill(Color.white)
                                        .frame(width: geo.size.width * 0.028, height: geo.size.height * 0.028)

                                    Text(String(line.name.prefix(1)))
                                        .foregroundColor(Color.black)
                                        .fontWeight(.bold)
                                }
                                .accessibilityHidden(true)
                                
                                Text(line.name)
                                    .font(.custom("SpaceGrotesk-Medium", size: geo.size.width * 0.020))
                            }
                            .accessibilityElement(children: .ignore)
                        }
                        
                        HStack(alignment: .center) {
                            Text("Tap anywhere to dismiss detail & pressing back button to return to the menu.")
                                .font(.custom("SpaceGrotesk-Medium", size: geo.size.width * 0.016))
                                .opacity(0.5)
                        }
                    }
                    .padding(.horizontal, 64)
                } else {
                    HStack {
                        Text("Tap on a station to see more.")
                            .font(.custom("SpaceGrotesk-Medium", size: geo.size.width * 0.032))
                            .opacity(0.5)
                    }
                    .padding(.horizontal, 64)
                }
            }
            .minimumScaleFactor(0.8)
            .padding(.horizontal, 16)
        }
    }
    
    func stationInfoView(station: Station, geo: GeometryProxy) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("You're now in")
                        .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.032))
                    
                    Text(station.name)
                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.064))
                }
                .accessibilityElement(children: .ignore)
                
                Spacer()
                
                VStack {
                    if let randomTime = timeHelper.randomTime {
                        Text(timeHelper.formattedTime(randomTime))
                            .font(.custom("SpaceGrotesk-Regular", size: geo.size.width * 0.032))
                            .accessibilityLabel("Current time: \(timeHelper.formattedTime(randomTime))")
                    }
                }
                
            }
        }
    }
    
    func drawTrainLine(line: TrainLine, in geometry: GeometryProxy, context: GraphicsContext) {
        let width = geometry.size.width
        let height = geometry.size.height
        let stationPoints = line.stationID.compactMap { stationID in
            trainViewModel.stations.first(where: { $0.id == stationID })?.position
        }
        
        let scaledPoints = stationPoints.map {
            CGPoint(x: $0.x * width, y: $0.y * height)
        }
        guard scaledPoints.count >= 2 else { return }
        var path = Path()
        path.move(to: scaledPoints[0])
        
        for i in 1..<scaledPoints.count {
            let start = scaledPoints[i - 1]
            let end = scaledPoints[i]
            
            if shouldCurveBetweenStations(start: start, end: end) {
                let distance = hypot(end.x - start.x, end.y - start.y)
                let curveHeight = distance * 0.3
                
                let controlPoint = CGPoint(
                    x: (start.x + end.x) / 2,
                    y: (start.y + end.y) / 2 - curveHeight
                )
                path.addQuadCurve(to: end, control: controlPoint)
            } else {
                path.addLine(to: end)
            }
        }
        
        context.stroke(path, with: .color(.black), lineWidth: width * 0.005)
    }
    
    func drawStation(station: Station, in geometry: GeometryProxy, context: GraphicsContext, pulseEffect: Double? = 0.5, playerJourney: PlayerJourney? = nil) {
        let width = geometry.size.width
        let height = geometry.size.height
        
        #if targetEnvironment(macCatalyst)
        let scaledPosition = CGPoint(x: station.position.x * width * 1.0, y: station.position.y * height * 1.0)
        #else
        let scaledPosition = CGPoint(x: station.position.x * width, y: station.position.y * height)
        #endif
        
        let associatedLines = trainViewModel.trainLines.filter {
            $0.stationID.contains(station.id)
        }
        
        let isIntersectionStation = trainViewModel.trainLines.filter { $0.stationID.contains(station.id)}.count > 1
        let isCurrentStation = station.id == playerJourney?.currentStation?.id
        let isTapped = Int(station.id) == selectedStationId
        let isLapsed = mapViewMode == .journey && lapsedStations?.contains(station.id) == true
        
        let size = min(geometry.size.width, geometry.size.height)
        let dotSize = isIntersectionStation ? size * 0.035 : size * 0.0225
        let dotInnerSize = isIntersectionStation ? size * 0.035 : size * 0.0225
        
        let gradient = Gradient(colors: associatedLines.map {
            $0.color
        })
        
        let gradientAccessible = Gradient(colors: associatedLines.map {
            $0.colorAccessible
        })
        
        let baseColor: Color = {
            if isCurrentStation {
                return Color("MenuRedTwo")
            } else if (isTapped || isLapsed) && !isColorblindModeEnabled {
                return Color("LapsedStationColor")
            } else if (isTapped || isLapsed) && isColorblindModeEnabled {
                return Color("LapsedStationColorAccessible")
            } else {
                return Color.white
            }
        }()
        
        let fillColor: Color = isCurrentStation ? baseColor.opacity(1 - (pulseEffect ?? 0.5)) : baseColor
        
        withAnimation(.easeInOut(duration: 0.5)) {
            context.fill(Path(ellipseIn: CGRect(x: scaledPosition.x - dotInnerSize / 2,
                                                y: scaledPosition.y - dotInnerSize / 2,
                                                width: dotInnerSize, height: dotInnerSize)), with: .color(fillColor))
        }

        if !isColorblindModeEnabled {
            if isIntersectionStation {
                let gradientStroke: () = context.stroke(
                    Path(ellipseIn:
                            CGRect(x: scaledPosition.x - dotSize / 2,
                                   y: scaledPosition.y - dotSize / 2,
                                   width: dotSize, height: dotSize)),
                    with: .linearGradient(gradient, startPoint: CGPoint(x: scaledPosition.x - dotSize / 2,
                                                                          y: scaledPosition.y - dotSize / 2),
                                                                                endPoint: CGPoint(x: scaledPosition.x + dotSize / 2,
                                                                                                  y: scaledPosition.y + dotSize / 2)),
                    lineWidth: geometry.size.width * 0.005
                )
                
                context.draw(Text(station.name)
                    .font(.custom("SpaceGrotesk-Medium", size: width * 0.008))
                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black),
                             at: CGPoint(x: scaledPosition.x, y: scaledPosition.y + 20))
            } else {
                let gradientStroke: () = context.stroke(
                    Path(ellipseIn:
                            CGRect(x: scaledPosition.x - dotSize / 2,
                                   y: scaledPosition.y - dotSize / 2,
                                   width: dotSize, height: dotSize)),
                    with: .linearGradient(gradient, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)),
                    lineWidth: geometry.size.width * 0.005
                )
            }
        } else {
            if isIntersectionStation {
                let gradientStroke: () = context.stroke(
                    Path(ellipseIn:
                            CGRect(x: scaledPosition.x - dotSize / 2,
                                   y: scaledPosition.y - dotSize / 2,
                                   width: dotSize, height: dotSize)),
                    with: .linearGradient(gradientAccessible, startPoint: CGPoint(x: scaledPosition.x - dotSize / 2,
                                                                          y: scaledPosition.y - dotSize / 2),
                                                                                endPoint: CGPoint(x: scaledPosition.x + dotSize / 2,
                                                                                                  y: scaledPosition.y + dotSize / 2)),
                    lineWidth: geometry.size.width * 0.005
                )
                
                context.draw(Text(station.name)
                    .font(.custom("SpaceGrotesk-Medium", size: width * 0.008))
                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black),
                             at: CGPoint(x: scaledPosition.x, y: scaledPosition.y + 20))
            } else {
                let gradientStroke: () = context.stroke(
                    Path(ellipseIn:
                            CGRect(x: scaledPosition.x - dotSize / 2,
                                   y: scaledPosition.y - dotSize / 2,
                                   width: dotSize, height: dotSize)),
                    with: .linearGradient(gradientAccessible, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)),
                    lineWidth: geometry.size.width * 0.005
                )
            }
        }
    }
    
    func drawJourneyLine(in geometry: GeometryProxy, context: GraphicsContext, playerJourney: PlayerJourney, pulseEffect: Double) {
        let width = geometry.size.width * 0.85
        let height = geometry.size.height * 0.3
        
        let journeyStationsIds = playerJourney.stationJourney ?? []
        let journeyStations = journeyStationsIds.compactMap { stationId in
            trainViewModel.stations.first {
                $0.id == stationId
            }
        }
        
        guard journeyStations.count >= 2 else { return }
        
        let stationPoints = journeyStations.enumerated().map { index, station -> (station: Station, position: CGPoint) in
            let xPosition = width * 0.025 + CGFloat(index) * ((width * 0.95) / CGFloat(journeyStations.count - 1))
            let yPosition = height / 2
            
            return (station, CGPoint(x: xPosition, y: yPosition))
        }
        
        var path = Path()
        
        path.move(to: stationPoints[0].position)
        for point in stationPoints.dropFirst() {
            path.addLine(to: point.position)
        }
        context.stroke(path, with: .color(.blue), lineWidth: width * 0.005)
        
        for(station, position) in stationPoints {
            let associatedLines = trainViewModel.trainLines.filter {
                $0.stationID.contains(station.id)
            }
            let isIntersectionStation = trainViewModel.trainLines.filter { $0.stationID.contains(station.id)}.count > 1
            let isCurrentStation = station.id == playerJourney.currentStation?.id
            let isLapsed = mapViewMode == .journey && playerJourney.lapsedStations?.contains(station.id) == true
            
            let gradient = Gradient(colors: associatedLines.map {
                $0.color
            })
            let gradientAccessible = Gradient(colors: associatedLines.map {
                $0.colorAccessible
            })
            
            let dotSize = width * 0.025
            
            let dotPath = Path(ellipseIn: CGRect(x: position.x - dotSize / 2, y: position.y - dotSize / 2, width: dotSize, height: dotSize))
            
            let baseColor: Color = {
                if isCurrentStation {
                    return Color("MenuRedTwo")
                } else if isLapsed && !isColorblindModeEnabled {
                    return Color("LapsedStationColor")
                } else if isLapsed && isColorblindModeEnabled {
                    return Color("LapsedStationColorAccessible")
                } else {
                    return Color.white
                }
            }()
            
            let fillColor: Color = isCurrentStation ? baseColor.opacity(pulseEffect) : baseColor
            
            context.fill(dotPath, with: .color(fillColor))
            
            if !isColorblindModeEnabled {
                if isIntersectionStation {
                    context.stroke(dotPath, with: .linearGradient(gradient, startPoint: CGPoint(x: position.x - dotSize / 2,
                                y: position.y - dotSize / 2),
                                endPoint: CGPoint(x: position.x + dotSize / 2,
                                                  y: position.y + dotSize / 2)),
                                   lineWidth: width * 0.005)
                } else {
                    context.stroke(dotPath, with: .linearGradient(gradient, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)), lineWidth: width * 0.005)
                }
            } else {
                if isIntersectionStation {
                    context.stroke(dotPath, with: .linearGradient(gradientAccessible, startPoint: CGPoint(x: position.x - dotSize / 2,
                                y: position.y - dotSize / 2),
                                endPoint: CGPoint(x: position.x + dotSize / 2,
                                                  y: position.y + dotSize / 2)),
                                   lineWidth: width * 0.005)
                } else {
                    context.stroke(dotPath, with: .linearGradient(gradientAccessible, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)), lineWidth: width * 0.005)
                }
            }
            
            context.drawLayer { ctx in
                ctx.translateBy(x: position.x + (width * 0.025), y: position.y - (width * 0.06))
                ctx.rotate(by: .degrees(-45))
                let text = Text(station.name)
                    .font(.custom("SpaceGrotesk-Medium", size: width * 0.015))
                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                ctx.draw(text, at: .zero, anchor: .center)
            }
        }
    }
    
    func handleTap(at location: CGPoint, geo: GeometryProxy) {
        
        for station in trainViewModel.stations {
            let scaledPosition = CGPoint(
                x: station.position.x * geo.size.width,
                y: station.position.y * geo.size.height
                )
            
            let tapRadius = max(geo.size.width, geo.size.height) * 0.02
            
            let distance = hypot(location.x - scaledPosition.x, location.y - scaledPosition.y)
            
            if distance <= tapRadius {
                withAnimation(.easeInOut(duration: 0.5)) {
                    selectedStationId = Int(station.id)
                    AudioManager.helper.playSFX(assetName: "Button Pressing")
                    
                    if let associatedLine = trainViewModel.trainLines.first (where: {
                        $0.stationID.contains(station.id)
                    }) {
                        selectedLine = associatedLine
                    }
                }
                
                return
            }
        }
        
        withAnimation(.easeInOut(duration: 0.5)) {
            selectedLine = nil
            selectedStationId = nil
        }
    }
    
    func shouldCurveBetweenStations(start: CGPoint, end: CGPoint) -> Bool {
        return abs(end.x - start.x) > 50 && abs(end.y - start.y) > 30
    }
}

//#Preview {
//    MapView()
//}
