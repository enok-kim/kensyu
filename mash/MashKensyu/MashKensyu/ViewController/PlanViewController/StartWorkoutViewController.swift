import UIKit

class StartWorkoutViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    private var workouts: [[String]] = []
    private var setRepository: SetRepository?
    private var recordeSets: [WorkoutRecord] = []

    private let workoutNameRow = 0

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Actions
    @IBAction func onTabChoseWorkout(_ sender: UIButton) {
        let choseWorkoutVC = ChooseWorkoutViewController.instantiate()
        choseWorkoutVC.delegate = self
        navigationController?.pushViewController(choseWorkoutVC, animated: true)
    }

    @IBAction func onTapFinishWorkout(_ sender: UIButton) {
        saveWorkoutRecords()
        showCompletionAlert()
    }

    private func saveWorkoutRecords() {
        setRepository?.saveWorkoutRecords(records: recordeSets)
    }

    private func showCompletionAlert() {
        let alert = UIAlertController(title: "運動終了", message: "お疲れ様でした！", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    static func instantiate() -> StartWorkoutViewController {
        let storyboard = UIStoryboard(name: "StartWorkout", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "StartWorkoutVC") as! StartWorkoutViewController
    }
}

// MARK: - Table View Delegate and DataSource
extension StartWorkoutViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return workouts.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts[section].count + 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(for: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    private func configureCell(for indexPath: IndexPath) -> UITableViewCell {
        let addSetButtonRow = workouts[indexPath.section].count + 1
        if indexPath.row == workoutNameRow {
            return configureWorkoutNameCell(for: indexPath)
        } else if indexPath.row == addSetButtonRow {
            return configureAddSetCell(for: indexPath)
        } else {
            return configureSetCell(for: indexPath)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 10
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
}

// MARK: - AddSetCellDelegate, ChoseWorkoutDelegate, SetCellDelegate
extension StartWorkoutViewController: AddSetCellDelegate, ChoseWorkoutDelegate, SetCellDelegate {
    
    private func configureWorkoutNameCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutNameCell", for: indexPath) as! WorkoutCell
        let workoutName = workouts[indexPath.section].first ?? "運動名"
        cell.configure(workoutName: workoutName)
        return cell
    }

    private func configureAddSetCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddSetCell", for: indexPath) as! AddSetCell
        cell.configure(title: "", section: indexPath.section, row: indexPath.row, delegate: self)
        return cell
    }

    private func configureSetCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetCell", for: indexPath) as! SetCell
        let setText = "セット \(indexPath.row - 1): "
        cell.configure(setText: setText, indexPath: indexPath)
        cell.delegate = self
        return cell
    }

    func didCompleteSet(at indexPath: IndexPath, weight: Double?, reps: Int?) {
        guard let weight = weight, let reps = reps else { return }

        print("Set \(indexPath.row) 完了: \(weight)kg, \(reps)回")
        
        let workoutRecord = WorkoutRecord(
            id: UUID().uuidString,
            date: Date(),
            completedSets: indexPath.row,
            completedReps: reps,
            completedWeight: weight
        )
        recordeSets.append(workoutRecord)
        print("WorkoutRecord 保存成功: \(workoutRecord)")
    }

    func didSelectWorkout(workout: String) {
        workouts.append([workout])
        tableView.reloadData()
    }

    func onTapAddSetCell(section: Int, row: Int) {
        workouts[section].append("新しいセット")
        let indexPath = IndexPath(row: workouts[section].count, section: section)
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
