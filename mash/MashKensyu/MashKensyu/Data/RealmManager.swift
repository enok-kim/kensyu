import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    let realm: Realm

    private init() {
        
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 3 {
                    
                    migrateObjectIdToString(migration: migration, ofType: Workout.className())
                    migrateObjectIdToString(migration: migration, ofType: WorkoutCategory.className())
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config

        do {
            realm = try Realm()
            initializeDefaultCategories()
        } catch {
            fatalError("Error initializing Realm: \(error.localizedDescription)")
        }
        
        // objectId -> String
        func migrateObjectIdToString(migration: Migration, ofType type: String) {
              migration.enumerateObjects(ofType: type) { oldObject, newObject in
                  if let oldId = oldObject?["id"] as? ObjectId {
                      newObject?["id"] = oldId.stringValue
                  }
              }
          }
    }

    private func initializeDefaultCategories() {
        
        let defaultCategories = ["背中(Back)", "胸(Chest)", "肩＆腕(Sholder&Arm)", "脚(Legs)"]
        
        try? realm.write {
            for categoryName in defaultCategories {
                if realm.objects(WorkoutCategory.self).filter("name = %@", categoryName).isEmpty {
                    let category = WorkoutCategory()
                    category.name = categoryName
                    realm.add(category)
                }
            }
        }
    }
    
}// end of class
