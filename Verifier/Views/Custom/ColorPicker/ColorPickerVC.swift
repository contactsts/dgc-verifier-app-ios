//
//  GamesListVC.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 7/28/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RealmSwift
//import JGProgressHUD
//import SwipeCellKit


class ColorPickerVC: BaseViewController {
    
    
    lazy var cancelLabel: UILabel = {
        let view = UILabel()
        view.text = "Cancel"
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = .black
        return view
    }()
    
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Select predefined image"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    
    lazy var horizontalDivider: UIView =  {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.init(hexString: "#")
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = CollectionViewUtils.getDefaultCollectionView()
        
        let flow = view.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        
        view.register(ColorPickerCell.self, forCellWithReuseIdentifier: "ColorPickerCell")
        
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    
    // ===========================================================
    
    
    let result = PublishSubject<MaterialColor?>()
    
    var viewModel: ColorPickerVM!
    let disposeBag = DisposeBag()
    
    // ====================================================================
    
    
    init(selectedColor: MaterialColor? = nil) {
        viewModel = ColorPickerVM(selectedColor: selectedColor)
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ====================================================================
    
    
    
    override func initViews() {
        super.initViews()
        self.view.backgroundColor = .white
        
        
        self.view.addSubview(cancelLabel)
        self.view.addSubview(titleLabel)
        
        self.view.addSubview(horizontalDivider)
        
        self.view.addSubview(collectionView)
    }
    
    
    // ====================================================================
    
    
    override func initLayout() {
        super.initLayout()
        
        cancelLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        
        horizontalDivider.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(horizontalDivider.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-1 * 90)
        }
    }
    
    // ====================================================================
    
    
    override func bindToViewModel() {
        cancelLabel.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            self?.result.onNext(nil)
        }).disposed(by: disposeBag)
    }
    
    // ====================================================================
    
    
    override func bindFromViewModel() {
        
    }
    
    
    // ====================================================================
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Color pick"
    }
    
    // ===========================================================
    
}


// CollectionView related methods
extension ColorPickerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemsCount = viewModel.colorsList.value.count
        
        if (itemsCount == 0) {
            //            self.collectionView.setEmptyMessage("Nothing to show :(")
            self.collectionView.setEmptyMessageWithIllustration("Nothing to show ...", imageName: "empty2.png")
        } else {
            self.collectionView.restore()
        }
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorPickerCell", for: indexPath) as! ColorPickerCell
        let currentColor = viewModel.colorsList.value[indexPath.row]
        cell.materialColor = currentColor
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedColor = viewModel.colorsList.value[indexPath.row]
        result.onNext(selectedColor)
        //        result.onCom
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let desiredHeight = CGFloat(70)
        let desiredWidth = (collectionView.bounds.size.width - 10 ) / 5
        let desiredHeight = desiredWidth * 1.3
        return CGSize(width: desiredWidth, height: desiredHeight)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//       return UIEdgeInsets(top: 25, left: 15, bottom: 0, right: 5)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
    
    
    // ====================================================================
    
}





extension ColorPickerVC {
    

    
}
