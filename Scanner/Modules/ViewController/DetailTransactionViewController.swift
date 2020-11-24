//
//  DetailTransactionViewController.swift
//  Scanner
//
//  Created by Pooja on 24/11/20.
//

import UIKit

class DetailTransactionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataModel: Result!
    var cellKeys = ["blockNumber", "timeStamp", "hash", "nonce", "blockHash", "transactionIndex", "from", "to", "value", "gas", "gasPrice", "isError", "txreceipt_status", "contractAddress", "cumulativeGasUsed", "gasUsed", "confirmations"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        // Do any additional setup after loading the view.
    }
    
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DetailTransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = dataModel else { return 0 }
        return cellKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        cell!.dataModel = dataModel
        cell?.configureDetailCell(indexPath.row, cellKeys[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

