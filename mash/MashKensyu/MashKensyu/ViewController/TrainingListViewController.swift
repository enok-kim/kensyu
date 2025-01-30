//
//  AddTrainingViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/01/30.
//

import UIKit
import RealmSwift

class TrainingListViewController: UIViewController {
    
    var passedId: ObjectId?
    var trainingList: Results<Workout>!
    
    // 画面のLife Cycleーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // 画面のタイトル設定
        if let id = passedId {
            let realm = try! Realm()
            if let category = realm.object(ofType: WorkoutCategory.self, forPrimaryKey: id) {
                self.title = category.name // 화면 상단 타이틀 변경
            } else {
                print("⚠️ 해당 ID에 맞는 카테고리를 찾을 수 없음: \(id)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            let realm = try Realm()
            
            guard let validId = passedId else {
                print("passedId가 nil입니다.")
                return
            }
            trainingList = realm.objects(Workout.self).filter("categoryId.id == %@", validId)
        } catch {
            print("Realm 불러오기 오류: \(error.localizedDescription)")
        }
    }
    
    // Table関連関数ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

}// end of class
