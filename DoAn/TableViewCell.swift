//
//  TableViewCell.swift
//  DoAn
//
//  Created by Lê Hoàng Sinh on 05/02/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(name: String) {
        lblName.text = name
    }

}
