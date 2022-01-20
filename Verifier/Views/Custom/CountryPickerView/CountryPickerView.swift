//
//  CustomKeyboardkeyView.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 28/08/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class CountryPickerView : BaseUIView {
        
    
    // ------------------------- UI ---------------------------
    
    @IBOutlet var xibContent: UIView!

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
        
    @IBOutlet weak var chevronImageView: UIImageView!
    
    // ===========================================================
    
    public var country : FLCountry? {
        didSet {
            guard let country = country else { return }
            
            flagLabel.text = country.flag
            nameLabel.text = country.name
        }
    }
    
    
    
    override func initViews() {
        super.initViews()
        initFromXib()
    }
    
    
    func initFromXib() {
        let name = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed(name, owner: self, options: nil)
        self.addSubview(xibContent)
        xibContent.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
//        backgroundView.backgroundColor = .gray
        
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.cornerRadius = 3
        
        setColorMode(.black)
    }
    
    override func initBindings() {

    }
    
    
    
    public func setColorMode(_ colorMode : ColorMode) {
        switch colorMode {
        case .white:
            backgroundView.layer.borderColor = UIColor.white.cgColor
            nameLabel.textColor = .white
            chevronImageView.image = UIImage(named: "chevron-white")
        case .black:
            backgroundView.layer.borderColor = UIColor(hexString: "#888888").cgColor
            nameLabel.textColor = .black
            chevronImageView.image = UIImage(named: "chevron-black")
        }
    }
    
    
    public enum ColorMode : String {
        case white
        case black
    }
    
    
}
