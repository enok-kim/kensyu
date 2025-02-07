//
//  WorkoutRecord.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/05.
//

import Foundation
import RealmSwift

class WorkoutRecord: Object {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var date: Date
    @Persisted var completedSets: Int
    @Persisted var completedReps: Int?
    @Persisted var completedDuration: Int?
    @Persisted var completedWeight: Double?
    
    required override init() {
        super.init()
    }
    
    convenience init(id: String, date: Date, completedSets: Int, completedReps: Int? = nil, completedDuration: Int? = nil, completedWeight: Double? = nil) {
        
        self.init()
        self.id = id
        self.date = date
        self.completedSets = completedSets
        self.completedReps = completedReps
        self.completedDuration = completedDuration
        self.completedWeight = completedWeight
        
    }
    
}
