//
//  WorkoutCategory.swift
//  MashKensyu
//
//  Created by eversense on 2025/01/30.
//

import Foundation
import RealmSwift

// トレニングカテゴリー
class WorkoutCategory: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String? = nil
    @Persisted(originProperty: "categoryId") var workouts: LinkingObjects<Workout>
    
}

// 運動リスト
class Workout: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var reps: Int
    @Persisted var sets: Int
    // 所属しているカテゴリー
    @Persisted var categoryId: WorkoutCategory?
    
}
