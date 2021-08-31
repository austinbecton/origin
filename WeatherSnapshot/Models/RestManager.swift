//
//  RestManager.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/29/21.
//

import Foundation

class RestManager {
    
    var requestHttpHeaders = RestEntity()
 
    var urlQueryParameters = RestEntity()
 
    var httpBodyParameters = RestEntity()
    
    
    //Allows to set HTTP body directly
    //Therefore, can use many different types
    var httpBody: Data?

    
    
    //Append parameters to query, else just return the same URL
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            
            //Manage the URL and its components
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
            
            var queryItems = [URLQueryItem]()
            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))

                queryItems.append(item)
            }
            
            urlComponents.queryItems = queryItems
            
            guard let updatedURL = urlComponents.url else { return url }
            return updatedURL
        }
        
    
     
        return url
    }
    
    
    //DATA
    //Data? must be optional because not all HTTP requests contain a body
    private func getHttpBody() -> Data? {
        
        //First, check if Content-Type header has been set. If not, then returns nil.
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") else { return nil }
        
        //Next, see if any types of interest have been set
        if contentType.contains("application/json") {
            
            //Convert to JSON, return it
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys])
         
            } else if contentType.contains("application/x-www-form-urlencoded") {
         
                //Build a query
                let bodyString = httpBodyParameters.allValues().map { "\($0)=\(String(describing: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))" }.joined(separator: "&")
                return bodyString.data(using: .utf8)
                
            } else {
                
                //All other cases, return the body
                return httpBody
                
            }
    
    }
    
    //URL REQUEST
    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HttpMethod) -> URLRequest? {
        
        //Check if nil or not
        guard let url = url else { return nil }
        
        //Use the URL object to initialize a request
        var request = URLRequest(url: url)
        
        //Assign the http method
        //Must be assigned as a string value, so use raw value
        request.httpMethod = httpMethod.rawValue
        
        
        //Assign headers to request
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue(value, forHTTPHeaderField: header)
        }
        
        request.httpBody = httpBody
        return request

    }

    func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HttpMethod,
                     completion: @escaping (_ result: Results) -> Void) {
        
        //qos is quality of service. We'll make this thread a priority
        //weak self so that we don't crash if restmanager has problems
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            //Append URL query parameters
            let targetURL = self?.addURLQueryParameters(toURL: url)
            
            //get http body
            let httpBody = self?.getHttpBody()
            
            //Create request object
            //IMPORTANT: Must be guard object because request might be empty!
            guard let request = self?.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod) else
            {
                completion(Results(withError: CustomError.failedToCreateRequest))
                return
            }
            
            
            //Create a URL Session object
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: request) { (data, response, error) in
                
                //For data returned from the server, we'll have a response object
                completion(Results(withData: data,
                                   response: Response(fromURLResponse: response),
                                   error: error))
            }
            task.resume()
        }
            
    }
    
    
    //Fetch specific data from a URL
    func getData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else { completion(nil); return }
                completion(data)
            })
            task.resume()
        }
        
    }
    
    
    

}

extension RestManager {
    
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
    
  
    struct RestEntity {
        
        //Response struct's inti will 'add' to this values array variable
        private var values: [String: String] = [:]
     
        mutating func add(value: String, forKey key: String) {
            values[key] = value
        }
     
        func value(forKey key: String) -> String? {
            return values[key]
        }
     
        func allValues() -> [String: String] {
            return values
        }
     
        func totalItems() -> Int {
            return values.count
        }
    }
    
    struct Response {
        var response: URLResponse?
        var httpStatusCode: Int = 0
        var headers = RestEntity()
        
        init(fromURLResponse response: URLResponse?) {
                guard let response = response else { return }
                self.response = response
                httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
         
                if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
                    for (key, value) in headerFields {
                        headers.add(value: "\(value)", forKey: "\(key)")
                    }
                }
            }
        
    }
    
    
    struct Results {
        var data: Data?
        var response: Response?
        var error: Error?
        

        init(withData data: Data?, response: Response?, error: Error?) {
                self.data = data
                self.response = response
                self.error = error
            }
         
            init(withError error: Error) {
                self.error = error
            }
    }
    
    
    
    
    //In case of errors, we can return these types
    //Can be used as argument to the second initializer method of 'Results' struct
    enum CustomError: Error {
        
        //A URLRequest could not be created for some reason
        case failedToCreateRequest
    }
    
    
    
    
    
    
}

//CustomError enum adheres to "Error" protocol, which requires that we provide localized description of error
extension RestManager.CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest: return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        }
    }
}
