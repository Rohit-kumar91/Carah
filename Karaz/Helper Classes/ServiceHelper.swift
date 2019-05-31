
import Foundation
import Alamofire

final class ServiceHelper {
    
    class var sharedInstance: ServiceHelper {
        struct Static {
            static let instance = ServiceHelper()
        }
        return Static.instance
    }
    
    
    
    //Create Get and send request
    func createGetRequest(isShowHud: Bool, apiName : String, completion: @escaping (_ response: AnyObject?, _ error: NSError?) -> Void) {
        
        if !APPDELEGATE.checkReachablility() {
            completion(nil,NSError.init(domain: "Please check your internet connection!", code: 000, userInfo: nil))
            return
        }
       
        
        let url = BASE_URL + apiName
        print( "\n\n Request URL  >>>>>>\(url)")
        
        Alamofire.request(URL.init(string: url)!, method: HTTPMethod.get, encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(_):
                
                 print("Status Code",response.response?.statusCode)
                 RappleActivityIndicatorView.stopAnimation()
                 
                 if response.response?.statusCode == 200 {
                    //Ok Response
                    completion(response.result.value as AnyObject?, nil)
                    
                 } else if response.response?.statusCode == 401 {
                    //Unauthorized
                    completion(response.result.value as AnyObject?, nil)
                    
                 } else if response.response?.statusCode == 403 {
                    //Unauthorized
                    
                 } else if response.response?.statusCode == 404 {
                    //Forbidden
                    
                 }  else if response.response?.statusCode == 400 {
                    completion(response.result.value as AnyObject?, nil)
                }
            case .failure(_):
                
                print( "\nfailure:\n failure Response From Server >>>>>>\n\(String(describing: response.result.error))")
                RappleActivityIndicatorView.stopAnimation()
                completion(nil, response.result.error as NSError?)
            }
        }
    }
    
    
 
    
    func createPostRequest(isShowHud: Bool, params: [String : AnyObject]!,apiName : String, completion: @escaping (_ response: AnyObject?, _ error: NSError?) -> Void)
    {
        
        if !APPDELEGATE.checkReachablility() {
            completion(nil,NSError.init(domain: "Please check your internet connection!", code: 000, userInfo: nil))
            return
        }
        
        
        let url = BASE_URL + apiName
        let parameterDict = params as NSDictionary
        
        if isShowHud {
            showHud()
        }
        
        Alamofire.request(URL.init(string: url)!, method: HTTPMethod.post, parameters: parameterDict as? Parameters, encoding: URLEncoding.queryString).responseJSON { response in
            
            switch response.result {
            case .success(_):
                print(response.response?.statusCode)
                print(response.result.value)
                print(response.response?.allHeaderFields)
                
                RappleActivityIndicatorView.stopAnimation()
                if response.response?.statusCode == 200 {
                    //Ok Response
                    completion(response.result.value as AnyObject?, nil)
                    
                } else if response.response?.statusCode == 401 {
                    //Unauthorized
                    completion(response.result.value as AnyObject?, nil)
                   
                } else if response.response?.statusCode == 403 {
                    //Unauthorized
                   
                } else if response.response?.statusCode == 404 {
                    //Forbidden
                    
                }  else if response.response?.statusCode == 400 {
                    completion(response.result.value as AnyObject?, nil)
                }
                
            case .failure(_):
                RappleActivityIndicatorView.stopAnimation()
                completion(nil, response.result.error as NSError?)
            }
        }
    }
    
    func showHud() {
        let attribute = RappleActivityIndicatorView.attribute(style: RappleStyleCircle, tintColor: .white, screenBG: nil, progressBG: .black, progressBarBG: .lightGray, progreeBarFill: .yellow)
        RappleActivityIndicatorView.startAnimating(attributes: attribute)
    }

}
