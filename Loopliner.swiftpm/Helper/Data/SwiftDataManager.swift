//
//  SwiftDataManager.swift
//  Loopliner
//
//  Created by Lonard Steven on 07/02/25.
//

import SwiftUI
import SwiftData

class SwiftDataManager: ObservableObject {
    @Published var playerJourney : PlayerJourney?
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchJourney()
    }
    
    func fetchLatestJourney() -> PlayerJourney? {
        let request = FetchDescriptor<PlayerJourney>()
        return try? modelContext.fetch(request).first
    }
    
    func fetchJourney() {
        let request = FetchDescriptor<PlayerJourney>()
        if let journey = try? modelContext.fetch(request).first {
            DispatchQueue.main.async {
                self.playerJourney = journey
            }
        } else {
            print("No player journey found in fetchJourney")
        }
    }

    func insertNewJourney(_ journey: PlayerJourney) {
        
        if fetchLatestPlayerJourney() == nil {
            modelContext.insert(journey)
            do {
                try modelContext.save()
            } catch {
                fatalError("FATAL ERROR on inserting new journey, due to: \(error.localizedDescription)")
            }
        } else {
            return
        }

    }
    
    func deleteOldJourney() {
        
        let request = FetchDescriptor<PlayerJourney>()
        do {
            let oldJourneys = try modelContext.fetch(request)
            for oldJourney in oldJourneys {
                modelContext.delete(oldJourney)
            }
            try modelContext.save()
        } catch {
            fatalError("FATAL ERROR on deleting old journey, due to: \(error.localizedDescription)")
        }
    }
    
    func saveChanges() {
        try? modelContext.save()
    }
    
    func fetchLatestPlayerJourney() -> PlayerJourney? {
        let fetchDescriptor = FetchDescriptor<PlayerJourney>()
        if let fetchedJourney = try? modelContext.fetch(fetchDescriptor).first {
            DispatchQueue.main.async {
                self.playerJourney = fetchedJourney
            }
            return fetchedJourney
        } else {
            return nil
        }
    }
    
}
