//
//  WorkOutListTableViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/01/30.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    private var workoutCategories: [WorkoutCategory] = []
    private let workoutRepository = WorkOutRepository()
    
    @IBOutlet var categoryTable: UITableView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        workoutCategories = workoutRepository.fechCategories()
        categoryTable.reloadData()
    }
    
    // MARK: Table Function

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutCategories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        // @todo: このスタイルダサいから直さないと、、
        let workoutCategory = workoutCategories[indexPath.row]
        cell.textLabel?.text = workoutCategory.name
        
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        
        cell.backgroundColor = .white
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = storyboard?.instantiateViewController(identifier: "WorkOutListViewController") as! WorkOutListViewController
        newVC.passedId = workoutCategories[indexPath.row].id
        navigationController?.pushViewController(newVC, animated: true)
        print(workoutCategories[indexPath.row])
    }
    
} // end of class
