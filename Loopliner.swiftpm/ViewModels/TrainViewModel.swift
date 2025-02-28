//
//  TrainViewModel.swift
//  Loopliner
//
//  Created by Lonard Steven on 23/01/25.
//

import SwiftUI
import SwiftData
import Combine

class TrainViewModel: ObservableObject {
    @Published var playerJourney: PlayerJourney?
    @ObservedObject private var dataManager: SwiftDataManager
    
    @StateObject private var timeHelper = TimeHelper.shared
    
    private var advViewModel: ADVStoryViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataManager: SwiftDataManager, advViewModel: ADVStoryViewModel) {
        self.dataManager = dataManager
        self.advViewModel = advViewModel
        dataManager.$playerJourney
            .receive(on: DispatchQueue.main)
            .sink { [weak self] playerJourney in
                self?.playerJourney = playerJourney
            }
            .store(in: &cancellables)
    }
    
    var trains: [Train] = [
        Train(
            id: "6021",
            name: "6021",
            parentLineId: "1",
            routeVariationId: "C2",
            stops: [
                TrainStop(id: "S001", stationId: "5", arrivalTime: nil, departureTime: TimeHelper.date(from: "09:58")),
                TrainStop(id: "S002", stationId: "6", arrivalTime: TimeHelper.date(from: "10:00"), departureTime: TimeHelper.date(from: "10:01")),
                TrainStop(id: "S003", stationId: "7", arrivalTime: TimeHelper.date(from: "10:05"), departureTime: TimeHelper.date(from: "10:06")),
                TrainStop(id: "S004", stationId: "8", arrivalTime: TimeHelper.date(from: "10:09"), departureTime: TimeHelper.date(from: "10:10")),
                TrainStop(id: "S005", stationId: "9", arrivalTime: TimeHelper.date(from: "10:10"), departureTime: TimeHelper.date(from: "10:11")),
                TrainStop(id: "S006", stationId: "10", arrivalTime: TimeHelper.date(from: "10:12"), departureTime: TimeHelper.date(from: "10:13")),
                TrainStop(id: "S007", stationId: "11", arrivalTime: TimeHelper.date(from: "10:16"), departureTime: TimeHelper.date(from: "10:18")),
                TrainStop(id: "S008", stationId: "81", arrivalTime: TimeHelper.date(from: "10:20"), departureTime: TimeHelper.date(from: "10:20")),
                TrainStop(id: "S009", stationId: "12", arrivalTime: TimeHelper.date(from: "10:22"), departureTime: TimeHelper.date(from: "10:22")),
                TrainStop(id: "S010", stationId: "13", arrivalTime: TimeHelper.date(from: "10:23"), departureTime: TimeHelper.date(from: "10:23")),
                TrainStop(id: "S011", stationId: "14", arrivalTime: TimeHelper.date(from: "10:28"), departureTime: TimeHelper.date(from: "10:29")),
                TrainStop(id: "S012", stationId: "15", arrivalTime: TimeHelper.date(from: "10:32"), departureTime: TimeHelper.date(from: "10:33")),
                TrainStop(id: "S013", stationId: "16", arrivalTime: TimeHelper.date(from: "10:35"), departureTime: TimeHelper.date(from: "10:35")),
                TrainStop(id: "S014", stationId: "17", arrivalTime: TimeHelper.date(from: "10:40"), departureTime: TimeHelper.date(from: "10:41")),
                TrainStop(id: "S015", stationId: "21", arrivalTime: TimeHelper.date(from: "10:50"), departureTime: TimeHelper.date(from: "10:50")),
                TrainStop(id: "S016", stationId: "22", arrivalTime: TimeHelper.date(from: "10:53"), departureTime: TimeHelper.date(from: "10:54")),
                TrainStop(id: "S017", stationId: "23", arrivalTime: TimeHelper.date(from: "11:01"), departureTime: TimeHelper.date(from: "11:02")),
                TrainStop(id: "S018", stationId: "24", arrivalTime: TimeHelper.date(from: "11:05"), departureTime: TimeHelper.date(from: "11:05")),
                TrainStop(id: "S019", stationId: "25", arrivalTime: TimeHelper.date(from: "11:06"), departureTime: TimeHelper.date(from: "11:06")),
                TrainStop(id: "S020", stationId: "26", arrivalTime: TimeHelper.date(from: "11:07"), departureTime: TimeHelper.date(from: "11:07")),
                TrainStop(id: "S021", stationId: "27", arrivalTime: TimeHelper.date(from: "11:13"), departureTime: TimeHelper.date(from: "11:14")),
                TrainStop(id: "S022", stationId: "28", arrivalTime: TimeHelper.date(from: "11:14"), departureTime: TimeHelper.date(from: "11:16")),
                TrainStop(id: "S023", stationId: "11", arrivalTime: TimeHelper.date(from: "11:20"), departureTime: TimeHelper.date(from: "11:21")),
                TrainStop(id: "S024", stationId: "10", arrivalTime: TimeHelper.date(from: "11:24"), departureTime: TimeHelper.date(from: "11:24")),
                TrainStop(id: "S025", stationId: "9", arrivalTime: TimeHelper.date(from: "11:25"), departureTime: TimeHelper.date(from: "11:26")),
                TrainStop(id: "S026", stationId: "8", arrivalTime: TimeHelper.date(from: "11:27"), departureTime: TimeHelper.date(from: "11:27")),
                TrainStop(id: "S027", stationId: "7", arrivalTime: TimeHelper.date(from: "11:33"), departureTime: TimeHelper.date(from: "11:34")),
                TrainStop(id: "S028", stationId: "6", arrivalTime: TimeHelper.date(from: "11:36"), departureTime: TimeHelper.date(from: "11:37")),
                TrainStop(id: "S029", stationId: "5", arrivalTime: TimeHelper.date(from: "11:41"), departureTime: nil)
            ],
            trainImage: "JR205_1"
        ),
        Train(
            id: "6023",
            name: "6023",
            parentLineId: "1",
            routeVariationId: "C1",
            stops: [
                TrainStop(id: "S030", stationId: "1", arrivalTime: nil, departureTime: TimeHelper.date(from: "10:02")),
                TrainStop(id: "S031", stationId: "2", arrivalTime: TimeHelper.date(from: "10:05"), departureTime: TimeHelper.date(from: "10:06")),
                TrainStop(id: "S032", stationId: "3", arrivalTime: TimeHelper.date(from: "10:08"), departureTime: TimeHelper.date(from: "10:08")),
                TrainStop(id: "S033", stationId: "82", arrivalTime: TimeHelper.date(from: "10:16"), departureTime: TimeHelper.date(from: "10:16")),
                TrainStop(id: "S034", stationId: "4", arrivalTime: TimeHelper.date(from: "10:20"), departureTime: TimeHelper.date(from: "10:20")),
                TrainStop(id: "S035", stationId: "5", arrivalTime: TimeHelper.date(from: "10:27"), departureTime: TimeHelper.date(from: "10:27")),
                TrainStop(id: "S036", stationId: "6", arrivalTime: TimeHelper.date(from: "10:29"), departureTime: TimeHelper.date(from: "10:30")),
                TrainStop(id: "S037", stationId: "7", arrivalTime: TimeHelper.date(from: "10:35"), departureTime: TimeHelper.date(from: "10:35")),
                TrainStop(id: "S038", stationId: "8", arrivalTime: TimeHelper.date(from: "10:39"), departureTime: TimeHelper.date(from: "10:39")),
                TrainStop(id: "S039", stationId: "9", arrivalTime: TimeHelper.date(from: "10:40"), departureTime: TimeHelper.date(from: "10:40")),
                TrainStop(id: "S040", stationId: "10", arrivalTime: TimeHelper.date(from: "10:41"), departureTime: TimeHelper.date(from: "10:42")),
                TrainStop(id: "S041", stationId: "11", arrivalTime: TimeHelper.date(from: "10:50"), departureTime: TimeHelper.date(from: "10:51")),
                TrainStop(id: "S042", stationId: "81", arrivalTime: TimeHelper.date(from: "10:53"), departureTime: TimeHelper.date(from: "10:53")),
                TrainStop(id: "S043", stationId: "12", arrivalTime: TimeHelper.date(from: "10:55"), departureTime: TimeHelper.date(from: "10:55")),
                TrainStop(id: "S044", stationId: "13", arrivalTime: TimeHelper.date(from: "10:56"), departureTime: TimeHelper.date(from: "10:56")),
                TrainStop(id: "S045", stationId: "14", arrivalTime: TimeHelper.date(from: "11:03"), departureTime: TimeHelper.date(from: "11:03")),
                TrainStop(id: "S046", stationId: "15", arrivalTime: TimeHelper.date(from: "11:07"), departureTime: TimeHelper.date(from: "11:07")),
                TrainStop(id: "S047", stationId: "16", arrivalTime: TimeHelper.date(from: "11:09"), departureTime: TimeHelper.date(from: "11:09")),
                TrainStop(id: "S048", stationId: "17", arrivalTime: TimeHelper.date(from: "11:14"), departureTime: TimeHelper.date(from: "11:16")),
                TrainStop(id: "S049", stationId: "21", arrivalTime: TimeHelper.date(from: "11:24"), departureTime: TimeHelper.date(from: "11:25")),
                TrainStop(id: "S050", stationId: "22", arrivalTime: TimeHelper.date(from: "11:29"), departureTime: TimeHelper.date(from: "11:30")),
                TrainStop(id: "S051", stationId: "23", arrivalTime: TimeHelper.date(from: "11:37"), departureTime: TimeHelper.date(from: "11:38")),
                TrainStop(id: "S052", stationId: "24", arrivalTime: TimeHelper.date(from: "11:41"), departureTime: TimeHelper.date(from: "11:41")),
                TrainStop(id: "S053", stationId: "25", arrivalTime: TimeHelper.date(from: "11:42"), departureTime: TimeHelper.date(from: "11:42")),
                TrainStop(id: "S054", stationId: "26", arrivalTime: TimeHelper.date(from: "11:43"), departureTime: TimeHelper.date(from: "11:43")),
                TrainStop(id: "S055", stationId: "27", arrivalTime: TimeHelper.date(from: "11:50"), departureTime: TimeHelper.date(from: "11:51")),
                TrainStop(id: "S056", stationId: "28", arrivalTime: TimeHelper.date(from: "11:53"), departureTime: TimeHelper.date(from: "11:53")),
                TrainStop(id: "S057", stationId: "11", arrivalTime: TimeHelper.date(from: "11:59"), departureTime: TimeHelper.date(from: "12:00")),
                TrainStop(id: "S058", stationId: "10", arrivalTime: TimeHelper.date(from: "12:03"), departureTime: TimeHelper.date(from: "12:03")),
                TrainStop(id: "S059", stationId: "9", arrivalTime: TimeHelper.date(from: "12:05"), departureTime: TimeHelper.date(from: "12:05")),
                TrainStop(id: "S060", stationId: "8", arrivalTime: TimeHelper.date(from: "12:06"), departureTime: TimeHelper.date(from: "12:06")),
                TrainStop(id: "S061", stationId: "7", arrivalTime: TimeHelper.date(from: "12:13"), departureTime: TimeHelper.date(from: "12:13")),
                TrainStop(id: "S062", stationId: "6", arrivalTime: TimeHelper.date(from: "12:16"), departureTime: TimeHelper.date(from: "12:16")),
                TrainStop(id: "S063", stationId: "5", arrivalTime: TimeHelper.date(from: "12:21"), departureTime: TimeHelper.date(from: "12:22")),
                TrainStop(id: "S064", stationId: "4", arrivalTime: TimeHelper.date(from: "12:24"), departureTime: TimeHelper.date(from: "12:24")),
                TrainStop(id: "S065", stationId: "82", arrivalTime: TimeHelper.date(from: "12:36"), departureTime: TimeHelper.date(from: "12:37")),
                TrainStop(id: "S066", stationId: "3", arrivalTime: TimeHelper.date(from: "12:40"), departureTime: TimeHelper.date(from: "12:40")),
                TrainStop(id: "S067", stationId: "2", arrivalTime: TimeHelper.date(from: "12:42"), departureTime: TimeHelper.date(from: "12:42")),
                TrainStop(id: "S068", stationId: "1", arrivalTime: TimeHelper.date(from: "12:49"), departureTime: TimeHelper.date(from: "12:49"))
            ],
            trainImage: "JR205_1"
        ),
        Train(
            id: "6025",
            name: "6025",
            parentLineId: "1",
            routeVariationId: "C3",
            stops: [
                TrainStop(id: "S069", stationId: "1", arrivalTime: nil, departureTime: TimeHelper.date(from: "10:30")),
                TrainStop(id: "S070", stationId: "2", arrivalTime: TimeHelper.date(from: "10:34"), departureTime: TimeHelper.date(from: "10:34")),
                TrainStop(id: "S071", stationId: "3", arrivalTime: TimeHelper.date(from: "10:36"), departureTime: TimeHelper.date(from: "10:36")),
                TrainStop(id: "S072", stationId: "82", arrivalTime: TimeHelper.date(from: "10:43"), departureTime: TimeHelper.date(from: "10:44")),
                TrainStop(id: "S073", stationId: "4", arrivalTime: TimeHelper.date(from: "10:47"), departureTime: TimeHelper.date(from: "10:48")),
                TrainStop(id: "S074", stationId: "5", arrivalTime: TimeHelper.date(from: "10:52"), departureTime: TimeHelper.date(from: "10:53")),
                TrainStop(id: "S075", stationId: "6", arrivalTime: TimeHelper.date(from: "10:56"), departureTime: TimeHelper.date(from: "10:56")),
                TrainStop(id: "S076", stationId: "7", arrivalTime: TimeHelper.date(from: "11:02"), departureTime: TimeHelper.date(from: "11:02")),
                TrainStop(id: "S077", stationId: "8", arrivalTime: TimeHelper.date(from: "11:05"), departureTime: TimeHelper.date(from: "11:06")),
                TrainStop(id: "S078", stationId: "9", arrivalTime: TimeHelper.date(from: "11:07"), departureTime: TimeHelper.date(from: "11:07")),
                TrainStop(id: "S079", stationId: "10", arrivalTime: TimeHelper.date(from: "10:49"), departureTime: TimeHelper.date(from: "10:49")),
                TrainStop(id: "S080", stationId: "11", arrivalTime: TimeHelper.date(from: "11:14"), departureTime: TimeHelper.date(from: "11:15")),
                TrainStop(id: "S081", stationId: "81", arrivalTime: TimeHelper.date(from: "11:17"), departureTime: TimeHelper.date(from: "11:17")),
                TrainStop(id: "S082", stationId: "12", arrivalTime: TimeHelper.date(from: "11:19"), departureTime: TimeHelper.date(from: "11:19")),
                TrainStop(id: "S083", stationId: "13", arrivalTime: TimeHelper.date(from: "11:20"), departureTime: TimeHelper.date(from: "11:20")),
                TrainStop(id: "S084", stationId: "14", arrivalTime: TimeHelper.date(from: "11:28"), departureTime: TimeHelper.date(from: "11:28")),
                TrainStop(id: "S085", stationId: "15", arrivalTime: TimeHelper.date(from: "11:32"), departureTime: TimeHelper.date(from: "11:32")),
                TrainStop(id: "S086", stationId: "16", arrivalTime: TimeHelper.date(from: "11:34"), departureTime: TimeHelper.date(from: "11:34")),
                TrainStop(id: "S087", stationId: "17", arrivalTime: TimeHelper.date(from: "11:40"), departureTime: TimeHelper.date(from: "11:40")),
                TrainStop(id: "S088", stationId: "21", arrivalTime: TimeHelper.date(from: "11:49"), departureTime: TimeHelper.date(from: "11:50")),
                TrainStop(id: "S089", stationId: "22", arrivalTime: TimeHelper.date(from: "11:54"), departureTime: TimeHelper.date(from: "11:54")),
                TrainStop(id: "S090", stationId: "23", arrivalTime: TimeHelper.date(from: "12:01"), departureTime: TimeHelper.date(from: "12:02")),
                TrainStop(id: "S091", stationId: "24", arrivalTime: TimeHelper.date(from: "12:05"), departureTime: TimeHelper.date(from: "12:05")),
                TrainStop(id: "S092", stationId: "25", arrivalTime: TimeHelper.date(from: "12:06"), departureTime: TimeHelper.date(from: "12:06")),
                TrainStop(id: "S093", stationId: "26", arrivalTime: TimeHelper.date(from: "12:07"), departureTime: TimeHelper.date(from: "12:07")),
                TrainStop(id: "S094", stationId: "27", arrivalTime: TimeHelper.date(from: "12:14"), departureTime: TimeHelper.date(from: "12:14")),
                TrainStop(id: "S095", stationId: "28", arrivalTime: TimeHelper.date(from: "12:16"), departureTime: TimeHelper.date(from: "12:16")),
                TrainStop(id: "S096", stationId: "11", arrivalTime: TimeHelper.date(from: "12:20"), departureTime: TimeHelper.date(from: "12:21")),
                TrainStop(id: "S097", stationId: "10", arrivalTime: TimeHelper.date(from: "12:24"), departureTime: TimeHelper.date(from: "12:24")),
                TrainStop(id: "S098", stationId: "9", arrivalTime: TimeHelper.date(from: "12:26"), departureTime: TimeHelper.date(from: "12:26")),
                TrainStop(id: "S099", stationId: "8", arrivalTime: TimeHelper.date(from: "12:27"), departureTime: TimeHelper.date(from: "12:27")),
                TrainStop(id: "S100", stationId: "7", arrivalTime: TimeHelper.date(from: "12:33"), departureTime: TimeHelper.date(from: "12:34")),
                TrainStop(id: "S101", stationId: "6", arrivalTime: TimeHelper.date(from: "12:37"), departureTime: TimeHelper.date(from: "12:37")),
                TrainStop(id: "S102", stationId: "5", arrivalTime: TimeHelper.date(from: "12:41"), departureTime: nil)
            ],
            trainImage: "JR205_1"
        ),
        
        Train(
            id: "1686",
            name: "1686",
            parentLineId: "2",
            routeVariationId: "R1",
            stops: [
                TrainStop(id: "S103", stationId: "23", arrivalTime: nil, departureTime: TimeHelper.date(from: "11:09")),
                TrainStop(id: "S104", stationId: "63", arrivalTime: TimeHelper.date(from: "11:15"), departureTime: TimeHelper.date(from: "11:15")),
                TrainStop(id: "S105", stationId: "64", arrivalTime: TimeHelper.date(from: "11:20"), departureTime: TimeHelper.date(from: "11:21")),
                TrainStop(id: "S106", stationId: "65", arrivalTime: TimeHelper.date(from: "11:29"), departureTime: TimeHelper.date(from: "11:29")),
                TrainStop(id: "S107", stationId: "66", arrivalTime: TimeHelper.date(from: "11:32"), departureTime: TimeHelper.date(from: "11:32")),
                TrainStop(id: "S108", stationId: "67", arrivalTime: TimeHelper.date(from: "11:35"), departureTime: TimeHelper.date(from: "11:35")),
                TrainStop(id: "S109", stationId: "68", arrivalTime: TimeHelper.date(from: "11:41"), departureTime: TimeHelper.date(from: "11:41")),
                TrainStop(id: "S110", stationId: "69", arrivalTime: TimeHelper.date(from: "11:42"), departureTime: TimeHelper.date(from: "11:44")),
                TrainStop(id: "S111", stationId: "70", arrivalTime: TimeHelper.date(from: "11:47"), departureTime: TimeHelper.date(from: "11:48")),
                TrainStop(id: "S112", stationId: "71", arrivalTime: TimeHelper.date(from: "11:50"), departureTime: TimeHelper.date(from: "11:51")),
                TrainStop(id: "S113", stationId: "72", arrivalTime: TimeHelper.date(from: "11:57"), departureTime: TimeHelper.date(from: "11:58")),
                TrainStop(id: "S114", stationId: "73", arrivalTime: TimeHelper.date(from: "12:06"), departureTime: TimeHelper.date(from: "12:07")),
                TrainStop(id: "S115", stationId: "74", arrivalTime: TimeHelper.date(from: "12:09"), departureTime: TimeHelper.date(from: "12:10")),
                TrainStop(id: "S116", stationId: "75", arrivalTime: TimeHelper.date(from: "12:15"), departureTime: TimeHelper.date(from: "12:15")),
                TrainStop(id: "S117", stationId: "76", arrivalTime: TimeHelper.date(from: "12:19"), departureTime: TimeHelper.date(from: "12:19")),
                TrainStop(id: "S118", stationId: "77", arrivalTime: TimeHelper.date(from: "12:21"), departureTime: TimeHelper.date(from: "12:22")),
                TrainStop(id: "S119", stationId: "78", arrivalTime: TimeHelper.date(from: "12:26"), departureTime: TimeHelper.date(from: "12:26")),
                TrainStop(id: "S120", stationId: "79", arrivalTime: TimeHelper.date(from: "12:34"), departureTime: TimeHelper.date(from: "12:35")),
                TrainStop(id: "S121", stationId: "80", arrivalTime: TimeHelper.date(from: "12:46"), departureTime: nil),
            ],
            trainImage: "JR205_2"
        ),
        Train(
            id: "1690",
            name: "1690",
            parentLineId: "2",
            routeVariationId: "R1",
            stops: [
                TrainStop(id: "S122", stationId: "23", arrivalTime: nil, departureTime: TimeHelper.date(from: "11:25")),
                TrainStop(id: "S123", stationId: "63", arrivalTime: TimeHelper.date(from: "11:31"), departureTime: TimeHelper.date(from: "11:31")),
                TrainStop(id: "S124", stationId: "64", arrivalTime: TimeHelper.date(from: "11:36"), departureTime: TimeHelper.date(from: "11:37")),
                TrainStop(id: "S125", stationId: "65", arrivalTime: TimeHelper.date(from: "11:45"), departureTime: TimeHelper.date(from: "11:45")),
                TrainStop(id: "S126", stationId: "66", arrivalTime: TimeHelper.date(from: "11:48"), departureTime: TimeHelper.date(from: "11:48")),
                TrainStop(id: "S127", stationId: "67", arrivalTime: TimeHelper.date(from: "11:51"), departureTime: TimeHelper.date(from: "11:51")),
                TrainStop(id: "S128", stationId: "68", arrivalTime: TimeHelper.date(from: "11:57"), departureTime: TimeHelper.date(from: "11:57")),
                TrainStop(id: "S129", stationId: "69", arrivalTime: TimeHelper.date(from: "12:00"), departureTime: TimeHelper.date(from: "12:00")),
                TrainStop(id: "S130", stationId: "70", arrivalTime: TimeHelper.date(from: "12:02"), departureTime: TimeHelper.date(from: "12:04")),
                TrainStop(id: "S131", stationId: "71", arrivalTime: TimeHelper.date(from: "12:06"), departureTime: TimeHelper.date(from: "12:07")),
                TrainStop(id: "S132", stationId: "72", arrivalTime: TimeHelper.date(from: "12:13"), departureTime: TimeHelper.date(from: "12:14")),
                TrainStop(id: "S133", stationId: "73", arrivalTime: TimeHelper.date(from: "12:23"), departureTime: TimeHelper.date(from: "12:23")),
                TrainStop(id: "S134", stationId: "74", arrivalTime: TimeHelper.date(from: "12:25"), departureTime: TimeHelper.date(from: "12:26")),
                TrainStop(id: "S135", stationId: "75", arrivalTime: TimeHelper.date(from: "12:31"), departureTime: TimeHelper.date(from: "12:31")),
                TrainStop(id: "S136", stationId: "76", arrivalTime: TimeHelper.date(from: "12:35"), departureTime: TimeHelper.date(from: "12:35")),
                TrainStop(id: "S137", stationId: "77", arrivalTime: TimeHelper.date(from: "12:38"), departureTime: TimeHelper.date(from: "12:38")),
                TrainStop(id: "S138", stationId: "78", arrivalTime: TimeHelper.date(from: "12:42"), departureTime: TimeHelper.date(from: "12:42")),
                TrainStop(id: "S139", stationId: "79", arrivalTime: TimeHelper.date(from: "12:50"), departureTime: TimeHelper.date(from: "12:51")),
                TrainStop(id: "S140", stationId: "80", arrivalTime: TimeHelper.date(from: "13:02"), departureTime: nil),
            ],
            trainImage: "JR205_2"
        ),
        
        Train(
            id: "1692",
            name: "1692",
            parentLineId: "2",
            routeVariationId: "R2",
            stops: [
                TrainStop(id: "S141", stationId: "23", arrivalTime: nil, departureTime: TimeHelper.date(from: "11:40")),
                TrainStop(id: "S142", stationId: "63", arrivalTime: TimeHelper.date(from: "11:45"), departureTime: TimeHelper.date(from: "11:46")),
                TrainStop(id: "S143", stationId: "64", arrivalTime: TimeHelper.date(from: "11:51"), departureTime: TimeHelper.date(from: "11:52")),
                TrainStop(id: "S144", stationId: "65", arrivalTime: TimeHelper.date(from: "11:59"), departureTime: TimeHelper.date(from: "12:00")),
                TrainStop(id: "S145", stationId: "66", arrivalTime: TimeHelper.date(from: "12:03"), departureTime: TimeHelper.date(from: "12:03")),
                TrainStop(id: "S146", stationId: "67", arrivalTime: TimeHelper.date(from: "12:06"), departureTime: TimeHelper.date(from: "12:06")),
                TrainStop(id: "S147", stationId: "68", arrivalTime: TimeHelper.date(from: "12:12"), departureTime: TimeHelper.date(from: "12:12")),
                TrainStop(id: "S148", stationId: "69", arrivalTime: TimeHelper.date(from: "12:13"), departureTime: TimeHelper.date(from: "12:15")),
                TrainStop(id: "S149", stationId: "70", arrivalTime: TimeHelper.date(from: "12:18"), departureTime: TimeHelper.date(from: "12:19")),
                TrainStop(id: "S150", stationId: "71", arrivalTime: TimeHelper.date(from: "12:22"), departureTime: TimeHelper.date(from: "12:22")),
                TrainStop(id: "S151", stationId: "72", arrivalTime: TimeHelper.date(from: "12:28"), departureTime: TimeHelper.date(from: "12:29"))
            ],
            trainImage: "JR205_2"
        ),
        
        Train(
            id: "1694",
            name: "1694",
            parentLineId: "2",
            routeVariationId: "R1",
            stops: [
                TrainStop(id: "S152", stationId: "23", arrivalTime: nil, departureTime: TimeHelper.date(from: "11:49")),
                TrainStop(id: "S153", stationId: "63", arrivalTime: TimeHelper.date(from: "11:55"), departureTime: TimeHelper.date(from: "11:55")),
                TrainStop(id: "S154", stationId: "64", arrivalTime: TimeHelper.date(from: "12:00"), departureTime: TimeHelper.date(from: "12:01")),
                TrainStop(id: "S155", stationId: "65", arrivalTime: TimeHelper.date(from: "12:09"), departureTime: TimeHelper.date(from: "12:09")),
                TrainStop(id: "S156", stationId: "66", arrivalTime: TimeHelper.date(from: "12:12"), departureTime: TimeHelper.date(from: "12:12")),
                TrainStop(id: "S157", stationId: "67", arrivalTime: TimeHelper.date(from: "12:15"), departureTime: TimeHelper.date(from: "12:15")),
                TrainStop(id: "S158", stationId: "68", arrivalTime: TimeHelper.date(from: "12:21"), departureTime: TimeHelper.date(from: "12:21")),
                TrainStop(id: "S159", stationId: "69", arrivalTime: TimeHelper.date(from: "12:22"), departureTime: TimeHelper.date(from: "12:24")),
                TrainStop(id: "S160", stationId: "70", arrivalTime: TimeHelper.date(from: "12:28"), departureTime: TimeHelper.date(from: "12:28")),
                TrainStop(id: "S161", stationId: "71", arrivalTime: TimeHelper.date(from: "12:31"), departureTime: TimeHelper.date(from: "12:31")),
                TrainStop(id: "S162", stationId: "72", arrivalTime: TimeHelper.date(from: "12:37"), departureTime: TimeHelper.date(from: "12:38")),
                TrainStop(id: "S163", stationId: "73", arrivalTime: TimeHelper.date(from: "12:47"), departureTime: TimeHelper.date(from: "12:47")),
                TrainStop(id: "S164", stationId: "74", arrivalTime: TimeHelper.date(from: "12:50"), departureTime: TimeHelper.date(from: "12:50")),
                TrainStop(id: "S165", stationId: "75", arrivalTime: TimeHelper.date(from: "12:55"), departureTime: TimeHelper.date(from: "12:55")),
                TrainStop(id: "S166", stationId: "76", arrivalTime: TimeHelper.date(from: "12:59"), departureTime: TimeHelper.date(from: "12:59")),
                TrainStop(id: "S167", stationId: "77", arrivalTime: TimeHelper.date(from: "13:02"), departureTime: TimeHelper.date(from: "13:02")),
                TrainStop(id: "S168", stationId: "78", arrivalTime: TimeHelper.date(from: "13:06"), departureTime: TimeHelper.date(from: "13:06")),
                TrainStop(id: "S169", stationId: "79", arrivalTime: TimeHelper.date(from: "13:15"), departureTime: TimeHelper.date(from: "13:15")),
                TrainStop(id: "S170", stationId: "80", arrivalTime: TimeHelper.date(from: "13:26"), departureTime: nil),
            ],
            trainImage: "JR205_2"
        ),
        
        Train(
            id: "1696",
            name: "1696",
            parentLineId: "2",
            routeVariationId: "R2",
            stops: [
                TrainStop(id: "S171", stationId: "23", arrivalTime: nil, departureTime: TimeHelper.date(from: "12:00")),
                TrainStop(id: "S172", stationId: "63", arrivalTime: TimeHelper.date(from: "12:06"), departureTime: TimeHelper.date(from: "12:06")),
                TrainStop(id: "S173", stationId: "64", arrivalTime: TimeHelper.date(from: "12:11"), departureTime: TimeHelper.date(from: "12:12")),
                TrainStop(id: "S174", stationId: "65", arrivalTime: TimeHelper.date(from: "12:19"), departureTime: TimeHelper.date(from: "12:20")),
                TrainStop(id: "S175", stationId: "66", arrivalTime: TimeHelper.date(from: "12:23"), departureTime: TimeHelper.date(from: "12:23")),
                TrainStop(id: "S176", stationId: "67", arrivalTime: TimeHelper.date(from: "12:25"), departureTime: TimeHelper.date(from: "12:26")),
                TrainStop(id: "S177", stationId: "68", arrivalTime: TimeHelper.date(from: "12:32"), departureTime: TimeHelper.date(from: "12:32")),
                TrainStop(id: "S178", stationId: "69", arrivalTime: TimeHelper.date(from: "12:33"), departureTime: TimeHelper.date(from: "12:35")),
                TrainStop(id: "S179", stationId: "70", arrivalTime: TimeHelper.date(from: "12:39"), departureTime: TimeHelper.date(from: "12:39")),
                TrainStop(id: "S180", stationId: "71", arrivalTime: TimeHelper.date(from: "12:42"), departureTime: TimeHelper.date(from: "12:42")),
                TrainStop(id: "S181", stationId: "72", arrivalTime: TimeHelper.date(from: "12:48"), departureTime: TimeHelper.date(from: "12:49"))
            ],
            trainImage: "JR205_2"
        ),
        
        Train(
            id: "1700",
            name: "1700",
            parentLineId: "2",
            routeVariationId: "R2",
            stops: [
                TrainStop(id: "S182", stationId: "23", arrivalTime: nil, departureTime: TimeHelper.date(from: "12:19")),
                TrainStop(id: "S183", stationId: "63", arrivalTime: TimeHelper.date(from: "12:25"), departureTime: TimeHelper.date(from: "12:25")),
                TrainStop(id: "S184", stationId: "64", arrivalTime: TimeHelper.date(from: "12:30"), departureTime: TimeHelper.date(from: "12:31")),
                TrainStop(id: "S185", stationId: "65", arrivalTime: TimeHelper.date(from: "12:39"), departureTime: TimeHelper.date(from: "12:39")),
                TrainStop(id: "S186", stationId: "66", arrivalTime: TimeHelper.date(from: "12:42"), departureTime: TimeHelper.date(from: "12:42")),
                TrainStop(id: "S187", stationId: "67", arrivalTime: TimeHelper.date(from: "12:44"), departureTime: TimeHelper.date(from: "12:45")),
                TrainStop(id: "S188", stationId: "68", arrivalTime: TimeHelper.date(from: "12:51"), departureTime: TimeHelper.date(from: "12:51")),
                TrainStop(id: "S189", stationId: "69", arrivalTime: TimeHelper.date(from: "12:52"), departureTime: TimeHelper.date(from: "12:54")),
                TrainStop(id: "S190", stationId: "70", arrivalTime: TimeHelper.date(from: "12:57"), departureTime: TimeHelper.date(from: "12:58")),
                TrainStop(id: "S191", stationId: "71", arrivalTime: TimeHelper.date(from: "13:01"), departureTime: TimeHelper.date(from: "13:01")),
                TrainStop(id: "S192", stationId: "72", arrivalTime: TimeHelper.date(from: "13:08"), departureTime: TimeHelper.date(from: "13:08"))
            ],
            trainImage: "JR205_2"
        ),
        
        Train(
            id: "1702",
            name: "1702",
            parentLineId: "2",
            routeVariationId: "R1",
            stops: [
                TrainStop(id: "S193", stationId: "23", arrivalTime: nil, departureTime: TimeHelper.date(from: "12:30")),
                TrainStop(id: "S194", stationId: "63", arrivalTime: TimeHelper.date(from: "12:35"), departureTime: TimeHelper.date(from: "12:36")),
                TrainStop(id: "S195", stationId: "64", arrivalTime: TimeHelper.date(from: "12:41"), departureTime: TimeHelper.date(from: "12:42")),
                TrainStop(id: "S196", stationId: "65", arrivalTime: TimeHelper.date(from: "12:50"), departureTime: TimeHelper.date(from: "12:50")),
                TrainStop(id: "S197", stationId: "66", arrivalTime: TimeHelper.date(from: "12:53"), departureTime: TimeHelper.date(from: "12:53")),
                TrainStop(id: "S198", stationId: "67", arrivalTime: TimeHelper.date(from: "12:55"), departureTime: TimeHelper.date(from: "12:56")),
                TrainStop(id: "S199", stationId: "68", arrivalTime: TimeHelper.date(from: "13:02"), departureTime: TimeHelper.date(from: "13:02")),
                TrainStop(id: "S200", stationId: "69", arrivalTime: TimeHelper.date(from: "13:03"), departureTime: TimeHelper.date(from: "13:05")),
                TrainStop(id: "S201", stationId: "70", arrivalTime: TimeHelper.date(from: "13:08"), departureTime: TimeHelper.date(from: "13:09")),
                TrainStop(id: "S202", stationId: "71", arrivalTime: TimeHelper.date(from: "13:12"), departureTime: TimeHelper.date(from: "13:12")),
                TrainStop(id: "S203", stationId: "72", arrivalTime: TimeHelper.date(from: "13:27"), departureTime: TimeHelper.date(from: "13:19")),
                TrainStop(id: "S204", stationId: "73", arrivalTime: TimeHelper.date(from: "13:27"), departureTime: TimeHelper.date(from: "13:28")),
                TrainStop(id: "S205", stationId: "74", arrivalTime: TimeHelper.date(from: "13:31"), departureTime: TimeHelper.date(from: "13:31")),
                TrainStop(id: "S206", stationId: "75", arrivalTime: TimeHelper.date(from: "12:35"), departureTime: TimeHelper.date(from: "13:36")),
                TrainStop(id: "S207", stationId: "76", arrivalTime: TimeHelper.date(from: "13:40"), departureTime: TimeHelper.date(from: "13:40")),
                TrainStop(id: "S208", stationId: "77", arrivalTime: TimeHelper.date(from: "13:43"), departureTime: TimeHelper.date(from: "13:43")),
                TrainStop(id: "S209", stationId: "78", arrivalTime: TimeHelper.date(from: "13:46"), departureTime: TimeHelper.date(from: "13:47")),
                TrainStop(id: "S210", stationId: "79", arrivalTime: TimeHelper.date(from: "13:56"), departureTime: TimeHelper.date(from: "13:56")),
                TrainStop(id: "S211", stationId: "80", arrivalTime: TimeHelper.date(from: "14:07"), departureTime: nil),
            ],
            trainImage: "JR205_2"
        )
    ]
    
    var trainLines: [TrainLine] = [
        TrainLine(id: "1", name: "Cikarang Line | Blue Line", color: Color("BlueLineStroke"), colorAccessible: Color("BlueLineStrokeAccessible"), stationID: ["11", "81", "12", "13", "14", "15", "16", "17", "21", "22", "23", "24", "25", "26", "27", "28", "11", "10", "9", "8", "7", "6", "5", "4", "82", "3", "2", "1"]),
        
        TrainLine(id: "2", name: "Rangkasbitung Line | Green Line", color: Color("GreenLineStroke"), colorAccessible: Color("GreenLineStrokeAccessible"), stationID: ["23", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80"]),
        
        TrainLine(id: "3", name: "Bogor Line | Red Line", color: Color("RedLineStroke"), colorAccessible: Color("RedLineStrokeAccessible"), stationID: ["20", "29", "30", "31", "32", "33", "34", "27", "35", "36", "37", "38", "83", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49"]),
        
        TrainLine(id: "4", name: "Bogor Line | Red Line, Nambo branch", color: Color("RedLineStroke"), colorAccessible: Color("RedLineStrokeAccessible"), stationID: ["46", "50", "51", "52"]),
        
        TrainLine(id: "5", name: "Tanjung Priok Line | Pink Line", color: Color("PinkLineStroke"), colorAccessible: Color("PinkLineStrokeAccessible"), stationID: ["19", "18", "17", "20"]),
        
        TrainLine(id: "6", name: "Tangerang Line | Brown Line", color: Color("BrownLineStroke"), colorAccessible: Color("BrownLineStrokeAccessible"), stationID: ["22", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62"])
        
    ]
    
    var stations: [Station] = [
        Station(id: "0", name: "Tap on a station!", x: 0.55, y: 0.6, stationType: .regular, stationCode: "", dateOpened: "", lanes: 1, stationBuiltType: .land, electrifiedYear: "2025", stationSize: .large, isHidden: true),
        Station(id: "1", name: "Cikarang", x: 0.78, y: 0.10, stationType: .regular, stationCode: "CKR", dateOpened: "1925", lanes: 8, heightMeasurement: 18, stationBuiltType: .land, electrifiedYear: "2014", stationSize: .large),
        Station(id: "2", name: "Telaga Murni", x: 0.75, y: 0.10, stationType: .regular, stationCode: "TLM", dateOpened: "May 18, 2019", lanes: 2, heightMeasurement: 18, stationBuiltType: .land, electrifiedYear: "2019", stationSize: .small),
        Station(id: "3", name: "Cibitung", x: 0.72, y: 0.10, stationType: .regular, stationCode: "CIT", dateOpened: "1990", lanes: 2, heightMeasurement: 19,  stationBuiltType: .land, electrifiedYear: "2017", stationSize: .small),
        Station(id: "82", name: "Tambun", x: 0.69, y: 0.10, stationType: .regular, stationCode: "TB", dateOpened: "1898", lanes: 4, heightMeasurement: 19, stationBuiltType: .land, electrifiedYear: "2017", stationSize: .medium),
        Station(id: "4", name: "Bekasi Timur", x: 0.66, y: 0.10, stationType: .regular, stationCode: "BKST", dateOpened: "October 7, 2017", lanes: 2, heightMeasurement: 19, stationBuiltType: .land, electrifiedYear: "2017", stationSize: .small),
        Station(id: "5", name: "Bekasi", x: 0.63, y: 0.10, stationType: .regular, stationCode: "BKS", dateOpened: "March 1887", lanes: 8, heightMeasurement: 19,  stationBuiltType: .land, electrifiedYear: "1992", stationSize: .large),
        Station(id: "6", name: "Kranji", x: 0.60, y: 0.10, stationType: .regular, stationCode: "KRI", dateOpened: "-", lanes: 4, heightMeasurement: 18, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "7", name: "Cakung", x: 0.57, y: 0.10, stationType: .regular, stationCode: "CUK", dateOpened: "-", lanes: 6, heightMeasurement: 18, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "8", name: "Klender Baru", x: 0.54, y: 0.10, stationType: .regular, stationCode: "KLDB", dateOpened: "-", lanes: 4, heightMeasurement: 11,  stationBuiltType: .land, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "9", name: "Buaran", x: 0.51, y: 0.10, stationType: .regular, stationCode: "BUA", dateOpened: "-", lanes: 4, heightMeasurement: 11, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .small),
        Station(id: "10", name: "Klender", x: 0.48, y: 0.10, stationType: .regular, stationCode: "KLD", dateOpened: "1909", lanes: 4, heightMeasurement: 10, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .small),
        Station(id: "11", name: "Jatinegara", x: 0.44, y: 0.15, stationType: .transit, stationCode: "JNG", dateOpened: "October 15, 1909", lanes: 8, heightMeasurement: 16, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .veryLarge),
        Station(id: "81", name: "Pondok Jati", x: 0.38, y: 0.15, stationType: .regular, stationCode: "POK", dateOpened: "-", lanes: 2, heightMeasurement: 14, stationBuiltType: .land,  electrifiedYear: "1987", stationSize: .small),
        Station(id: "12", name: "Kramat", x: 0.35, y: 0.15, stationType: .regular, stationCode: "KMT", dateOpened: "-", lanes: 2, heightMeasurement: 10, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .small),
        Station(id: "13", name: "Gang Sentiong", x: 0.32, y: 0.15, stationType: .regular, stationCode: "GST", dateOpened: "-", lanes: 2, heightMeasurement: 7,  stationBuiltType: .land, electrifiedYear: "1987", stationSize: .small),
        Station(id: "14", name: "Pasar Senen", x: 0.29, y: 0.15, stationType: .regular, stationCode: "PSE", dateOpened: "March 31, 1887", lanes: 6, heightMeasurement: 5, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .veryLarge),
        Station(id: "15", name: "Kemayoran", x: 0.26, y: 0.15, stationType: .regular, stationCode: "KMO", dateOpened: "1887", lanes: 2, heightMeasurement: 4, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .medium),
        Station(id: "16", name: "Rajawali", x: 0.23, y: 0.15, stationType: .regular, stationCode: "RJW", dateOpened: "-", lanes: 4, heightMeasurement: 5, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .small, platforms: [
            StationPlatforms(id: "1", platformName: "1", platformDesc: "Cikarang, Bekasi, Jatinegara"),
            StationPlatforms(id: "2", platformName: "2", platformDesc: "Kampung Bandan, Duri, Angke, Tanah Abang, Manggarai"),
        ]),
        Station(id: "17", name: "Kampung Bandan", x: 0.14, y: 0.30, stationType: .transit, stationCode: "KPB", dateOpened: "1898", lanes: 8, heightMeasurement: 3, stationBuiltType: .mixed, electrifiedYear: "1987", stationSize: .large),
        Station(id: "18", name: "Ancol", x: 0.08, y: 0.24, stationType: .regular, stationCode: "AC", dateOpened: "-", lanes: 2, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .small),
        Station(id: "19", name: "Tanjung Priok", x: 0.08, y: 0.18, stationType: .regular, stationCode: "TPK", dateOpened: "April 6, 1925", lanes: 8, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .large),
        Station(id: "20", name: "Jakarta Kota", x: 0.22, y: 0.30, stationType: .transit, stationCode: "JAKK", dateOpened: "October 8, 1925", lanes: 8, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .large),
        Station(id: "21", name: "Angke", x: 0.18, y: 0.40, stationType: .regular, stationCode: "AK", dateOpened: "January 2, 1899", lanes: 8, heightMeasurement: 3,  stationBuiltType: .land, electrifiedYear: "1987", stationSize: .medium),
        Station(id: "22", name: "Duri", x: 0.33, y: 0.40, stationType: .transit, stationCode: "DU", dateOpened: "January 2, 1899", lanes: 5, heightMeasurement: 9, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .large),
        Station(id: "23", name: "Tanah Abang", x: 0.38, y: 0.40, stationType: .transit, stationCode: "THB", dateOpened: "October 1, 1899", lanes: 6, heightMeasurement: 9, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .veryLarge, platforms: [
            StationPlatforms(id: "1", platformName: "2.3", platformDesc: "Kampung Bandan, Angke, Manggarai, Cikarang, Bekasi"),
            StationPlatforms(id: "2", platformName: "5.6", platformDesc: "Rangkasbitung, Serpong, Parung Panjang, Tigaraksa"),
        ]),
        Station(id: "24", name: "Karet", x: 0.44, y: 0.40, stationType: .regular, stationCode: "KAT", dateOpened: "August 1, 1922", lanes: 8, heightMeasurement: 11, stationBuiltType: .land, electrifiedYear: "1987", stationSize: .large),
        Station(id: "25", name: "Sudirman Baru", x: 0.44, y: 0.35, stationType: .regular, stationCode: "SUDB", dateOpened: "December 26, 2017", lanes: 2, heightMeasurement: 6, stationBuiltType: .land, electrifiedYear: "2017", stationSize: .large),
        Station(id: "26", name: "Sudirman", x: 0.44, y: 0.30, stationType: .regular, stationCode: "SUD", dateOpened: "July 5, 1986", lanes: 2, heightMeasurement: 6,  stationBuiltType: .land, electrifiedYear: "1987", stationSize: .medium),
        Station(id: "27", name: "Manggarai", x: 0.44, y: 0.24, stationType: .transit, stationCode: "MRI", dateOpened: "May 1, 1918", lanes: 12, heightMeasurement: 13,  stationBuiltType: .land, electrifiedYear: "1987", stationSize: .veryLarge),
        Station(id: "28", name: "Matraman", x: 0.44, y: 0.19, stationType: .regular, stationCode: "MTR", dateOpened: "June 19, 2022", lanes: 2, heightMeasurement: 26,  stationBuiltType: .land, electrifiedYear: "2022", stationSize: .medium),
        Station(id: "29", name: "Jayakarta", x: 0.25, y: 0.24, stationType: .regular, stationCode: "JAY", dateOpened: "1992", lanes: 2, heightMeasurement: 13, stationBuiltType: .elevated, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "30", name: "Mangga Besar", x: 0.28, y: 0.24, stationType: .regular, stationCode: "CKR", dateOpened: "1992", lanes: 2, heightMeasurement: 14, stationBuiltType: .elevated, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "31", name: "Sawah Besar", x: 0.31, y: 0.24, stationType: .regular, stationCode: "SW", dateOpened: "September 15, 1871", lanes: 2, heightMeasurement: 15, stationBuiltType: .elevated, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "32", name: "Juanda", x: 0.34, y: 0.24, stationType: .regular, stationCode: "JUA", dateOpened: "September 15, 1871", lanes: 2, heightMeasurement: 15, stationBuiltType: .elevated, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "33", name: "Gondangdia", x: 0.37, y: 0.24, stationType: .regular, stationCode: "GDD", dateOpened: "1926", lanes: 2, heightMeasurement: 17, stationBuiltType: .elevated, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "34", name: "Cikini", x: 0.40, y: 0.24, stationType: .regular, stationCode: "CKI", dateOpened: "1926", lanes: 2, heightMeasurement: 20, stationBuiltType: .elevated, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "35", name: "Tebet", x: 0.47, y: 0.24, stationType: .regular, stationCode: "TEB", dateOpened: "-", lanes: 2, heightMeasurement: 17, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "36", name: "Cawang", x: 0.50, y: 0.24, stationType: .regular, stationCode: "CW", dateOpened: "-", lanes: 2, heightMeasurement: 13, stationBuiltType: .land, electrifiedYear: "2014", stationSize: .small),
        Station(id: "37", name: "Duren Kalibata", x: 0.53, y: 0.24, stationType: .regular, stationCode: "DRN", dateOpened: "-", lanes: 2, heightMeasurement: 26,  stationBuiltType: .land, electrifiedYear: "1930", stationSize: .small),
        Station(id: "38", name: "Pasar Minggu Baru", x: 0.56, y: 0.24, stationType: .regular, stationCode: "PSMB", dateOpened: "December 2, 1996", lanes: 2, heightMeasurement: 37, stationBuiltType: .land, electrifiedYear: "1996", stationSize: .small),
        Station(id: "83", name: "Pasar Minggu", x: 0.59, y: 0.24, stationType: .regular, stationCode: "PSM", dateOpened: "January 31, 1873", lanes: 2, heightMeasurement: 36, stationBuiltType: .land, electrifiedYear: "1930", stationSize: .small),
        Station(id: "39", name: "Tanjung Barat", x: 0.62, y: 0.24, stationType: .regular, stationCode: "TNT", dateOpened: "January 31, 1873", lanes: 2, heightMeasurement: 44, stationBuiltType: .land, electrifiedYear: "1930", stationSize: .small),
        Station(id: "40", name: "Lenteng Agung", x: 0.65, y: 0.24, stationType: .regular, stationCode: "LNA", dateOpened: "January 31, 1873", lanes: 2, heightMeasurement: 57, stationBuiltType: .land, electrifiedYear: "1930", stationSize: .small),
        Station(id: "41", name: "Universitas Pancasila", x: 0.68, y: 0.24, stationType: .regular, stationCode: "UP", dateOpened: "-", lanes: 2, heightMeasurement: 57, stationBuiltType: .land, electrifiedYear: "-", stationSize: .small),
        Station(id: "42", name: "Universitas Indonesia", x: 0.72, y: 0.24, stationType: .regular, stationCode: "UI", dateOpened: "-", lanes: 2, heightMeasurement: 74, stationBuiltType: .land, electrifiedYear: "-", stationSize: .small),
        Station(id: "43", name: "Pondok Cina", x: 0.75, y: 0.24, stationType: .regular, stationCode: "POC", dateOpened: "January 31, 1873", lanes: 2, stationBuiltType: .land, electrifiedYear: "1930", stationSize: .small),
        Station(id: "44", name: "Depok Baru", x: 0.78, y: 0.24, stationType: .regular, stationCode: "DPB", dateOpened: "February 19, 1983", lanes: 3, heightMeasurement: 93, stationBuiltType: .land, electrifiedYear: "1983", stationSize: .medium),
        Station(id: "45", name: "Depok", x: 0.81, y: 0.24, stationType: .regular, stationCode: "DP", dateOpened: "January 31, 1873", lanes: 4, heightMeasurement: 93, stationBuiltType: .land, electrifiedYear: "1930", stationSize: .medium),
        Station(id: "46", name: "Citayam", x: 0.84, y: 0.24, stationType: .regular, stationCode: "CTA", dateOpened: "January 31, 1873", lanes: 2, heightMeasurement: 120, stationBuiltType: .land, electrifiedYear: "1930", stationSize: .medium),
        Station(id: "47", name: "Bojonggede", x: 0.87, y: 0.24, stationType: .regular, stationCode: "BJD", dateOpened: "January 31, 1873", lanes: 2, heightMeasurement: 140, stationBuiltType: .land, electrifiedYear: "1930", stationSize: .small),
        Station(id: "48", name: "Cilebut", x: 0.90, y: 0.24, stationType: .regular, stationCode: "CLT", dateOpened: "January 31, 1873", lanes: 2, heightMeasurement: 171, stationBuiltType: .land, electrifiedYear: "1930", stationSize: .small),
        Station(id: "49", name: "Bogor", x: 0.93, y: 0.24, stationType: .regular, stationCode: "BOO", dateOpened: "January 31, 1873", lanes: 8, heightMeasurement: 246, stationBuiltType: .land, electrifiedYear: "1930", stationSize: .large),
        Station(id: "50", name: "Pondok Rajeg", x: 0.84, y: 0.18, stationType: .regular, stationCode: "PDRG", dateOpened: "1999", lanes: 1, heightMeasurement: 121, stationBuiltType: .land, electrifiedYear: "2024", stationSize: .small),
        Station(id: "51", name: "Cibinong", x: 0.84, y: 0.12, stationType: .regular, stationCode: "CBN", dateOpened: "1999", lanes: 2, heightMeasurement: 155, stationBuiltType: .land, electrifiedYear: "2015", stationSize: .small),
        Station(id: "52", name: "Nambo", x: 0.87, y: 0.12, stationType: .regular, stationCode: "NMO", dateOpened: "1999", lanes: 8, heightMeasurement: 220, stationBuiltType: .land, electrifiedYear: "2015", stationSize: .large),
        Station(id: "53", name: "Grogol", x: 0.33, y: 0.45, stationType: .regular, stationCode: "GRG", dateOpened: "-", lanes: 2, heightMeasurement: 4, stationBuiltType: .land, electrifiedYear: "2015", stationSize: .small),
        Station(id: "54", name: "Pesing", x: 0.33, y: 0.50, stationType: .regular, stationCode: "PSG", dateOpened: "-", lanes: 2, heightMeasurement: 5, stationBuiltType: .land, electrifiedYear: "1997", stationSize: .small),
        Station(id: "55", name: "Taman Kota", x: 0.30, y: 0.50, stationType: .regular, stationCode: "TKO", dateOpened: "June 16, 2015", lanes: 2, heightMeasurement: 12, stationBuiltType: .land, electrifiedYear: "2015", stationSize: .small),
        Station(id: "56", name: "Bojong Indah", x: 0.27, y: 0.50, stationType: .regular, stationCode: "BOI", dateOpened: "-", lanes: 2, heightMeasurement: 6, stationBuiltType: .land, electrifiedYear: "1997", stationSize: .small),
        Station(id: "57", name: "Rawa Buaya", x: 0.24, y: 0.50, stationType: .regular, stationCode: "RW", dateOpened: "1899", lanes: 3, heightMeasurement: 6, stationBuiltType: .land, electrifiedYear: "1997", stationSize: .small),
        Station(id: "58", name: "Kalideres", x: 0.21, y: 0.50, stationType: .regular, stationCode: "KDS", dateOpened: "-", lanes: 2, heightMeasurement: 7, stationBuiltType: .land, electrifiedYear: "1997", stationSize: .small),
        Station(id: "59", name: "Poris", x: 0.18, y: 0.50, stationType: .regular, stationCode: "PI", dateOpened: "-", lanes: 2, stationBuiltType: .land, electrifiedYear: "1997", stationSize: .small),
        Station(id: "60", name: "Batuceper", x: 0.15, y: 0.50, stationType: .regular, stationCode: "BPR", dateOpened: "-", lanes: 4, heightMeasurement: 11, stationBuiltType: .land, electrifiedYear: "1997", stationSize: .large),
        Station(id: "61", name: "Tanah Tinggi", x: 0.12, y: 0.50, stationType: .regular, stationCode: "TTI", dateOpened: "-", lanes: 2, heightMeasurement: 11, stationBuiltType: .land, electrifiedYear: "1997", stationSize: .small),
        Station(id: "62", name: "Tangerang", x: 0.09, y: 0.50, stationType: .regular, stationCode: "TNG", dateOpened: "1899", lanes: 4, heightMeasurement: 15, stationBuiltType: .land, electrifiedYear: "1997", stationSize: .medium),
        Station(id: "63", name: "Palmerah", x: 0.38, y: 0.45, stationType: .regular, stationCode: "PLM", dateOpened: "October 1, 1899", lanes: 2, heightMeasurement: 13, stationBuiltType: .land, electrifiedYear: "1993", stationSize: .large),
        Station(id: "64", name: "Kebayoran", x: 0.38, y: 0.50, stationType: .regular, stationCode: "KBY", dateOpened: "October 1, 1899", lanes: 3, heightMeasurement: 4, stationBuiltType: .land, electrifiedYear: "1993", stationSize: .large),
        Station(id: "65", name: "Pondok Ranji", x: 0.41, y: 0.50, stationType: .regular, stationCode: "PDJ", dateOpened: "1990", lanes: 2, heightMeasurement: 12, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .large),
        Station(id: "66", name: "Jurangmangu", x: 0.44, y: 0.50, stationType: .regular, stationCode: "JMU", dateOpened: "October 1, 1899", lanes: 2, heightMeasurement: 25, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "67", name: "Sudimara", x: 0.47, y: 0.50, stationType: .regular, stationCode: "SDM", dateOpened: "October 1, 1899", lanes: 3, heightMeasurement: 40, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "68", name: "Rawa Buntu", x: 0.50, y: 0.50, stationType: .regular, stationCode: "RU", dateOpened: "1911", lanes: 2, heightMeasurement: 40, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .medium),
        Station(id: "69", name: "Serpong", x: 0.53, y: 0.50, stationType: .regular, stationCode: "SRP", dateOpened: "October 1, 1899", lanes: 4, heightMeasurement: 46, stationBuiltType: .land, electrifiedYear: "1992", stationSize: .large),
        Station(id: "70", name: "Cisauk", x: 0.56, y: 0.50, stationType: .regular, stationCode: "CSK", dateOpened: "1901", lanes: 2, heightMeasurement: 48, stationBuiltType: .land, electrifiedYear: "2009", stationSize: .large),
        Station(id: "71", name: "Cicayur", x: 0.59, y: 0.50, stationType: .regular, stationCode: "CC", dateOpened: "-", lanes: 2, heightMeasurement: 47, stationBuiltType: .land, electrifiedYear: "2009", stationSize: .small),
        Station(id: "72", name: "Parung Panjang", x: 0.62, y: 0.50, stationType: .regular, stationCode: "PRP", dateOpened: "October 1, 1899", lanes: 4, heightMeasurement: 54, stationBuiltType: .land, electrifiedYear: "2009", stationSize: .large),
        Station(id: "73", name: "Cilejit", x: 0.65, y: 0.50, stationType: .regular, stationCode: "CJT", dateOpened: "1906", lanes: 2, heightMeasurement: 53, stationBuiltType: .land, electrifiedYear: "2012", stationSize: .small),
        Station(id: "74", name: "Daru", x: 0.68, y: 0.50, stationType: .regular, stationCode: "DAR", dateOpened: "-", lanes: 2, heightMeasurement: 50, stationBuiltType: .land, electrifiedYear: "2012", stationSize: .small),
        Station(id: "75", name: "Tenjo", x: 0.71, y: 0.50, stationType: .regular, stationCode: "TEJ", dateOpened: "1925", lanes: 2, heightMeasurement: 52, stationBuiltType: .land, electrifiedYear: "2012", stationSize: .small),
        Station(id: "76", name: "Tigaraksa", x: 0.74, y: 0.50, stationType: .regular, stationCode: "TGS", dateOpened: "July 1996", lanes: 4, heightMeasurement: 50, stationBuiltType: .land, electrifiedYear: "2012", stationSize: .large),
        Station(id: "77", name: "Cikoya", x: 0.77, y: 0.50, stationType: .regular, stationCode: "CKY", dateOpened: "-", lanes: 2, heightMeasurement: 53, stationBuiltType: .land, electrifiedYear: "2012", stationSize: .small),
        Station(id: "78", name: "Maja", x: 0.80, y: 0.50, stationType: .regular, stationCode: "MJ", dateOpened: "October 1, 1899", lanes: 3, heightMeasurement: 40, stationBuiltType: .land, electrifiedYear: "2012", stationSize: .large),
        Station(id: "79", name: "Citeras", x: 0.83, y: 0.50, stationType: .regular, stationCode: "CTR", dateOpened: "-", lanes: 3, heightMeasurement: 48, stationBuiltType: .land, electrifiedYear: "2017", stationSize: .medium),
        Station(id: "80", name: "Rangkasbitung", x: 0.86, y: 0.50, stationType: .regular, stationCode: "RK", dateOpened: "1925", lanes: 8, heightMeasurement: 22, stationBuiltType: .land, electrifiedYear: "2017", stationSize: .veryLarge)
    ]

    
    func initializePlayerJourney(for trainArrival: TrainSettings, modelContext: ModelContext) {
        dataManager.deleteOldJourney()
        
        let journeyPath = ["16", "17", "21", "22", "23", "63", "64", "65", "66", "67", "68", "69", "70"]
        
        let journey = PlayerJourney(stationJourney: journeyPath, lapsedStations: [], allStations: stations, allTrains: trains, arrivalTime: trainArrival)
        
        dataManager.insertNewJourney(journey)
        updateCurrentTrain(playerJourney: journey)
        
        let journeyID = journey.id
        let fetchDescriptor = FetchDescriptor<PlayerJourney>(predicate: #Predicate {
            $0.id == journeyID
        })

        if let storedJourney = try? modelContext.fetch(fetchDescriptor).first {
            playerJourney = storedJourney
        } else {
            print("Stored journey not found!")
        }
    }
    
    func getLatestJourney(modelContext: ModelContext) -> PlayerJourney? {
        if playerJourney == nil {
            playerJourney = fetchJourneyFromModelContext(modelContext)
        }
        return playerJourney
    }
    
    private func fetchJourneyFromModelContext(_ modelContext: ModelContext) -> PlayerJourney? {
        let journeys = try? modelContext.fetch(FetchDescriptor<PlayerJourney>())
        return journeys?.first
    }
    
    func getAllJourneys(modelContext: ModelContext) -> [PlayerJourney] {
        let journeys = try? modelContext.fetch(FetchDescriptor<PlayerJourney>())
        return journeys ?? []
    }
    
    func updateCurrentTrain(playerJourney: PlayerJourney) {
        guard let stationId = playerJourney.currentStation?.id else {
            print("Station ID not found!")
            return
        }
        
        let playerArrivalTime = playerJourney.arrivalTime.time
        let utcTime = TimeZone(identifier: "UTC")!
        
        let matchingTrains = trains.filter { train in
            train.stops.contains(where: { $0.stationId == stationId })
        }
        
        var closestTrain: Train?
        var minTimeDifference: TimeInterval = .infinity
        
        for train in matchingTrains {
            for stop in train.stops {
                guard let stopTime = stop.arrivalTime else { continue }
                
                let stopComponents = Calendar.current.dateComponents(in: utcTime, from: stopTime)
                let arrivalComponents = Calendar.current.dateComponents(in: utcTime, from: playerArrivalTime)
                
                if stopComponents.minute == arrivalComponents.minute {
                    playerJourney.currentTrain = train
                    dataManager.saveChanges()
                    return
                }
                
                let timeDifference = abs(stopTime.timeIntervalSince(playerArrivalTime))
                if timeDifference < minTimeDifference {
                    minTimeDifference = timeDifference
                    closestTrain = train
                }
            }
        }
        
        if var closestTrain {
            switch playerJourney.arrivalTime {
            case .train1035:
                closestTrain = trains[0]
            case .train1109:
                closestTrain = trains[1]
            case .train1134:
                closestTrain = trains[2]
            case .nonselected:
                closestTrain = trains[0]
            }
            print("No exact match train found. Assigning closest train: \(closestTrain.name)")
        } else {
            print("Keeping default train")
        }
        
        dataManager.saveChanges()
    }

    func availableTrainsAtTransitStation(playerJourney: PlayerJourney) -> [Train] {
        guard let stationId = playerJourney.currentStation?.id else { return [] }
        
        return trains.filter { train in
            train.id != playerJourney.currentTrain?.id && train.stops.contains { $0.stationId == stationId }
        }
    }
    
    func transitToNewTrain(selectedTrain: Train, playerJourney: PlayerJourney) {
        guard availableTrainsAtTransitStation(playerJourney: playerJourney).contains(where: { $0.id == selectedTrain.id }) else { return }

        playerJourney.currentTrain = selectedTrain
        
        dataManager.saveChanges()
    }
    
    func moveStations(playerJourney: PlayerJourney) {
        let preTransitStations: Set<String> = ["17", "21", "22"]
        let transitStation = "23"
        let postTransitStations: Set<String> = ["63", "64", "65", "66", "67", "68", "69"]
        let exitStation = "70"
        
        if playerJourney.lapsedStations?.isEmpty == true {
            handlePreTransitLogic(playerJourney, preTransitStations, transitStation)
        } else if preTransitStations.contains(playerJourney.currentStation?.id ?? "") {
            handleTransitLogic(playerJourney, transitStation)
        } else if playerJourney.currentStation?.id == transitStation && playerJourney.hasMoved == false {
            playerJourney.hasMoved = true
            playerJourney.shouldTriggerTransitEvent = false
            handlePostTransitLogic(playerJourney, postTransitStations, exitStation)
        } else if postTransitStations.contains(playerJourney.currentStation?.id ?? "") {
            handleEndGameLogic(playerJourney, exitStation)
        }

        dataManager.saveChanges()
    }
    
    private func handlePreTransitLogic(_ playerJourney: PlayerJourney, _ preTransitStations: Set<String>, _ transitStation: String) {
        guard let stationJourney = playerJourney.stationJourney else { return }
        
        let transitIndex = stationJourney.firstIndex(of: transitStation) ?? (stationJourney.count - 1)
        let maxSteps = max(1, transitIndex - playerJourney.currentStationIndex - 1)
        let randomSteps = Int.random(in: 1...max(1, maxSteps))
        
        let newIndex = min(playerJourney.currentStationIndex + randomSteps, transitIndex - 1)
        
        for index in (playerJourney.currentStationIndex..<newIndex) {
            let stationId = playerJourney.stationJourney?[index] ?? "16"
            if !(playerJourney.lapsedStations?.contains(stationId) ?? false) {
                playerJourney.lapsedStations?.append(stationId)
            }
        }
        playerJourney.currentStationIndex = newIndex
        
        if let nextStep = playerJourney.currentTrain?.stops.first(where: { $0.stationId == playerJourney.currentStation?.id }),
           let arrivalTime = nextStep.arrivalTime {
            TimeHelper.shared.jumpToTime(targetTime: arrivalTime, rangeInSeconds: 600)
        }
           
    }
    
    private func handleTransitLogic(_ playerJourney: PlayerJourney, _ transitStation: String) {

        guard let stationJourney = playerJourney.stationJourney,
              let transitIndex = stationJourney.firstIndex(of: transitStation) else {
            print("Transit station (station 23) not found in the journey!")
            return
        }
        let previousIndex = playerJourney.currentStationIndex
        guard previousIndex < transitIndex else {
            print("previousIndex is already at /past transitIndex")
            return
        }
        
        for index in previousIndex..<transitIndex {
            let stationId = stationJourney[index]
            if !(playerJourney.lapsedStations?.contains(stationId) ?? false) {
                playerJourney.lapsedStations?.append(stationId)
            }
        }
        playerJourney.currentStationIndex = transitIndex
        playerJourney.lapsedStations?.append(transitStation)
        
        playerJourney.shouldTriggerTransitEvent = true
        
        if let nextStep = playerJourney.currentTrain?.stops.first(where: { $0.stationId == playerJourney.currentStation?.id }),
           let arrivalTime = nextStep.arrivalTime {
            TimeHelper.shared.jumpToTime(targetTime: arrivalTime, rangeInSeconds: 600)
        }
    }
    
    private func handlePostTransitLogic(_ playerJourney: PlayerJourney, _ postTransitStations: Set<String>, _ endStation: String) {
        guard let stationJourney = playerJourney.stationJourney else { return }
        
        let endIndex = stationJourney.firstIndex(of: endStation) ?? (stationJourney.count - 1)
        let maxSteps = max(1, endIndex - playerJourney.currentStationIndex - 1)
        let randomSteps = Int.random(in: 1...max(1, maxSteps))
        
        let newIndex = min(playerJourney.currentStationIndex + randomSteps, endIndex - 1)
        
        for index in (playerJourney.currentStationIndex..<newIndex) {
            let stationId = playerJourney.stationJourney?[index] ?? "23"
            if !(playerJourney.lapsedStations?.contains(stationId) ?? false) {
                playerJourney.lapsedStations?.append(stationId)
            }
        }
        playerJourney.currentStationIndex = newIndex
        
        if let nextStep = playerJourney.currentTrain?.stops.first(where: { $0.stationId == playerJourney.currentStation?.id }),
           let arrivalTime = nextStep.arrivalTime {
            TimeHelper.shared.jumpToTime(targetTime: arrivalTime, rangeInSeconds: 300)
        }
    }
    
    private func handleEndGameLogic(_ playerJourney: PlayerJourney, _ endStation: String) {
        guard let stationJourney = playerJourney.stationJourney else {
            print("Journey not found for post-transit logic!")
            return
        }
        
        guard let endIndex = stationJourney.firstIndex(of: endStation) else {
            print("Station 70 not found on journey!")
            return
        }
        
        let previousIndex = playerJourney.currentStationIndex
        
        for index in previousIndex..<endIndex {
            let stationId = stationJourney[index]
            if !(playerJourney.lapsedStations?.contains(stationId) ?? false) {
                playerJourney.lapsedStations?.append(stationId)
            }
        }
        playerJourney.currentStationIndex = endIndex
        playerJourney.lapsedStations?.append(endStation)
        playerJourney.shouldTriggerEndEvent = true
    }
    
    func resetPlayerJourney() {
        playerJourney?.currentStationIndex = 0
        
        playerJourney?.hasMoved = false
        playerJourney?.shouldTriggerTransitEvent = false
        playerJourney?.shouldTriggerEndEvent = false
        
        playerJourney?.stationJourney = []
        playerJourney?.lapsedStations = []
        
        playerJourney?.currentMoney = (Int.random(in: 10...999) * 1000)
        playerJourney?.smilePoint = 0
        playerJourney?.currentAdvImage = nil
        playerJourney?.currentBackgroundColorHex = nil
    }
    
    func handleTransitStationEvent(_ station: Station?, onNavigate: @escaping (InteractiveViewMode) -> Void) {
        playerJourney?.currentAdvImage = "asset_station_manggarai"
        
        onNavigate(.platformSelect)
    }
    
    func handleExitEvent(_ station: Station?, onNavigate: @escaping (InteractiveViewMode) -> Void) {

        onNavigate(.paymentTapOut)
    }
    
    func payTicket() {
        guard playerJourney?.currentMoney ?? 10000 >= 5000 else { return }
        
        playerJourney?.currentMoney -= 5000
        dataManager.saveChanges()
    }
    
    func addSmilePoint() {
        playerJourney?.smilePoint += 1
        dataManager.saveChanges()
    }
    
    func reduceSmilePointApathy() {
        guard playerJourney?.smilePoint ?? 0 >= 0 else {
            return
        }
        
        playerJourney?.smilePoint -= 1
        dataManager.saveChanges()
    }
    
}
