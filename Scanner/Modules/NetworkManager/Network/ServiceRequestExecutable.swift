//  Copyright © 2019 Pooja  . All rights reserved.

import Foundation

typealias ServiceRequestDataTaskCompletion = (Data?, HTTPURLResponse?, Error?) -> Void

protocol ServiceRequestExecutable: class {
    func excuteRequest(_ request: URLRequest, completion: @escaping ServiceRequestDataTaskCompletion) -> ServiceCancellable
}
