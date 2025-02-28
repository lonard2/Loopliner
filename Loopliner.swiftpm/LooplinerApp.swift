import SwiftUI
import SwiftData

@main
struct LooplinerApp: App {
    @StateObject private var fontManager = FontManager()
    @StateObject private var advViewModel: ADVStoryViewModel
    @StateObject private var trainViewModel: TrainViewModel
    @StateObject private var messageViewModel: MessageViewModel
    
    @StateObject private var swiftDataManager: SwiftDataManager
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    private let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: PlayerJourney.self,
                                                Station.self,
                                                StationPlatforms.self,
                                                Train.self,
                                                TrainStop.self,
                                                TrainLine.self,
                                                RouteVariation.self,
                                                Characters.self,
                                                Storyline.self,
                                                Choice.self,
                                                BigChoice.self,
                                                FlipClockTime.self,
                                                Message.self,
                                                Outcome.self,
                                                Time.self
                        )
            let modelContext = modelContainer.mainContext
            let dataManager = SwiftDataManager(modelContext: modelContext)
            _swiftDataManager = StateObject(wrappedValue: dataManager)
            
            _advViewModel = StateObject(wrappedValue: ADVStoryViewModel(dataManager: dataManager))
            _trainViewModel = StateObject(wrappedValue: TrainViewModel(dataManager: dataManager, advViewModel: ADVStoryViewModel(dataManager: dataManager)))
            _messageViewModel = StateObject(wrappedValue: MessageViewModel(dataManager: dataManager))
        } catch {
            fatalError("Failed to initialize ModelContainer, due to: \(error.localizedDescription)")
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(fontManager)
                .environmentObject(swiftDataManager)
                .environmentObject(advViewModel)
                .environmentObject(trainViewModel)
                .environmentObject(messageViewModel)
                .modelContainer(modelContainer)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .landscape
    }
}
