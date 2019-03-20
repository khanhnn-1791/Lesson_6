//
//  ItemCell.swift
//  parse_json
//
//  Created by nguyen.nam.khanh on 3/20/19.
//  Copyright © 2019 nguyen.nam.khanh. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var isPrivateLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    internal var object: Object! {
        didSet{
            nameLabel.text = object.name
            typeLabel.text = object.type
            isPrivateLabel.text = isPrivate()
            createdLabel.text = dateToString( object.created_at)
            setImage(object.avatar_url)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    private func isPrivate() -> String {
        if object.isPrivate == true {
            isPrivateLabel.textColor = .yellow
            return "private"
        }
        isPrivateLabel.textColor = .green
        return "public"
    }
    private func dateToString(_ created: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: created)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MMM-yyyy"
        let str = outputFormatter.string(from: date!)
        return  str
    }
    private func setImage(_ urlString: String) {
        if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
            avatarImageView.image = UIImage(data: data)
    }
   
    }
//2019-02-15T18:14:38Z
}
