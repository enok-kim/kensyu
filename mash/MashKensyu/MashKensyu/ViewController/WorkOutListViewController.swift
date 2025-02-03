import UIKit

class WorkOutListViewController: UIViewController {
    
    var categoryId: String?
    private var workOutList: [Workout] = []
    
    private let workOutListRepository = WorkOutRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let categoryId {
            self.title = workOutListRepository.workOutListTitle(categoryid: categoryId) ?? "タイトルはnilです"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let workouts = workOutListRepository.fetchWorkouts(categoryId: categoryId) {
            workOutList = workouts
            print("Fetched \(workOutList.count) workouts")
        } else {
            print("Workouts could not be fetched.")
        }
    }
    
    // MARK: 画面遷移メソッド
    static func instantiate(categoryId: String) -> WorkOutListViewController {
        let storyboard = UIStoryboard(name: "WorkOutList", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WorkOutListVC") as! WorkOutListViewController
        vc.categoryId = categoryId
        return vc
    }
    
    @IBAction func addWork(_ sender: UIBarButtonItem) {
        let addWorkVC = AddWorkViewController.instantiate()
        self.navigationController?.pushViewController(addWorkVC, animated: true)
        
    }
    
}
