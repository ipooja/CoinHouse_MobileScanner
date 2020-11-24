//
//  TransactionViewController.swift
//  Scanner
//
//  Created by Pooja on 24/11/20.
//

import UIKit

class TransactionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataModel: AddressModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Transaction Details"
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


extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataModel else { return 0 }
        return dataSource.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        cell?.configureCell(dataModel.result[indexPath.row].blockNumber, dataModel.result[indexPath.row].hash)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushView = UIStoryboard.loadViewController(storyBoardName: "Main", identifierVC: "DetailTransactionViewController", type: DetailTransactionViewController.self)
        pushView.dataModel = dataModel.result[indexPath.row]
        self.navigationController?.pushViewController(pushView, animated: true)
    }

}
