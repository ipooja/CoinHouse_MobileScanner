//  Copyright © 2019 Pooja  . All rights reserved.

import Foundation

class NetworkExecutor: ServiceRequestExecutable {
    func excuteRequest(_ request: URLRequest, completion: @escaping ServiceRequestDataTaskCompletion) -> ServiceCancellable {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20.0
        configuration.timeoutIntervalForResource = 20.0
        let session = URLSession(configuration: configuration)
        let dataTask = session.dataTask(with: request) { (data, urlResponse, error) in
            print("\nThis is cURL⤵️\n" + request.cURL() + "\n")
            print("This is URL⤵️\n" + (request.url?.absoluteString ?? "") + "\n")
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("This is the response json⤵️\n" + jsonString + "\n")
                }
            }
            completion(data, (urlResponse as? HTTPURLResponse), error)
        }
        dataTask.resume()
        return URLSessionWrapper(dataTask: dataTask)
    }
}

class URLSessionWrapper: ServiceCancellable {

    private let dataTask: URLSessionDataTask

    init(dataTask: URLSessionDataTask) {

        self.dataTask = dataTask
    }

    func cancel() {
        dataTask.cancel()
    }

    deinit {
        dataTask.cancel()
    }
}


extension URLRequest {
    
    public func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""

        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key,value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        
        return cURL
    }
}
