import UIKit

protocol ChoseWorkoutDelegate: AnyObject {
    func didSelectWorkout(workout: String)
}

class ChooseWorkoutViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var workoutTableView: UITableView!
    
    private var categories: [WorkoutCategory] = []
    private var selectedCategory: WorkoutCategory?
    private var workouts: [Workout] = []
    
    weak var delegate: ChoseWorkoutDelegate?
    
    private let repository = WorkOutRepository()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupCategotyCollectionView()
        setupChooseWorkoutTableView()
        
        loadCategories()
        
    }
    
    // MARK: データ処理関連関数
    func loadCategories() {
        categories = repository.fetchCategories()
        
        if !categories.isEmpty {
            selectedCategory = categories[0]
            loadWorkoutsForCategory(selectedCategory!)
        }
    }
    
    func loadWorkoutsForCategory(_ category: WorkoutCategory) {
        workouts = repository.fetchWorkouts(for: category)
        workoutTableView.reloadData()
    }
    
    // MARK: 画面遷移関数
    static func instantiate() -> ChooseWorkoutViewController {
        let storyboard = UIStoryboard(name: "ChooseWorkout", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChooseWorkoutVC") as! ChooseWorkoutViewController
        return vc
    }
    
}

    // MARK: CollectionView
extension ChooseWorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categories[indexPath.item]
        
        guard let categoryName = category.name else {
            return cell
        }
        
        cell.configure(category: categoryName)
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        loadWorkoutsForCategory(selectedCategory!)
    }
    
    func setupCategotyCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
}// end of Cell

    // MARK: TableView
extension ChooseWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutListCell", for: indexPath) as! WorkoutListCell
        let workout = workouts[indexPath.row]
        cell.configure(workoutName: workout.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWorkout = workouts[indexPath.row]
        delegate?.didSelectWorkout(workout: selectedWorkout.name)
        navigationController?.popViewController(animated: true)
    }
    
    func setupChooseWorkoutTableView() {
        workoutTableView.delegate = self
        workoutTableView.dataSource = self
    }
    
}
