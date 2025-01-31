import UIKit

class WorkOutListViewController: UIViewController {
    
    var passedId: String?
    private var workOutList: [Workout] = []
    
    private let workOutListRepository = WorkOutRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let categoryId = passedId {
            self.title = workOutListRepository.workOutListTitle(categoryid: categoryId) ?? "タイトルはnilです"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let workouts = workOutListRepository.fetchWorkouts(categoryId: passedId) {
            workOutList = workouts
            print("Fetched \(workOutList.count) workouts")
        } else {
            print("Workouts could not be fetched.")
        }
    }
    
    @IBAction func addWork(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "AddWork", bundle: nil)
        let addWorkVC = storyboard.instantiateViewController(withIdentifier: "AddWorkVC") as! AddWorkViewController
        self.navigationController?.pushViewController(addWorkVC, animated: true)
    }
}
