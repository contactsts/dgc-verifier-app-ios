//
//  CollectionView.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 20/06/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }
    
    
    func setEmptyMessageWithIllustration(_ message: String, imageName: String) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        
        let contentView = UIView(frame: .zero)
        view.addSubview(contentView)
        
        
        let messageLabel = UILabel(frame: .zero)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
//        messageLabel.backgroundColor = .red
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 14)
//        messageLabel.sizeToFit()

        
        let illustrationImage = UIImageView(frame: .zero)
        illustrationImage.image = UIImage(named: imageName)
        illustrationImage.alpha = 0.7

        

        contentView.addSubview(messageLabel)
        contentView.addSubview(illustrationImage)
//        contentView.backgroundColor = .gray
        

        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        
        
        illustrationImage.snp.makeConstraints { make in
            
            make.width.height.equalTo(view.snp.width).multipliedBy(0.9)
            make.leading.trailing.top.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(illustrationImage.snp.bottom).offset(20)
        }
        messageLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        
//        view.backgroundColor = .cyan
        
        
//        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
//        messageLabel.text = message
//        messageLabel.textColor = .black
//        messageLabel.numberOfLines = 0;
//        messageLabel.textAlignment = .center;
//        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
//        messageLabel.sizeToFit()

        self.backgroundView = view;
    }

    func restore() {
        self.backgroundView = nil
    }
}
