//
//  EventsTableViewCell.swift
//  EventBrowser
//
//  Created by Deniz Sagmanli on 18.12.2021.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
