//
//  CoreDataManager.swift
//  tg
//
//  Created by Apple on 6.02.22.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let dataManager = CoreDataManager()
    
    private init() {}
    
    private func getContext() -> NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    private func saveContext(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
    
    private func receiveDataInternal(id: Int?) -> ([GamesCollection]?, NSManagedObjectContext) {
        let context = getContext()
        let fetchRequest: NSFetchRequest<GamesCollection> = GamesCollection.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        if let realId = id {
            fetchRequest.predicate = NSPredicate(format: "id = \(realId)")
        }
        var data: [GamesCollection]?
        do {
            data = try context.fetch(fetchRequest)
        } catch {
            print("error")
        }
        return (data, context)
    }
    
    func receiveData() -> [GamesCollection]? {
        return receiveDataInternal(id: nil).0
    }
    
    func receiveItem(_ id: Int) -> GamesCollection? {
        guard let data = receiveDataInternal(id: id).0 else { return nil }
        if data != [] {
            return data[0]
        } else {
            return nil
        }
    }
    
    func saveItem(id: Int, name: String?, image: UIImage?) {
        let context = getContext()
        let object = GamesCollection(context: context)
        object.id = Int64(id)
        object.name = name
        object.image = image?.pngData()
        saveContext(context: context)
    }
    
    func deleteItem(id: Int) {
        let dataContext = receiveDataInternal(id: id)
        guard let data = dataContext.0 else { return }
        if data != [] {
            let object = data[0]
            let context = dataContext.1
            context.delete(object)
            saveContext(context: context)
        }
    }
}
