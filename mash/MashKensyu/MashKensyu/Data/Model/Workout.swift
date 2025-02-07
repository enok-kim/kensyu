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
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var level: String?
    @Persisted var workoutDescription: String? = ""
    // 所属しているカテゴリー!
    @Persisted var categoryId: WorkoutCategory?

    required override init() {
        super.init()
    }
    
    convenience init(name: String, workoutDescription: String? = "", level: String? = "") {
        self.init()
        self.name = name
        self.workoutDescription = workoutDescription
        self.level = level
    }
    
}
