
import UIKit

class AddPlanViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var workouts: [[String]] = []
    private let workoutNameRow = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - 動作関連メソッド
    @IBAction func onTabChoseWorkout(_ sender: UIButton) {
        let choseWorkoutVC = ChooseWorkoutViewController.instantiate()
        choseWorkoutVC.delegate = self
        self.navigationController?.pushViewController(choseWorkoutVC, animated: true)
    }
    
    static func instantiate() -> AddPlanViewController {
        let storyboard = UIStoryboard(name: "AddPlan", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddPlanVC") as! AddPlanViewController
        return vc
    }
    
} // end of class

    // MARK: Table
extension AddPlanViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let additionalCellsCount = 2
        return workouts[section].count + additionalCellsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedSectionHeaderHeight = 10
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
}

   // MARK: Cell
extension AddPlanViewController: AddSetCellDelegate, ChoseWorkoutDelegate {
    
    func didSelectWorkout(workout: String) {
        workouts.append([workout])
        tableView.reloadData()
    }

    private func configureCell(for indexPath: IndexPath) -> UITableViewCell {
        
        let addSetButtonRow = addSetButtonRow(for: indexPath.section)

        if indexPath.row == workoutNameRow {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutNameCell", for: indexPath) as! WorkoutCell
            let workoutName = workouts[indexPath.section].first ?? "運動名"
            cell.configure(wourkoutName: workoutName)
            return cell
        } else if indexPath.row == addSetButtonRow {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddSetCell", for: indexPath) as! AddSetCell
            cell.configure(title: "", section: indexPath.section, row: indexPath.row, delegate: self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SetCell", for: indexPath) as! SetCell
            let setText = "セット \(indexPath.row - 1): "
            cell.configure(setText: setText)
            return cell
        }
        
    }
    
    private func addSetButtonRow(for section: Int) -> Int {
        return workouts[section].count + 1
    }

    
    func onTapAddSetCell(section: Int, row: Int) {
        workouts[section].append("新しいセット")
        let indexPath = IndexPath(row: workouts[section].count + 1, section: section)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    @IBAction func onTabAddWorkoutSection(_ sender: UIBarButtonItem) {
        addNewWorkoutSection()
    }
    
    
    private func addNewWorkoutSection() {
        workouts.append([])
        tableView.insertSections(IndexSet(integer: workouts.count - 1), with: .automatic)
    }
    
}
 
