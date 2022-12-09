//
//  LoadingIndicator.swift

import Foundation
import UIKit

class LoadingIndicator: UIView {
    @IBOutlet weak var m_visualViewPartial: UIVisualEffectView!
    @IBOutlet weak var m_visualViewFull: UIVisualEffectView!
    @IBOutlet weak var m_viewContainer: UIView!
    @IBOutlet weak var m_activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var m_activityIndicatorPartial: UIActivityIndicatorView!
    @IBOutlet weak var m_lblMsg: UILabel!
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        m_activityIndicator.startAnimating()
        m_activityIndicatorPartial.startAnimating()
    }
}
