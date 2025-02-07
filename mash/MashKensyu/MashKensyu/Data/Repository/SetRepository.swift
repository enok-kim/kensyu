
import Foundation
import RealmSwift

class SetRepository {
    
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Realm初期化失敗: \(error.localizedDescription)")
        }
    }
    
      func saveWorkoutRecord(date: Date, completedSets: Int, completedReps: Int? = nil, completedDuration: Int? = nil, completedWeight: Double? = nil) {
          
          let workoutRecord = WorkoutRecord(
              id: UUID().uuidString,
              date: date,
              completedSets: completedSets,
              completedReps: completedReps,
              completedDuration: completedDuration,
              completedWeight: completedWeight
          )
          
          do {
              try realm.write {
                  realm.add(workoutRecord)
              }
              print("✅ WorkoutRecord 保存成功!")
          } catch {
              print("❌ WorkoutRecord 保存失敗: \(error.localizedDescription)")
          }
      }
      
      func fetchWorkoutRecordsByDate(date: Date) -> [WorkoutRecord] {
          let startOfDay = Calendar.current.startOfDay(for: date)
          let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
          
          let results = realm.objects(WorkoutRecord.self).filter("date >= %@ AND date <= %@", startOfDay, endOfDay)
          return Array(results)
      }
    
     func saveWorkoutRecords(records: [WorkoutRecord]) {
         do {
             try realm.write {
                 realm.add(records)
             }
             print("✅ WorkoutRecord 保存成功")
        } catch {
            print("❌ WorkoutRecord 保存失敗: \(error.localizedDescription)")
        }
    }
    
 }
