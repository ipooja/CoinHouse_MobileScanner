//
//  TableViewCell.swift
//  Scanner
//
//  Created by Pooja on 24/11/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var frstLabel: UILabel!
    @IBOutlet weak var scndLabel: UILabel!
    var dataModel: Result!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ frstMsg: String, _ scndMsg: String) {
        frstLabel.text = frstMsg
        scndLabel.text = "To: " + scndMsg
    }
    
    
    func configureDetailCell( _ index: Int, _ frstMsg: String) {
        frstLabel.text = frstMsg
        switch index {
        case 0:
            scndLabel.text = dataModel.blockNumber
        case 1:
            scndLabel.text = dataModel.timeStamp
        case 2:
            scndLabel.text = dataModel.hash
        case 3:
            scndLabel.text = dataModel.nonce
        case 4:
            scndLabel.text = dataModel.blockHash
        case 5:
            scndLabel.text = dataModel.transactionIndex
        case 6:
            scndLabel.text = dataModel.from
        case 7:
            scndLabel.text = dataModel.to
        case 8:
            scndLabel.text = dataModel.value
        case 9:
            scndLabel.text = dataModel.gas
        case 10:
            scndLabel.text = dataModel.gasPrice
        case 11:
            scndLabel.text = dataModel.isError
        case 12:
            scndLabel.text = dataModel.txreceiptStatus
        case 13:
            scndLabel.text = dataModel.contractAddress
        case 14:
            scndLabel.text = dataModel.gasUsed
        case 15:
            scndLabel.text = dataModel.confirmations
        default:
            break
        }
    }
    
}
