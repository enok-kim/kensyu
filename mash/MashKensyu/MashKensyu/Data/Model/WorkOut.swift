//
//  WorkOut.swift
//  MashKensyu
//
//  Created by eversense on 2025/01/31.
//

import Foundation
import RealmSwift


// 運動リスト
class Workout: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var reps: Int
    @Persisted var sets: Int
    // 所属しているカテゴリー
    @Persisted var categoryId: WorkoutCategory?
    
}
