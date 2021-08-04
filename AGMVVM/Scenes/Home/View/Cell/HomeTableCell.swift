//
//  HomeTableCell.swift
//  AGMVVM
//
//  Created by ahmed gado on 04/08/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import UIKit
protocol HomeDetailsCellView   {
    func displayData(price : String , name : String , number : String)
}
class HomeTableCell: UITableViewCell , HomeDetailsCellView{
  

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func displayData(price: String, name: String, number: String) {
        priceLabel.text = price
        nameLabel.text = name
        numberLabel.text = number
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
