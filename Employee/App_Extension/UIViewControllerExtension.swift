//
//  UIViewControllerExtension.swift

import UIKit

extension UIViewController {
    
    // Push view controller
    func pushVC(destinationVC:UIViewController) {
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    // Pop view controller
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Pop to root view controller
    func popToRootVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //Pop view controller with source vc
    func popWithVC(sourceVC:UIViewController) {
        self.navigationController?.popToViewController(sourceVC, animated: true)
    }
    
    //Find particular vc and pop to that vc
    func popToParticularVC<T>(popToVC:T.Type) where T : UIViewController {
        var isVCFound = Bool()
        if navigationController?.viewControllers.count != nil {
            for vc in (navigationController?.viewControllers)! {
                if vc is T {
                    isVCFound = true
                    self.navigationController?.popToViewController(vc, animated: true)
                    return
                }
            }
        }
        if !isVCFound {
            let vcObj = T.instantiate(from: .Main)
            let navi = UINavigationController(rootViewController: vcObj)
            navi.navigationBar.isHidden = true
            appDelegate.window?.rootViewController = navi
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    // Global Alert
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}

extension UIViewController {
    func embed(_ viewController:UIViewController, inView:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = inView.bounds
        inView.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
