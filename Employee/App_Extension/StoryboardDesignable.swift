
import UIKit

// MARK: - Storyboard Enum
///
/// How to use?
/// Step 1: Add Your Storyboards Name to Storyboard Enum

enum Storyboard: String {
    
    case Main = "Main"
}

// MARK: - StoryboardDesignable Protocol for UIViewController
///
/// Step 2: Edit your ViewController's 'Storyboard ID' is same the 'Class Name'
/// Step 3: let vc = YourViewController.instantiate(from .StoryboardName)

protocol StoryboardDesignable : class {}

extension StoryboardDesignable where Self : UIViewController {
    
    static func instantiate(from storyboard: Storyboard, bundle: Bundle? = nil) -> Self {
        
        let dynamicMetatype = Self.self
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "\(dynamicMetatype)") as? Self else {
            fatalError("Couldn’t instantiate view controller with identifier \(dynamicMetatype)")
        }
        
        return viewController
    }
}
extension UIViewController : StoryboardDesignable {}
