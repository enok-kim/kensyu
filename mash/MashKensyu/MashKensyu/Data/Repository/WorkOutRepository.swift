//
//  WorkOutRepository.swift
//  MashKensyu
//
//  Created by eversense on 2025/01/31.
//

import Foundation
import RealmSwift

class WorkOutRepository {
    
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        }catch {
            fatalError("Realm初期化失敗:\(error.localizedDescription)")
        }
    }
    
    
    // MARK: データロジック
    func fechCategories() -> [WorkoutCategory] {
        return Array(realm.objects(WorkoutCategory.self))
    }
    
    func workOutListTitle(categoryid: String?) -> String? {
        
        guard let id = categoryid else {
            print("⚠️ categoryid is nil")
            return nil
        }
        
        if let category = realm.object(ofType: WorkoutCategory.self, forPrimaryKey: id) {
            return category.name
        } else {
            print("⚠️ カテゴリーがありません: \(id)")
            return nil
        }
    }
    
    func fetchWorkouts(categoryId: String?) -> [Workout]? {
        guard let categoryId = categoryId else {
            print("⚠️ categoryIdはnilです。")
            return nil
        }
        
        let result = realm.objects(Workout.self).filter("categoryId.id == %@", categoryId)
        return Array(result)
        
    }
    
}// end of class
