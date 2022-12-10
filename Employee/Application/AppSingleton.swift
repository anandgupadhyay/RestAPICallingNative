//
//  AppSingleton.swift


import UIKit
import SwiftMessages


class AppSingleton {
    
    static let shared: AppSingleton = {
        let instance = AppSingleton()
        return instance
    }()
    private init() {
        
    }
    func showErrorAlert(title:String = "Error",msg:String) {
        self.showTypeAlert(type: .error, msg: msg,title: title)
    }
    func showSuccessAlert(title:String = "Success",msg:String){
        self.showTypeAlert(type: .success, msg: msg,title: title)
    }
    func showWarningAlert(title:String = "Warning",msg:String){
        self.showTypeAlert(type: .warning, msg: msg,title: title)
    }
    private func showTypeAlert(type:Theme, msg:String, title:String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        var config = SwiftMessages.Config()
        // Slide up from the bottom.
        config.presentationStyle = .bottom
        
        // Theme message elements with the warning style.
        view.configureTheme(type)
        view.button?.isHidden = true
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
//        view.configureContent(title: title, body: msg, iconText: "")
        view.configureContent(title: title, body: msg)
        
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        view.titleLabel?.font = ThemeManager.Font.bold(size: 21.0)
        view.bodyLabel?.font = ThemeManager.Font.regular(size: 17.0)
        // Show the message.
        SwiftMessages.show(config: config, view: view)
    }
    
    //MARK:- Get app version number
    func getAppVersion() -> String {
        return (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!
    }
    func getAppVersionFull() -> String {
        return "\((Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!)(\((Bundle.main.infoDictionary!["CFBundleVersion"] as? String)!))"
    }
}
