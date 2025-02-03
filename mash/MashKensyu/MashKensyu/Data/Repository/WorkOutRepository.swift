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
            fatalError("Realm 초기화 실패: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 데이터 로직
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
            print("⚠️ 카테고리가 없습니다: \(id)")
            return nil
        }
    }
    
    func fetchWorkouts(categoryId: String?) -> [Workout]? {
        guard let categoryId = categoryId else {
            print("⚠️ categoryId는 nil입니다.")
            return nil
        }
        
        // categoryId에 해당하는 Workout 객체를 필터링
        let result = realm.objects(Workout.self).filter("categoryId.id == %@", categoryId)
        return Array(result)
    }
    
    func addWorkout(categoryId: String, workout: Workout) {
        do {
            // categoryId에 해당하는 WorkoutCategory 객체를 가져옴
            if let category = realm.object(ofType: WorkoutCategory.self, forPrimaryKey: categoryId) {
                workout.categoryId = category  // categoryId와 연결
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
