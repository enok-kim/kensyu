import UIKit

class WorkOutListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categoryId: String!
    private var workOutList: [Workout] = []
    
    private let workOutListRepository = WorkOutRepository()
    
    @IBOutlet weak var workoutListTable: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let categoryId = categoryId {
            self.title = workOutListRepository.workOutListTitle(categoryId: categoryId) ?? "タイトルはnilです"
        }
        
        workoutListTable.dataSource = self
        workoutListTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let categoryId = categoryId else {
            print("categoryId is nil")
            return
        }
        
        if let workouts = workOutListRepository.fetchWorkoutsById(categoryId: categoryId) {
            workOutList = workouts
            print("Fetched \(workOutList.count) workouts")
            workoutListTable.reloadData()
        } else {
            print("Workouts could not be fetched.")
        }
    }
    
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workOutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutListCell", for: indexPath)
        let workout = workOutList[indexPath.row]
        cell.textLabel?.text = workout.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWorkout = workOutList[indexPath.row]
        
        let detailVC = WorkoutDetailViewController.instantiate(workoutId: selectedWorkout.id)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Screen Transition Method
    static func instantiate(categoryId: String) -> WorkOutListViewController {
        let storyboard = UIStoryboard(name: "WorkoutList", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WorkOutListVC") as! WorkOutListViewController
        vc.categoryId = categoryId
        return vc
    }
    
    @IBAction func addWork(_ sender: UIBarButtonItem) {
        let addWorkVC = AddWorkViewController.instantiate(categoryId: categoryId)
        self.navigationController?.pushViewController(addWorkVC, animated: true)
    }
}
