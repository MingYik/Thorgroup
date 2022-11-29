//
//  ProfileViewController.swift
//  UINavigationController
//
//  Created by HongXiangWen on 2018/12/18.
//  Copyright © 2018年 WHX. All rights reserved.
//

import UIKit
import Kingfisher
import KingfisherWebP

class ProfileViewController: VGBaseController,UITableViewDataSource,UITableViewDelegate {
    
    lazy var headerView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.image = UIImage.init(named: "sunset")
        return imgView
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.backgroundColor = .white
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.showsVerticalScrollIndicator = false
        table.contentInsetAdjustmentBehavior = .never
        return table
    }()

    lazy var gifImgView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 30, y: 120, width: 45, height: 30))
        let path = Bundle.main.path(forResource:"referral", ofType:"gif")
        if let gifPath = path {
            let gifUrl = URL(fileURLWithPath: gifPath)
            let provider = LocalFileImageDataProvider(fileURL: gifUrl)
            imageView.kf.setImage(with: provider)
        }
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - UI Component
    override func addAllSubviews() {
        view.addSubview(self.tableView)
        let headerFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 0.75)
        self.headerView.frame = headerFrame
        tableView.tableHeaderView = headerView
        customRightBarButtonItem(with: "PopToRoot")
    }
    
    override func addAllConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func adjustHeaderFrame() {
        var imageWidth = view.bounds.width
        var imageHeight = imageWidth * 0.75
        var originY: CGFloat = 0
        let contentOffsetY = tableView.contentOffset.y
        if contentOffsetY < 0 {
            originY += contentOffsetY
            imageHeight -= contentOffsetY
            imageWidth = imageHeight / 0.75
        }
        let headViewFrame = CGRect(x: (view.bounds.width - imageWidth) / 2, y: originY, width: imageWidth, height: imageHeight)
        headerView.frame = headViewFrame
        tableView.reloadData()
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idfCell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let cell = (idfCell ?? (UITableViewCell.init(style: .subtitle, reuseIdentifier: "UITableViewCell")))
        cell.textLabel?.text = "个人中心 \(indexPath.row + 1)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let barHiddenVC = ViewController()
        navigationController?.pushViewController(barHiddenVC, animated: true)
    }

    // MARK: - Main Method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let headerHeight = view.bounds.width * 0.75
//        let contentOffsetY = scrollView.contentOffset.y
//        let progress = min(1, max(0, contentOffsetY / headerHeight))
        adjustHeaderFrame()
    }
    
    override func navigationBarRightAction() {
        navigationController?.popToRootViewController(animated: true)
    }

}
