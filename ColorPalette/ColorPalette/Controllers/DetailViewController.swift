//
//  DetailViewController.swift
//  ColorPalette
//
//  Created by Yuchen Guo on 4/9/23.
//

import UIKit



class DetailViewController: UIViewController {

    var color: Color!
    
    @IBOutlet weak var colorChineseNameLabel: UILabel!
    
    @IBOutlet weak var colorEnglishNameLabel: UILabel!
    
    @IBOutlet weak var colorHexValueLabel: UILabel!
    
    @IBOutlet weak var colorImageView: UIImageView!
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var view6: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.colorChineseNameLabel.text = "柿红"
        //self.colorEnglishNameLabel.text = "Persimmon Red"
        //self.colorHexValueLabel.text = "F24818"
        print(color)
        // Do any additional setup after loading the view.
        
        self.colorChineseNameLabel.text = color.colorChineseName
        self.colorEnglishNameLabel.text = color.colorEnglishName
        self.colorHexValueLabel.text = color.colorHexValue
        
        // Create a rectangle view
        //let rectangleView = UIView(frame: CGRect(x: 50, y: 700, width: 50, height: 50))
        //rectangleView.backgroundColor = UIColor.blue
        // Add the rectangle view to the main view
        //self.view.addSubview(rectangleView)
        self.view1.backgroundColor = UIColor(hexString: color.colorHexValue)
        self.view1.alpha = 0
        self.view2.backgroundColor = UIColor(hexString: color.colorHexValue)
        self.view2.alpha = 0.2
        self.view3.backgroundColor = UIColor(hexString: color.colorHexValue)
        self.view3.alpha = 0.4
        self.view4.backgroundColor = UIColor(hexString: color.colorHexValue)
        self.view4.alpha = 0.6
        self.view5.backgroundColor = UIColor(hexString: color.colorHexValue)
        self.view5.alpha = 0.8
        self.view6.backgroundColor = UIColor(hexString: color.colorHexValue)
        self.view6.alpha = 1
        
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

// https://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
extension UIColor {
    convenience init?(hexString: String?) {
        let input: String! = (hexString ?? "")
            .replacingOccurrences(of: "#", with: "")
            .uppercased()
        var alpha: CGFloat = 1.0
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        switch (input.count) {
        case 3 /* #RGB */:
            red = Self.colorComponent(from: input, start: 0, length: 1)
            green = Self.colorComponent(from: input, start: 1, length: 1)
            blue = Self.colorComponent(from: input, start: 2, length: 1)
            break
        case 4 /* #ARGB */:
            alpha = Self.colorComponent(from: input, start: 0, length: 1)
            red = Self.colorComponent(from: input, start: 1, length: 1)
            green = Self.colorComponent(from: input, start: 2, length: 1)
            blue = Self.colorComponent(from: input, start: 3, length: 1)
            break
        case 6 /* #RRGGBB */:
            red = Self.colorComponent(from: input, start: 0, length: 2)
            green = Self.colorComponent(from: input, start: 2, length: 2)
            blue = Self.colorComponent(from: input, start: 4, length: 2)
            break
        case 8 /* #AARRGGBB */:
            alpha = Self.colorComponent(from: input, start: 0, length: 2)
            red = Self.colorComponent(from: input, start: 2, length: 2)
            green = Self.colorComponent(from: input, start: 4, length: 2)
            blue = Self.colorComponent(from: input, start: 6, length: 2)
            break
        default:
            NSException.raise(NSExceptionName("Invalid color value"), format: "Color value \"%@\" is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", arguments:getVaList([hexString ?? ""]))
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func colorComponent(from string: String!, start: Int, length: Int) -> CGFloat {
        let substring = (string as NSString)
            .substring(with: NSRange(location: start, length: length))
        let fullHex = length == 2 ? substring : "\(substring)\(substring)"
        var hexComponent: UInt64 = 0
        Scanner(string: fullHex)
            .scanHexInt64(&hexComponent)
        return CGFloat(Double(hexComponent) / 255.0)
    }
}
