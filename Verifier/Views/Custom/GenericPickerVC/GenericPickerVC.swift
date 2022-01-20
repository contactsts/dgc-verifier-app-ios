//
//  GenericTableViewController.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 12/25/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture



public struct GenericPickerItem : Equatable {
    
    
//    public static func == (lhs: GenericPickerItem, rhs: GenericPickerItem) -> Bool {
//        return lhs.id == rhs.id
//    }
    
    var id : String?
    
    var title : String?
    var subtitle : String?
    
    var image : UIImage?
    
    var isDraggable = false
    var isSelectable = true
}

enum GenericPickerMode {
    case single, multi
}




class GenericPickerVC: BaseViewController {
    
    
    // ------------------------- UI ---------------------------
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    lazy var collectionView: UICollectionView = {
//        let view = CollectionViewUtils.getDefaultCollectionView()
//        view.delegate = self
//        view.dataSource = self
//        view.register(GenericCell.self, forCellWithReuseIdentifier: "GenericCell")
//        return view
//    }()
    
    var navigationSaveButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
        return view
    }()
    
    // ------------------------- PRIVATE ---------------------------
    
    var titleStackViewText: String?
    var subtitleStackViewText: String?
    
    //    var viewModel: GameTemplateRoundTypeSelectionVM!
    
    var list: [GenericPickerItem] = []
    var selectedItem : [GenericPickerItem] = []
    var mode : GenericPickerMode
    public var showDoneButton = true
    
    let disposeBag = DisposeBag()
    
    let result = BehaviorRelay<[GenericPickerItem]>(value: [])
    
    // ===========================================================================================
    
    init(list: [GenericPickerItem], selectedItem: [GenericPickerItem] = [], mode: GenericPickerMode = .single) {
        //        viewModel = GameTemplateRoundTypeSelectionVM(gameTemplateRoundTypeObject: gameTemplateRoundTypeObject)
        self.list = list
        self.selectedItem = selectedItem
        self.mode = mode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ===========================================================================================
    
    
    override func initViews() {
        CollectionViewUtils.configureCollectionView(collectionView: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GenericCell.self, forCellWithReuseIdentifier: "GenericCell")
    }
    
    // ===========================================================================================
    
    override func initLayout() {
        
    }
    
    // ===========================================================================================
    
    
    override func bindToViewModel() {
        navigationSaveButton.rx.tap.subscribe(onNext: { _ in
            self.result.accept(self.selectedItem)
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    // ===========================================================================================
    
    override func bindFromViewModel() {
        //        viewModel.gameTemplateRouteTypesList.subscribe( onNext:  { [weak self] value in
        //            self?.collectionView.reloadData()
        //            self?.titleStackViewSubtitle.text = "\(value.count ?? 0) round type(s)"
        //        }).disposed(by: disposeBag)
    }
    
    // ===========================================================================================
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
//        let title = (self.viewModel.gamesListVCInput.gamesListVCInputMode == .navigate) ? "Games list" : "Select a game"
//        self.titleStackViewTitle.text = title
        
        if (self.showDoneButton) {
            navigationItem.rightBarButtonItems = [navigationSaveButton]
        }
        
        title = titleStackViewText
        
//        titleStackViewLabel.text = titleStackViewText
//        subtitleStackViewLabel.text = subtitleStackViewText
        
//        titleStackViewLabel.isHidden = (titleStackViewText == nil)
//        subtitleStackViewLabel.isHidden = (subtitleStackViewText == nil)
        
//        navigationController?.navigationBar.backItem?.title = ""
//        self.navigationController?.navigationBar.topItem?.title = "";
    }
    

    
    
    
    
}



extension GenericPickerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenericCell", for: indexPath) as! GenericCell
        let listItem = list[indexPath.row]
        
        
        //        let isSelected = (listItem.id == selectedItem?.id )
        let isSelected = selectedItem.contains(where: { $0.id == listItem.id } )
        if isSelected {
            cell.selectedRadioButton.select()
        } else {
            cell.selectedRadioButton.deselect()
        }
        
        if listItem.isSelectable {
            cell.selectedRadioButton.isHidden = false
        } else {
            cell.selectedRadioButton.isHidden = true
        }
        
        
        if listItem.isDraggable {
            cell.moveImageView.isHidden = false
        } else {
            cell.moveImageView.isHidden = true
        }
        
        
        if listItem.image != nil {
            cell.imageView.isHidden = false
            cell.imageView.image = listItem.image!
        } else {
            cell.imageView.isHidden = true
        }
        
        if listItem.title != nil {
            cell.titleLabel.isHidden = false
            cell.titleLabel.text = listItem.title!
        } else {
            cell.titleLabel.isHidden = true
        }
        
        
        if listItem.subtitle != nil {
            cell.subtitleLabel.isHidden = false
            cell.subtitleLabel.text = listItem.subtitle!
        } else {
            cell.subtitleLabel.isHidden = true
        }
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listItem = list[indexPath.row]
//        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        if mode == .single {
            selectedItem = [listItem]
            result.accept(selectedItem)
            self.navigationController?.popViewController(animated: true)
        } else if mode == .multi {
            let isSelected = selectedItem.contains(where: { $0.id == listItem.id } )
            if isSelected {
                selectedItem = selectedItem.filter( { $0.id != listItem.id } )
            } else {
                selectedItem.append(listItem)
            }
        }
        collectionView.reloadItems(at: [indexPath])
//        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let desiredHeight = CGFloat(50)
        //        let desiredWidth = ( collectionView.bounds.size.width - 12) / 2.0
        let desiredWidth = collectionView.bounds.size.width
        return CGSize(width: desiredWidth, height: desiredHeight)
    }
    
    
    
}
