//
//  LocalDataProvider.swift
//  GameList
//
//  Created by Taufiq Qurohman on 24/09/24.
//

import CoreData

class LocalDataProvider{
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LocalGameData")
        container.loadPersistentStores{ storeDescription, error in
            guard error == nil else {
                fatalError("Error on: \(error?.localizedDescription ?? "Undefined")")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container .viewContext.undoManager = nil
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return taskContext
    }
    
    func getDataInLocalDataProvider(completion: @escaping(_  gameData:[GameModel]) -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "LocalData")
            do {
                let results = try taskContext.fetch(fetchReq)
                var gameData:[GameModel] = []
                for result in results {
                    let game = GameModel(id: result.value(forKey: "id") as? Int32,
                                         name: result.value(forKey: "name") as? String,
                                         released: result.value(forKey: "released") as?  Date,
                                         rating: result.value(forKey: "rating") as? Double,
                                         background_image: result.value(forKey: "bg_image") as? URL)
                    gameData.append(game)
                }
                completion(gameData)
            } catch let error as NSError{
                print("Could not fetcth. \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveGameDataToLocal(_ id: Int,
                       _ name: String,
                       _ released: Date,
                       _ rating: Double,
                       _ background_image: URL,
                       completion: @escaping() -> ()) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "LocalData", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(id, forKey: "id")
                game.setValue(name, forKey: "name")
                game.setValue(released, forKey: "released")
                game.setValue(rating, forKey: "rating")
                game.setValue(background_image, forKey: "bg_image")
                
                do {
                    try taskContext.save()
                    print(">>>> data: \(game)")
                    completion()
                } catch let error as NSError {
                    print("Couldn't save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func isDataEmpty() -> Bool{
        let taskContext = newTaskContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LocalData")
        do {
            let count = try taskContext.count(for: fetchRequest)
            return count == 0
        } catch {
            return true
        }
    }
    
}
