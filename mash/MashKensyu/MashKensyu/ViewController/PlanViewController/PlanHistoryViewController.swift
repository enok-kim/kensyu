
import UIKit

class PlanHistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - Screen Transition Method
    static func instantiate() -> PlanHistoryViewController {
        let storyboard = UIStoryboard(name: "PlanHistory", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PlanHistoryVC") as! PlanHistoryViewController
        return vc
    }

}
