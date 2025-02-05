import UIKit

protocol ChoseWorkoutDelegate: AnyObject {
    func didSelectWorkout(workout: String)
}

class ChoseWorkoutViewController: UIViewController {
    
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
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        workoutTableView.delegate = self
        workoutTableView.dataSource = self
        
        loadCategories()
        
    }
    
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
    
    static func instantiate() -> ChoseWorkoutViewController {
        let storyboard = UIStoryboard(name: "ChoseWorkout", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChoseWorkoutVC") as! ChoseWorkoutViewController
        return vc
    }
    
}

//MARK: CollectionView
extension ChoseWorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categories[indexPath.item]
        if let categoryLabel = cell.categoryLabel {
            categoryLabel.text = category.name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCategory = categories[indexPath.item]
        loadWorkoutsForCategory(selectedCategory!)
    }
}

//MARK: TableView
extension ChoseWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
        let workout = workouts[indexPath.row]
        cell.textLabel?.text = workout.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWorkout = workouts[indexPath.row]
        delegate?.didSelectWorkout(workout: selectedWorkout.name)
        navigationController?.popViewController(animated: true)
    }
}
