import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    let realm: Realm

    private init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 { }
            }
        )

        Realm.Configuration.defaultConfiguration = config

        do {
            realm = try Realm()
            initializeDefaultCategories()
        } catch {
            fatalError("Error initializing Realm: \(error.localizedDescription)") // 실패 시 앱 크래시
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
}
