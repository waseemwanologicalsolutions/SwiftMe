//
//  GooglePlaceSearchTableViewCell.swift
//  TripCon
//
//  Created by MacBook on 22/12/2021.
//

import UIKit

class GooglePlaceSearchTableViewCell: UITableViewCell, DequeueInitializable {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
