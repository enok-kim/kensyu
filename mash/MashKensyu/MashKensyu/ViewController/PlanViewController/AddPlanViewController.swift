import UIKit

class AddPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    
    private var workouts: [[String]] = []
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedSectionHeaderHeight = 10
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
    }
    
    //MARK: Table関連関数
    func numberOfSections(in tableView: UITableView) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts[section].count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
            cell.textLabel?.text = "運動名 \(indexPath.section + 1)"
            
            return cell
            
        } else if indexPath.row == workouts[indexPath.section].count + 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddSetCell", for: indexPath)
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SetCell", for: indexPath)
            cell.textLabel?.text = "セット \(indexPath.row): 50kg x 10回"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == workouts[indexPath.section].count + 1 {
            workouts[indexPath.section].append("新しいセット")
            tableView.insertRows(at: [IndexPath(row: workouts[indexPath.section].count, section: indexPath.section)], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //MARK: 動作関連関数
    @IBAction func onTabAddWorkoutSection(_ sender: UIBarButtonItem) {
        workouts.append([])
        tableView.insertSections(IndexSet(integer: workouts.count - 1), with: .automatic)
    }
    
    @IBAction func onTabChoseWorkout(_ sender: UIButton) {
        let ChoseWorkoutVC = ChoseWorkoutViewController.instantiate()
        self.navigationController?.pushViewController(ChoseWorkoutVC, animated: true)
    }
    
    static func instantiate() -> AddPlanViewController {
        let storyboard = UIStoryboard(name: "AddPlan", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddPlanVC") as! AddPlanViewController
        return vc
    }
    
}// end of class
