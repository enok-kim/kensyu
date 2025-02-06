import UIKit

class AddPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var workouts: [[String]] = []
    private let workoutNameRow = 0 // 運動名セルの行番号
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedSectionHeaderHeight = 10
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    // MARK: - Table関連関数
    func numberOfSections(in tableView: UITableView) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let additionalCellsCount = 2 // 運動名セルとセット追加セルの分
        return workouts[section].count + additionalCellsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addSetButtonRow = workouts[indexPath.section].count + 1 // セット追加ボタンの行番号

        if indexPath.row == workoutNameRow {
            // 運動名セル
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
            cell.textLabel?.text = "運動名 \(indexPath.section + 1)"
            return cell

        } else if indexPath.row == addSetButtonRow {
            // セット追加ボタンセル
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddSetCell", for: indexPath)
            return cell

        } else {
            // 実際のセットセル
            let cell = tableView.dequeueReusableCell(withIdentifier: "SetCell", for: indexPath)
            cell.textLabel?.text = "セット \(indexPath.row): 50kg x 10回"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addSetButtonRow = workouts[indexPath.section].count + 1 // セット追加ボタンの行番号

        if indexPath.row == addSetButtonRow {
            // 新しいセットを追加
            workouts[indexPath.section].append("新しいセット")
            tableView.insertRows(at: [IndexPath(row: workouts[indexPath.section].count, section: indexPath.section)], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - 動作関連関数
    @IBAction func onTabAddWorkoutSection(_ sender: UIBarButtonItem) {
        // 新しいワークアウトセクションを追加
        workouts.append([])
        tableView.insertSections(IndexSet(integer: workouts.count - 1), with: .automatic)
    }
    
    @IBAction func onTabChoseWorkout(_ sender: UIButton) {
        let choseWorkoutVC = ChoseWorkoutViewController.instantiate()
        self.navigationController?.pushViewController(choseWorkoutVC, animated: true)
    }
    
    static func instantiate() -> AddPlanViewController {
        let storyboard = UIStoryboard(name: "AddPlan", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddPlanVC") as! AddPlanViewController
        return vc
    }

} // end of class
