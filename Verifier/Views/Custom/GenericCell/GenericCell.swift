//
//  GamesListCollectionViewCell.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 7/28/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import UIKit
import SnapKit
import Nuke
import RxSwift
import RxCocoa
import SwiftDate
import LTHRadioButton

//protocol GameCellEvents {
//    func onGameCellEvent(rowIndex: Int?, game: Game?)
//}

class GenericCell: BaseUICollectionViewCell {
    
    
    @IBOutlet var xibContent: UIView!
    
    @IBOutlet weak var moveImageView: UIImageView!
    @IBOutlet weak var selectedRadioButton: LTHRadioButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    var disposeBag = DisposeBag()
    
    // ---------------------------------------------
    

    
    
    override func initViews() {
        super.initViews()
        
        Bundle.main.loadNibNamed("GenericCell", owner: self, options: nil)
        self.contentView.addSubview(xibContent)
        xibContent.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
    }
    
    
    
    
}
