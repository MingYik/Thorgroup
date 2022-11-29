//
//  VGBaseController.swift
//  Voghion
//
//  Created by apple on 2022/6/23.
//

import UIKit

class VGBaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addAllSubviews()
        addAllConstraints()
        customBackBarButtomItem()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    
    // MARK: - UI Component
    func addAllSubviews(){//子类实现子视图添加
    }
    
    func addAllConstraints(){//子类实现视图约束方法
    }
    
    private func customBackBarButtomItem() {
        if navigationController == nil { return }
        if (navigationController?.viewControllers.count)! < 2 { return }
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect.init(x: 0, y: 0, width:44, height: 44)
        backBtn.addTarget(self, action: #selector(navigationBarBackAction), for: .touchUpInside)
        let backImage = UIImage(named: "nav_back_base")
        backBtn.setImage(backImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        backBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 22)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
    }
    
    open func customRightBarButtonItem(with title: String? = nil, image: UIImage? = nil) {
        let rightBtn = UIButton(type: .custom);
        if let btnTitle = title {
            rightBtn.setTitle(btnTitle, for: .normal)
        }else {
            if let btnImage = image {
                rightBtn.setImage(btnImage, for: .normal)
            }
        }
        rightBtn.addTarget(self, action: #selector(navigationBarRightAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }

    
    @objc func navigationBarBackAction(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func navigationBarRightAction(){
        navigationController?.popViewController(animated: true)
    }

    deinit {
    }

}
