import Foundation
import UIKit

private struct APIVersion {
    static let V1 = "/WebService_V46.svc"
}

private struct Urls {
    static let baseUrl = "webservice.teamlocus.com"
    //https://webservice.teamlocus.com/WebService_V46.svc/general_webuserlogin
}
struct API {
    // Test api
    struct test {
        var testId:String?
        func url() -> String {
            return "/\(testId!)"
        }
    }
}

open class ServiceManager {
    
    var scheme: String = "https"
    var host: String? = Urls.baseUrl
    var authorization: String?
    var contentType: String? = "application/json"
    var accept: String? = "application/json"
    let currentAPIVersion: String = APIVersion.V1
    
    var session = URLSession(configuration: .default)
    
    static let shared: ServiceManager = {
        let instance = ServiceManager()
        return instance
    }()
    private init() {}
    
    private func prepareRequest (url:URL?,params:[String:Any]?,method:HTTPMethod) -> URLRequest? {
        guard let url = url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let params = params {
            var jsonData = Data()
            do {
                jsonData = try JSONSerialization.data(withJSONObject: params)
            } catch {
                print(error.localizedDescription)
            }
            request.httpBody = jsonData
        }
        for header in getHeaders() {
            request.add(header: header)
        }
        return request
    }
    func makeRequest(endPoint:String,withHttpMethod:HTTPMethod, withParameters:[String:Any]? = nil, authorization:String? = nil,showLoadingOnView:UIView = appDelegate.window!,loadingMsg:String = "wait",isOnlyIndicator:Bool = false, onComplete:@escaping (Result<Data?,RequestError>) -> Void) {
        
        if Reachability.isConnectedToNetwork() {
            
            let components = self.components(path: endPoint)
            self.authorization = authorization
            
            guard let request = self.prepareRequest(url: components.url, params: withParameters, method: withHttpMethod) else {
                onComplete(.failure(.init(message: "Unable to create the URLRequest object")))
                return
            }
            DispatchQueue.main.async {
                self.startLoading(parentView: showLoadingOnView, loadingMessage: loadingMsg, isOnlyIndicatorRequired: isOnlyIndicator)
            }
            
            let task = self.session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    self.stopLoading(parentView: showLoadingOnView)
                }
                guard let response = response as? HTTPURLResponse else {
                    onComplete(.failure(.init(message: "Did not get a http response")))
                    return
                }
                if let error = error as NSError? {
                    onComplete(.failure(.init(message: "\(response.statusCode): \(error.localizedDescription)")))
                    return
                }
                onComplete(.success(data))
            }
            task.resume()
        } else {
//            AppSingleton.shared.showErrorAlert(msg: "internet_lost".localized,fromAPI: false)
        }
    }
    //MARK: - Get headers
    private func getHeaders() -> [HTTPHeader] {
        var headers: [HTTPHeader] = []
        if let contentType = self.contentType {
            headers.append(HTTPHeader(field: .contentType, value: contentType))
        }
        if let accept = self.accept {
            headers.append(HTTPHeader(field: .accept, value: accept))
        }
        if let authorization = self.authorization {
            headers.append(HTTPHeader(field: .authorization, value: authorization))
        }
        return headers
    }
    //MARK: - Urlcomponents
    private func components(path: String) -> URLComponents {
        var components = URLComponents()
        components.host = self.host
        components.path = currentAPIVersion + path
        components.scheme = self.scheme
        return components
    }
    //MARK: - Loading View
    func startLoading(parentView:UIView,loadingMessage:String, isOnlyIndicatorRequired:Bool) {
        let loadingView = LoadingIndicator().loadNib() as? LoadingIndicator
        loadingView?.m_lblMsg.text = loadingMessage
        parentView.addSubview(loadingView!)
        loadingView!.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: loadingView!, attribute: $0, relatedBy: .equal, toItem: parentView, attribute: $0, multiplier: 1, constant: 0)
        })

        loadingView?.m_visualViewFull.isHidden = isOnlyIndicatorRequired
        loadingView?.m_visualViewPartial.isHidden = !isOnlyIndicatorRequired
    }
    func stopLoading(parentView:UIView) {
        let view = parentView.findViews(subclassOf: LoadingIndicator.self)
        view.first?.removeFromSuperview()
    }
}
