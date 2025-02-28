//
//  TrainSelectView.swift
//  Loopliner
//
//  Created by Lonard Steven on 02/02/25.
//

import SwiftUI

struct TrainSelectView: View {
    @StateObject private var timeHelper = TimeHelper.shared
    let geo: GeometryProxy
    let trains: [Train]
    let stations: [Station]
    let arrivalStation: Station
    
    @EnvironmentObject private var trainViewModel: TrainViewModel
    @Binding var interactiveMode: InteractiveViewMode
    var playerJourney: PlayerJourney
    
    var gridColumns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var nearestTrains: [Train] {
        trains
            .filter { train in
                train.parentLineId == "2" &&
                train.stops.contains { $0.stationId == arrivalStation.id }
            }
            .sorted { (trainA, trainB) in
                let timeA = trainA.stops.first (where: { $0.stationId == arrivalStation.id})?.arrivalTime ?? Date.distantFuture
                let timeB = trainB.stops.first (where: { $0.stationId == arrivalStation.id})?.arrivalTime ?? Date.distantFuture
                return timeA < timeB
            }
            .prefix(2)
            .map { $0 }
    }
    
    func lastStationName(for train: Train) -> String {
        guard let lastStop = train.stops.sorted(by: { $0.arrivalTime ?? .distantPast < $1.arrivalTime ?? .distantPast}).last else {
            return "Unknown"
        }
        if let station = stations.first(where: { $0.id == lastStop.stationId })  {
            return station.name
        } else {
            return "Unknown"
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if nearestTrains.isEmpty {
                Text("No trains available")
                    .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.064))
            } else {
                LazyVGrid(columns: gridColumns, spacing: 8) {
                    ForEach(nearestTrains, id: \.id) { train in
                        trainCard(for: train)
                            .onTapGesture {
                                AudioManager.helper.playSFX(assetName: "Button Pressing")
                                trainViewModel.transitToNewTrain(selectedTrain: train, playerJourney: playerJourney)
                                handleTrainSelection(train: train, isFirstDepart: nearestTrains.first?.id == train.id)
                            }
                    }
                }
            }
        }
    }
    
    private func trainCard(for train: Train) -> some View {
        @Namespace var animationNamespace
        
        return RoundedRectangle(cornerRadius: 24)
            .fill(Color("TrainSelectButtonColor"))
            .frame(width: geo.size.width * 0.28, height: geo.size.height * 0.60)
            .overlay {
                VStack {
                    Image(systemName: "train.side.front.car")
                        .resizable()
                        .frame(width: geo.size.width * 0.128, height: geo.size.height * 0.128)
                        .matchedGeometryEffect(id: "trainSideFront-\(train.id)", in: animationNamespace)
                    
                    if let stop = train.stops.first(where: { $0.stationId == arrivalStation.id }),
                       let departureTime = stop.departureTime {
                        Text(timeHelper.formattedTimeForTrainSelect(departureTime))
                            .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.056))
                            .matchedGeometryEffect(id: "departureTime-\(train.id)", in: animationNamespace)
                    } else {
                        Text("No Time")
                            .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.028))
                            .matchedGeometryEffect(id: "departureTime-\(train.id)", in: animationNamespace)
                    }
                    
                    Text("for \(lastStationName(for: train))")
                        .font(.custom("SpaceGrotesk-Bold", size: geo.size.width * 0.028))
                        .matchedGeometryEffect(id: "lastStationName-\(train.id)", in: animationNamespace)
                }
                .foregroundStyle(Color.black)
                .shadow(radius: 8)
                .transition(.scale.combined(with: .opacity))
                .animation(.spring(response: 0.35, dampingFraction: 0.8), value: trains)
                .padding(.all, 8)
                .frame(alignment: .center)
            }
            .accessibilityElement(children: .combine)
    }
    
    func handleTrainSelection(train: Train, isFirstDepart: Bool) {
        if isFirstDepart {
            DispatchQueue.main.async {
                interactiveMode = .goToIntermission
            }
        } else {
            DispatchQueue.main.async {
                interactiveMode = .goToMessage(withCondition: 4)
            }
        }
    }
}
