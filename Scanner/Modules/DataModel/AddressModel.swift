//
//  AddressModel.swift
//  Scanner
//
//  Created by Pooja on 24/11/20.
//

import Foundation

struct AddressModel: Codable {
    let status, message: String
    let result: [Result]
}

// MARK: - Result
struct Result: Codable {
    let blockNumber, timeStamp, hash, nonce: String
    let blockHash, transactionIndex, from, to: String
    let value, gas, gasPrice, isError: String
    let txreceiptStatus, input, contractAddress, cumulativeGasUsed: String
    let gasUsed, confirmations: String

    enum CodingKeys: String, CodingKey {
        case blockNumber, timeStamp, hash, nonce, blockHash, transactionIndex, from, to, value, gas, gasPrice, isError
        case txreceiptStatus = "txreceipt_status"
        case input, contractAddress, cumulativeGasUsed, gasUsed, confirmations
    }
}
