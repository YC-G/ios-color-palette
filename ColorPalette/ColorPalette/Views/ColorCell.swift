//
//  ColorCell.swift
//  ColorPalette
//
//  Created by Yuchen Guo on 4/6/23.
//

import UIKit

class ColorCell: UITableViewCell {

    @IBOutlet weak var colorChineseNameLabel: UILabel!
    
    @IBOutlet weak var colorEnglishNameLabel: UILabel!
    
    @IBOutlet weak var colorHexValueLabel: UILabel!
    
 
    @IBOutlet weak var colorImageView: UIImageView!
    
    var color: Color? {
        didSet {
            self.colorChineseNameLabel.text = color?.colorChineseName
            self.colorEnglishNameLabel.text = color?.colorEnglishName
            self.colorHexValueLabel.text = color?.colorHexValue
            //self.accessoryType = color!.confirmedSighting ? .checkmark : .none
            //self.backgroundColor = color!.confirmedSave ? UIColor(red: 120/255.0, green: 150/255.0, blue: 200/255.0, alpha: 0.5) : .none
            
            // AccessoryView
            let heart = UIImageView(frame: CGRect(x: 0, y: 65, width: 35, height: 30))
            heart.image = UIImage(systemName: "heart.fill")
            heart.tintColor = .systemRed
            self.accessoryView = color!.confirmedSave ? heart : .none
            
            // DispatchQueue
            DispatchQueue.global(qos:
                    .userInitiated).async {
                        let colorImageData = NSData(contentsOf:
                                                        URL(string: self.color!.imageUrl)!)
                        DispatchQueue.main.async {
                            self.colorImageView.image = UIImage(data: colorImageData as! Data)
                            self.colorImageView.layer.cornerRadius = self.colorImageView.frame.width / 2
                        }
                    }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
