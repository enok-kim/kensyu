
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
    
    // WorkoutRecord를 저장하는 메서드
      func saveWorkoutRecord(date: Date, completedSets: Int, completedReps: Int? = nil, completedDuration: Int? = nil, completedWeight: Double? = nil) {
          
          // WorkoutRecord 객체 생성
          let workoutRecord = WorkoutRecord(
              id: UUID().uuidString,
              date: date,
              completedSets: completedSets,
              completedReps: completedReps,
              completedDuration: completedDuration,
              completedWeight: completedWeight
          )
          
          // Realm에 저장
          do {
              try realm.write {
                  realm.add(workoutRecord)
              }
              print("✅ WorkoutRecord 저장 성공!")
          } catch {
              print("❌ WorkoutRecord 저장 실패: \(error.localizedDescription)")
          }
      }
      
      // 날짜별로 모든 WorkoutRecord를 불러오는 메서드
      func fetchWorkoutRecordsByDate(date: Date) -> [WorkoutRecord] {
          let startOfDay = Calendar.current.startOfDay(for: date)
          let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
          
          let results = realm.objects(WorkoutRecord.self).filter("date >= %@ AND date <= %@", startOfDay, endOfDay)
          return Array(results)
      }
    
     func saveWorkoutRecords(records: [WorkoutRecord]) {
         do {
             try realm.write {
                 realm.add(records)  // WorkoutRecord들을 Realm에 저장
             }
             print("✅ WorkoutRecord 저장 완료")
        } catch {
            print("❌ WorkoutRecord 저장 실패: \(error.localizedDescription)")
        }
    }
    
 }
