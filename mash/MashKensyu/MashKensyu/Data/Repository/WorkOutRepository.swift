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
        } catch {
            fatalError("Realm初期化失敗: \(error.localizedDescription)")
        }
    }
    
    // MARK: データロジック
    func fetchCategories() -> [WorkoutCategory] {
        return Array(realm.objects(WorkoutCategory.self))
    }
    
    func workOutListTitle(categoryId: String?) -> String? {
        guard let id = categoryId else {
            print("⚠️ categoryId is nil")
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
    
    func addWorkout(categoryId: String, workout: Workout) {
        do {
            if let category = realm.object(ofType: WorkoutCategory.self, forPrimaryKey: categoryId) {
                workout.categoryId = category
            } else {
                print("Error: Category not found for ID \(categoryId)")
                return
            }
            
            try realm.write {
                realm.add(workout)
                print("Workout added: \(workout.name)")
            }
        } catch {
            print("Error saving workout: \(error)")
        }
    }
}
