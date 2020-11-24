//  Copyright © 2019 Pooja  . All rights reserved.

import Foundation

/// Protocol for any class to be represented as a JSON
protocol JSONRepresentable {
    func jsonObject() -> [String: Any]
    func jsonData() -> Data
}

// MARK: - Default implementation any implementation with Encodable conditional conformance.
extension JSONRepresentable where Self: Encodable {
    func jsonObject() -> [String: Any] {
        let json = try! JSONSerialization.jsonObject(with: self.jsonData(), options: .mutableContainers) as! [String: Any]
        return json
    }

    func jsonData() -> Data {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(self)
        return data
    }
}

typealias ServiceRequestRepresentable = JSONRepresentable & Encodable
typealias ServiceResponseRepresentable = Decodable
typealias ServiceRequestResponseRepresentable = JSONRepresentable & Codable

let appDomain: String = "com.google.com"
