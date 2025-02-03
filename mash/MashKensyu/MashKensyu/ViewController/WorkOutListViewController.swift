import UIKit

class WorkOutListViewController: UIViewController {
    
    var passedCategoryId: String?
    private var workOutList: [Workout] = []
    
    private let workOutListRepository = WorkOutRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let passedCategoryId {
            self.title = workOutListRepository.workOutListTitle(categoryid: passedCategoryId) ?? "タイトルはnilです"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let workouts = workOutListRepository.fetchWorkouts(categoryId: passedCategoryId) {
            workOutList = workouts
            print("Fetched \(workOutList.count) workouts")
        } else {
            print("Workouts could not be fetched.")
        }
    }
    
    // MARK: 画面遷移メソッド
    static func instantiate(passedId: String) -> WorkOutListViewController {
        let storyboard = UIStoryboard(name: "WorkOutList", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WorkOutListVC") as! WorkOutListViewController
        vc.passedCategoryId = passedId
        return vc
    }
    
    @IBAction func addWork(_ sender: UIBarButtonItem) {
        let addWorkVC = AddWorkViewController.instantiate()
        self.navigationController?.pushViewController(addWorkVC, animated: true)
        
    }
    
}
