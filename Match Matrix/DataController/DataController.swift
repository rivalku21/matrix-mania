//
//  DataController.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 25/04/23.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container: NSPersistentContainer
    @Published var items: [Matrix] = []
    @Published var profile: [Profile] = []
    
    init() {
        container = NSPersistentContainer(name: "MatrixData")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load store: \(error.localizedDescription)")
            } else {
                let context = self.container.viewContext

                let entity = NSEntityDescription.entity(forEntityName: "Profile", in: context)!
                let data = NSManagedObject(entity: entity, insertInto: context)
                data.setValue(3, forKey: "hint")

                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
                self.fetchData()
            }
        }
    }
    
    private func fetchData() {
        let request: NSFetchRequest<Matrix> = Matrix.fetchRequest()
        let request2: NSFetchRequest<Profile> = Profile.fetchRequest()
        do {
            items = try container.viewContext.fetch(request)
            profile = try container.viewContext.fetch(request2)
        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
        }
    }
    
    func addItem(difficulty: Difficulty, timeElapsed: TimeInterval, matrix: [Int], star: Int) {
        let matrixData = Matrix(context: container.viewContext)
        matrixData.identifier = UUID().uuidString
        switch difficulty {
        case .easy:
            matrixData.difficulty = Int16(1)
        case .medium:
            matrixData.difficulty = Int16(2)
        case .hard:
            matrixData.difficulty = Int16(3)
        }
        matrixData.duration = String(timeElapsed.formattedMilliseconds())
        matrixData.matrix = matrix as NSObject
        matrixData.star = Int16(star)
        
        saveContext()
    }

    func getObjectByID(stringId: String) -> Matrix? {
        let idObject: NSManagedObjectID? = objectIDFromString(stringId) ?? nil
        
        do {
            let results = try container.viewContext.existingObject(with: idObject!)
            return results as? Matrix
        } catch {
            print("Error fetching item by ID: \(error)")
        }

        return nil
    }
    
    private func saveContext() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    func addHint(hintAdd: Int) {
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do {
            let result = try context.fetch(request) as! [Profile]
            if let firstData = result.first {
                let hintData = firstData.hint!.intValue + hintAdd
                
                firstData.hint = NSNumber(value: hintData)
                
                try context.save()
                fetchData()
            }
        } catch let error as NSError {
            print("Could not fetch data. \(error), \(error.userInfo)")
        }
        
    }
    
    func stringFromObjectID(_ objectID: NSManagedObjectID) -> String? {
        let url = objectID.uriRepresentation()
        return url.absoluteString
    }
    
    func objectIDFromString(_ string: String) -> NSManagedObjectID? {
        guard let url = URL(string: string) else {
            return nil
        }
        
        if let managedObjectID = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url) {
            return managedObjectID
        }
        
        return nil
    }
    
    func deleteAllData() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Matrix.fetchRequest()
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save() // Save the changes
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
            // Handle the error
        }



    }

}
