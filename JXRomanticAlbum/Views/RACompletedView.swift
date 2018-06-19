//
//  RACompletedView.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import Lottie

class RACompletedView: UIView {
    var againCallback: (()->())?

    deinit {
        againCallback = nil
    }

    init() {
        super.init(frame: CGRect.zero)

        backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true

        let animationView = LOTAnimationView(name: "completed")

        animationView.loopAnimation = true
        addSubview(animationView)
        animationView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(animationView.snp.width)
                .multipliedBy(0.6)
        }
        animationView.play()

        let btn = UIButton(type: .custom)
        btn.setTitle("再来一次", for: .normal)
        btn.addTarget(self, action: #selector(againButtonClicked(btn:)), for: .touchUpInside)
        btn.backgroundColor = UIColor.cyan
        addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }



    @objc func againButtonClicked(btn: UIButton) {
        againCallback?()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
