//
//  FavContainer.swift
//  GameList
//
//  Created by Taufiq Qurohman on 04/02/24.
//
import CoreData
import UIKit

class FavProvider{
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameFavouriteData")
        container.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Error on: \(error?.localizedDescription ?? "Undefined")")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return taskContext
    }
    
    func getAllFavGame(completion: @escaping(_ game:[FavModel]) -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games:[FavModel] = []
                for result in results {
                    let game = FavModel(id: result.value(forKey: "id") as? Int32,
                                        background_image: result.value(forKey: "background_image") as? URL,
                                        name: result.value(forKey: "name") as? String,
                                        rating: result.value(forKey: "rating") as? Double,
                                        released: result.value(forKey: "released") as? Date)
                    
                    games.append(game)
                }
                completion(games)
            } catch let error as NSError{
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getFavGame(_ id: Int, completion: @escaping(_ game: FavModel) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first  {
                    let game = FavModel(id: result.value(forKey: "id") as? Int32,
                                        background_image: result.value(forKey: "background_image") as? URL,
                                        name: result.value(forKey: "name") as? String,
                                        rating: result.value(forKey: "rating") as? Double,
                                        released: result.value(forKey: "released") as? Date)
     
                    completion(game)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func isFavourite(_ id: Int, completion: @escaping(_ isFavourite:Bool) -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
            fetchReq.fetchLimit = 1
            fetchReq.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let _ = try taskContext.fetch(fetchReq).first{
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func saveGameToFav(_ id: Int,
                       _ name: String,
                       _ released: Date,
                       _ rating: Double,
                       _ background_image: URL,
                       completion: @escaping() -> ()) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favourite", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(id, forKey: "id")
                game.setValue(name, forKey: "name")
                game.setValue(released, forKey: "released")
                game.setValue(rating, forKey: "rating")
                game.setValue(background_image, forKey: "background_image")
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Couldn't save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func deleteFavGame(_ id: Int, completion: @escaping() -> ()){
            let taskContext = newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount
                if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult, batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    
    func isFavEmpty() -> Bool{
        let taskContext = newTaskContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
        do {
            let count = try taskContext.count(for: fetchRequest)
            return count == 0
        } catch{
            return true
        }
    }
    
}
