//
//  TopTableViewCell.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/11.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import UIKit
import SnapKit

final class TopTableViewCell: UITableViewCell {
    
    lazy var userImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "apple")
        v.layer.cornerRadius = 3
        v.clipsToBounds = true
        contentView.addSubview(v)
        return v
    }()
    lazy var nameLabel: UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.text = "hello world"
        contentView.addSubview(v)
        return v
    }()
    lazy var nextImageView: UIImageView = {
        let v = UIImageView(image: UIImage(named: "next"))
        contentView.addSubview(v)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        
    }
    
    func makeConstraints() {
        userImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(60)
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.left.equalTo(userImageView.snp.right).offset(30)
            make.centerY.equalTo(userImageView.snp.centerY)
        }
        nextImageView.snp.makeConstraints { make in
            make.centerY.equalTo(userImageView.snp.centerY)
            make.right.equalToSuperview().offset(-20)
        }
    }
}
