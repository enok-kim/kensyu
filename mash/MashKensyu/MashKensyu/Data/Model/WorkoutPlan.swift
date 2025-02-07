//
//  WorkoutPlan.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/05.
//

import Foundation
import RealmSwift

class WorkoutPlan: Object {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var workoutId: Workout?
    @Persisted var sets: Int
    @Persisted var reps: Int?
    @Persisted var duration: Int?
    @Persisted var weight: Double?
    
    
    required override init() {
        super.init()
    }
    
    convenience init(id: String, workoutId: Workout?, sets: Int, reps: Int? = nil, duration: Int? = nil, weight: Double? = nil) {
        self.init()
        self.id = id
        self.workoutId = workoutId
        self.sets = sets
        self.reps = reps
        self.duration = duration
        self.weight = weight
    }
    
}
