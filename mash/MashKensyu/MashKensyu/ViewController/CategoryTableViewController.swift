//
//  WorkOutListTableViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/01/30.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    var category: Results<WorkoutCategory>!
    
    // Outlet
    @IBOutlet var categoryTable: UITableView!
    
    // 画面のLife Cycleーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        do {
            let realm = try Realm()
            category = realm.objects(WorkoutCategory.self)
            self.categoryTable.reloadData()
        } catch {
            print("Realm initialization error: \(error.localizedDescription)")
        }
        
    }
    
    // Table関連関数ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let category = category {
            return category.count
        } else {
            // categoryがnilの場合、0を返す
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        // @todo: このスタイルダサいから直さないと、、
        let workoutCategory = category[indexPath.row]
        cell.textLabel?.text = workoutCategory.name
        
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        
        cell.backgroundColor = .white
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
        
    }

// 　　@info: Cellを押した時にデータが伝わっているのかを確認
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(category[indexPath.row])
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "inAddTrainingVC" {
            guard let indexPath = categoryTable.indexPathForSelectedRow else { return }
            let destination = segue.destination as? WorkOutListViewController
            destination?.passedId = category[indexPath.row].id
        }

    }
    
} // end of class
