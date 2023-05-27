//
//  TableViewFooter.swift
//  ColorPalette
//
//  Created by Yuchen Guo on 5/15/23.
//

import UIKit

class TableViewFooter: UIView {
    
    var onButtonClicked: (()->Void)?

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("submit", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        self.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
     
                                    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    @objc private func didTapButton() {
        self.onButtonClicked?()
        
    }
                                    
}
