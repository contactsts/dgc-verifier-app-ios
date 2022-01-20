//
//  BaseViews.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 1/3/20.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import SwipeCellKit


protocol UIViewControllerGuide {
    func initViews()
    func initLayout()
    func bindToViewModel()
    func bindFromViewModel()
}

protocol UIViewGuide {
    func initViews()
    func initLayout()
    func initBindings()
}


extension UIViewController {
    
    func setupNavigationAppearence() {
//        self.navigationController?.navigationBar.barTintColor = .white
//        self.navigationController?.navigationBar.tintColor = .black
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back-arrow")?.alpha(0.6)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back-arrow")?.alpha(0.6)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    
}


class BaseViewController: UIViewController, UIViewControllerGuide {
    
//    var titleStackViewText: String?
//    var subtitleStackViewText: String?
    
    lazy var titleStackViewLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "Title"
        view.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    lazy var subtitleStackViewLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "Subtitle"
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .gray
        return view
    }()
    
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackViewLabel, subtitleStackViewLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        //        initViews()
        //        initLayout()
        //        bindToViewModel()
        //        bindFromViewModel()
    }
    
    func presentInNavigationController(from rootViewController: UIViewController) {
        let navCon = NavigationController(rootViewController: self, useNavigationBar: true)

        if UIDevice.current.isSmallScreenPhone {
            navCon.modalPresentationStyle = .fullScreen
        }

        rootViewController.present(navCon, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationAppearence()
//        navigationItem.titleView = titleStackView
        
        initViews()
        initLayout()
        bindFromViewModel()
        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if titleStackViewText != nil {
//            titleStackViewLabel.text = titleStackViewText
//        }
//
//        if subtitleStackViewText != nil {
//            subtitleStackViewLabel.text = subtitleStackViewText
//        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
    }
    
    func initLayout() {
    }
    
    func bindToViewModel() {
    }
    
    func bindFromViewModel() {
    }
}


class BaseFormViewController: FormViewController, UIViewControllerGuide {
    
    
    lazy var titleStackViewLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "Title"
        view.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    lazy var subtitleStackViewLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "Subtitle"
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .gray
        return view
    }()
    
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackViewLabel, subtitleStackViewLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    
    init() {
        super.init(style: .plain)
    }
    
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationAppearence()
        navigationItem.titleView = titleStackView
        
        initViews()
        initLayout()
        bindFromViewModel()
        bindToViewModel()
    }
    
    
    
    func initViews() {
    }
    
    func initLayout() {
    }
    
    func bindToViewModel() {
    }
    
    func bindFromViewModel() {
    }
}


class BaseUITableViewCell: UITableViewCell, UIViewGuide {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.cellInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellInit()
    }
    
    func cellInit() {
        self.initViews()
        self.initLayout()
        self.initBindings()
    }
    
    
    func initViews() {
    }
    
    func initLayout() {
    }
    
    func initBindings() {
    }
}





public class BaseUICollectionViewCell: UICollectionViewCell, UIViewGuide {
    
    var cellBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var bottomDivider: UIView = {
        return UIViewUtils.getDivider()
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.cellInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellInit()
    }
    
    
    func cellInit() {
        self.initViews()
        self.initLayout()
        self.initBindings()
    }
    
    
    func initViews() {
        self.contentView.addSubview(cellBackground)
        cellBackground.addSubview(bottomDivider)
    }
    
    func initLayout() {
        cellBackground.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets.init(top: 0 , left: 0, bottom: 0, right: 0))
        }
        
        bottomDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func initBindings() {
    }
}



class BaseSwipeCollectionViewCell : SwipeCollectionViewCell, UIViewGuide {
    
    var cellBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var bottomDivider: UIView = {
        return UIViewUtils.getDivider()
    }()
    
    // --------------------------------------
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.cellInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellInit()
    }
    
    
    func cellInit() {
        self.initViews()
        self.initLayout()
        self.initBindings()
    }
    
    
    func initViews() {
        //        self.contentView.addSubview(cellBackground)
        self.contentView.addSubview(bottomDivider)
    }
    
    func initLayout() {
        //        cellBackground.snp.makeConstraints { make in
        //            make.edges.equalTo(self).inset(UIEdgeInsets.init(top: 0 , left: 0, bottom: 0, right: 0))
        //        }
        
        bottomDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func initBindings() {
    }
}



protocol XibViewProtocol {
    var xibContent: UIView! { get }

    func inflate(customViewName: String)
}

extension XibViewProtocol where Self : UIView {
    
}





class BaseUIView : UIView, UIViewGuide {
    
     
//    var xibContent: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cellInit()
    }
    
    func cellInit() {
        self.initViews()
        self.initLayout()
        self.initBindings()
    }
    
    
    func initViews() {
    }
    
    func initLayout() {
    }
    
    func initBindings() {
    }
    
    func initFromXib2(view: UIView) {
        let name = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed(name, owner: self, options: nil)
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))
        }
    }
    
    
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
    
}










