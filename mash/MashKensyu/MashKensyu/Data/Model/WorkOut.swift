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
    
    @Persisted(primaryKey: true) var id: String?
    @Persisted var name: String
    @Persisted var difficulty: Int
    @Persisted var descriptionText: String = ""
    // 所属しているカテゴリー
    @Persisted var categoryId: WorkoutCategory?

}
