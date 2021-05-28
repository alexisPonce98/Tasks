//
//  customCellTableViewCell.swift
//  Tasks
//
//  Created by  on 5/27/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import UIKit

class customCellTableViewCell: UITableViewCell {
    
    static let identifier = "MyTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "customCellTableViewCell", bundle: nil)
    }
    
    public func configure(title:String, image: UIImage?, time:String){
        myLabel.text = title
        if image != nil{
            MyImage.image = image
        }
        myTime.text = time
    }
    @IBOutlet var myLabel: UILabel!
    @IBOutlet weak var MyImage: UIImageView!
    @IBOutlet var myTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
