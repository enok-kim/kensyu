import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in if oldSchemaVersion < 1 {} }
        )
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            
            let realm = try Realm()
            let defaultCategories = ["背中()", "胸(Chest)", "肩＆腕(Sholder&Arm)", "脚(Legs)"]
            
            for categoryName in defaultCategories {
                let existingCategory = realm.objects(WorkoutCategory.self).filter("name = %@", categoryName).first
                if existingCategory == nil {
                    
                    let category = WorkoutCategory()
                    category.name = categoryName
                    
                    try realm.write {
                        realm.add(category)
                        
                    }
                }
            }
            
        } catch {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
        
        return true
        
    }// Did Finish

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}
