//
//  NewColorViewController.swift
//  ColorPalette
//
//  Created by Yuchen Guo on 5/24/23.
//

import UIKit

class NewColorViewController: UIViewController {
    
    var newColorHexValue: String!

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorView.backgroundColor = UIColor(hexString: self.newColorHexValue)
        self.colorLabel.text = self.newColorHexValue
        self.colorView.layer.cornerRadius = self.colorView.frame.width / 2
    }
    
    

}
