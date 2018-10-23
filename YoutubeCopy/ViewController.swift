//
//  ViewController.swift
//  YoutubeCopy
//
//  Created by tax_k on 22/10/2018.
//  Copyright © 2018 tax_k. All rights reserved.
//

import UIKit

fileprivate let homeCellId:String = "cellId"


class BaseCell:UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }
}

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var barStyle = UIStatusBarStyle.lightContent
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return barStyle
    }
    
    func setUpNavigationBarTitleImage() {
        
        let navController = navigationController!
        
        let image = UIImage(named: "yt_logo_rgb_dark.png")!
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = Colors.darkBackColor
        navigationItem.title = "Home"
        
        setUpNavigationBarTitleImage()
        
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: homeCellId)
        collectionView?.contentInset = UIEdgeInsetsMake(40, 0, 50, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(40, 0, 50, 0)
        
        setupBottomMenuBar()
        setupTopMenuBar()
        
        barStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    let topBar:navBarView = {
        let bar = navBarView()
        return bar
    }()
    
    func setupTopMenuBar(){
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topBar.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        topBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
    }
    
    let menuBar:MenuBar = {
        let bar = MenuBar()
        return bar
    }()
    
    
    func setupBottomMenuBar(){
        view.addSubview(menuBar)
//        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
//        view.addConstraintWithFormat(format: "V:|[v0(50)]", views: menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        
        menuBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        menuBar.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 16 - 16 ) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class navBarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = Colors.darkBackColor
        setupViews()
    }
    
    let logoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 20, y: 35, width: 100, height: 22)
        imageView.image = UIImage(named: "yt_logo_rgb_dark.png")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let separatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.alpha = 0.3
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(logoImageView)
        addSubview(separatorView)
        
        addConstraint(NSLayoutConstraint(item: separatorView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: separatorView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: separatorView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: separatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 1))
    }
}

class VideoCell: BaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let thumbnailImgView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "venom.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView:UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile.jpg")
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "VENOM - Official Trailer 2 (HD)"
//        label.textColor = UIColor(hue: 0, saturation: 0, brightness: 93.3, alpha: 1)
        label.textColor = Colors.titleLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleView:UITextView = {
        let textView = UITextView()
        textView.text = "Sony Pictures Entertainment - 조회수 55,529,568회"
        textView.textColor = Colors.subtitleLabelColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    let separatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.alpha = 0.3
        
        return view
    }()
    
    override func setupViews(){
        addSubview(thumbnailImgView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleView)
        addSubview(separatorView)
        
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImgView)
        addConstraintWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        // vertical constraint
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImgView, userProfileImageView, separatorView)
        addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImgView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImgView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        addConstraint(NSLayoutConstraint(item: subTitleView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subTitleView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subTitleView, attribute: .right, relatedBy: .equal, toItem: thumbnailImgView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitleView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
//        addConstraintWithFormat(format: "V:[v0(20)]", views: titleLabel)
//        addConstraintWithFormat(format: "H:|[v0]|", views: titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func addConstraintWithFormat(format: String, views: UIView...){
        
        var viewDictionary = [String: UIView]()
        for (index, value) in views.enumerated(){
            let key = "v\(index)"
            value.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = value
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions() , metrics: nil, views: viewDictionary))
    }
}

