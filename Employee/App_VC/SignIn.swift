//
//  ViewController.swift
//  Employee
//
//  Created by Anand on 9/12/22
//

import UIKit

class SignIn: UIViewController {
    
    @IBOutlet weak var imgSample: UIImageView!
    @IBOutlet weak var m_txtFldUname: UITextField!
    @IBOutlet weak var m_txtFldPwd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print("ImageView Size:\(imgSample.frame)")
//        print("Image Size:\(String(describing: imgSample.image?.size))")
//        print("Image Coordinates:\(imgSample.image.)")
        
    }
    
    //MARK: - Action SignIn
    @IBAction func actionSignIn(_ sender: UIButton) {
        if doValidation() {
            let parameters: [String: Any] = ["username": m_txtFldUname.text!,
                                             "password":m_txtFldPwd.text!,
                                             "gmtoffset":"5.5",
                                             "deviceinfo":"{\"deviceid\" : \"123\", \"devicetype\" : \"\", \"deviceimieuuid\" : \"android_test\"}"]
            let endPointPath = "/general_webuserlogin"
            
        }
    }
    //MARK: - SignIn Validation
    func doValidation() -> Bool {
        self.view.endEditing(true)
        if (m_txtFldUname.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! {
            AppSingleton.shared.showErrorAlert(msg: "Username Required")
            return false
        }
        if (m_txtFldPwd.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! {
            AppSingleton.shared.showErrorAlert(msg: "Password Required")
            return false
        }
        return true
    }
}
private extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

