//
//  TableViewHeader.swift
//  ColorPalette
//
//  Created by Yuchen Guo on 5/15/23.
//



import UIKit

class TableViewHeader: UIView {

    /*
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        //iv.image = UIImage(named: "footer image")
        iv.tintColor = .label
        return iv
    }()
     */
    let text: UITextView = {

        let attributedString = NSMutableAttributedString(string: "For thousands of years, all aspects of the Han nationality’s traditional culture, including clothing, architecture, painting, jade, porcelain, crafts, etc., have been associated with colors, and they have also shown the past. We listing here 526 colors, the original data collection from \"Color Name Dictionary\", published by Chinese Acadamy of Science in 1957.\n\nSelect colors by swipe cells left and light up the red heart. Unselect colors by swipe cells left and darken the red heart. Click the submit button to see the mixed color from your selected colors!")
        attributedString.addAttribute(.link, value: "http://zhongguose.com/", range: (attributedString.string as NSString).range(of: "Color Name Dictionary"))
        
        let txt = UITextView()
        txt.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        txt.backgroundColor = .clear
        txt.attributedText = attributedString
        txt.textColor = .label
        txt.isSelectable = true
        txt.isEditable = false
        txt.isScrollEnabled = false
        txt.delaysContentTouches = false
        txt.font = UIFont.systemFont(ofSize: 20)
        return txt
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.text.delegate = colorListViewController.self
        self.addSubview(text)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            text.widthAnchor.constraint(equalToConstant: 350),
            text.heightAnchor.constraint(equalToConstant: 480)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }

}


extension TableViewHeader: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        UIApplication.shared.open(URL)
        return false
    }
}
            




