import SwiftUI
import SwiftData

struct SplashScreenView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    
    @EnvironmentObject var fontManager: FontManager
    @State private var navigationPath = NavigationPath()
    @State private var shouldNavigate = false
    
    @EnvironmentObject var advViewModel: ADVStoryViewModel
    @EnvironmentObject var trainViewModel: TrainViewModel
    @EnvironmentObject var messageViewModel: MessageViewModel
    
    @EnvironmentObject private var dataManager: SwiftDataManager
    
    @StateObject private var audioManager = AudioManager.helper
    @AppStorage("musicEnabled") private var isMusicEnabled: Bool = true
    @AppStorage("sfxEnabled") private var isSfxEnabled: Bool = true
    @AppStorage("colorblindModeEnabled") private var isColorblindModeEnabled = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            GeometryReader { geo in
                VStack {
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Image(systemName: "rectangle.portrait.rotate")
                                .resizable()
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.12)
                            .minimumScaleFactor(0.5)
                            .accessibilityHidden(true)
                            
                            Text("The best way to use the app is by using landscape, right?")
                                .font(.custom("SpaceGrotesk-Medium", size: geo.size.width * 0.024))
                            .minimumScaleFactor(0.5)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, geo.size.width * 0.032)
                        .padding(.top, geo.size.width * 0.016)
                        .accessibilityLabel("Use landscape for best experience")
                    }
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                        Image("Loopliner logo dark")
                            .resizable()
                            .frame(width: geo.size.width * 0.384, height: geo.size.height * 0.100)
                            .minimumScaleFactor(0.5)
                            .padding()
                            .accessibilityLabel("Loopliner")
                            
                            Text("Feel, hear, & learn your public transportation")
                                .font(.custom("SpaceGrotesk-Medium", size: geo.size.width * 0.032))
                                .minimumScaleFactor(0.5)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, geo.size.width * 0.032)
                        .padding(.bottom, geo.size.width * 0.016)
                        
                        Spacer()
                    }
                }
                .foregroundStyle(Color.black)
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Color("MainColor"))
                .onAppear {
                    audioManager.configureAudioMix()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            shouldNavigate = true
                        }
                    }
                }
                .onChange(of: shouldNavigate) { oldValue, newValue in
                    if newValue {
                        navigationPath.append(NavigationDestination.menuView)
                    }
                }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .menuView:
                    MenuView()
                    
                case .settingsView:
                    SettingsView()
                }
            }
            .navigationBarBackButtonHidden(true)
            
        }
    }
}


