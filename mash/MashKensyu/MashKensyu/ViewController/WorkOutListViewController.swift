//
//  AddTrainingViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/01/30.
//

import UIKit
import RealmSwift

class WorkOutListViewController: UIViewController {
    
    var passedId: ObjectId?
    var trainingList: Results<Workout>!
    
    // 画面のLife Cycleーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 画面のタイトル設定
        if let id = passedId {
            let realm = try! Realm()
            if let category = realm.object(ofType: WorkoutCategory.self, forPrimaryKey: id) {
                self.title = category.name
            } else {
                print("⚠️　カテゴリーがありません: \(id)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        do {
            let realm = try Realm()
            
            guard let validId = passedId else {
                print("passedIdはnilです。")
                return
            }
            trainingList = realm.objects(Workout.self).filter("categoryId.id == %@", validId)
        } catch {
            print("Realm　エラー: \(error.localizedDescription)")
        }
    }
    
    // Table関連関数ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

}// end of class
