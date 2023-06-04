//
//  ProfileController.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 28/04/23.
//

import CoreData
import Foundation

class ProfileController: ObservableObject {
    let container: NSPersistentContainer
    @Published var profile: [Profile] = []
    
    init() {
        container = NSPersistentContainer(name: "MatrixData")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load store: \(error.localizedDescription)")
            } else {
                self.fetchData()
            }
        }
    }
    
    private func fetchData() {
        let request: NSFetchRequest<Profile> = Profile.fetchRequest()
        do {
            profile = try container.viewContext.fetch(request)
        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
        }
    }
}
