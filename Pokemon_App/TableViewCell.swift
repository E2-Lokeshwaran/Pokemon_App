//
//  TableViewCell.swift
//  Pokemon_App
//
//  Created by Lokeshwaran on 05/08/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var PokemonImage: UIImageView!
    @IBOutlet weak var PokemonType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
