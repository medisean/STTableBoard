//
//  BoardCardCell.swift
//  STTableBoardDemo
//
//  Created by DangGu on 15/12/21.
//  Copyright © 2015年 StormXX. All rights reserved.
//

import UIKit
import STTableBoard

class BoardCardCell: STBoardCell {
    fileprivate lazy var cardView: CardView = {
        let view = CardView()
        view.backgroundColor = UIColor.clear
        return view
    }()

    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor(red: 56/255.0, green: 56/255.0, blue: 56/255.0, alpha: 1.0)
        return label
    }()
    
    fileprivate lazy var checkBoxView: CheckBoxView = {
        let view = CheckBoxView(frame: CGRect.zero)
        view.checked = false
        return view
    }()
    
    fileprivate lazy var avatarView: RoundAvatarImageView = {
        let view = RoundAvatarImageView(frame: CGRect.zero)
        return view
    }()
    
    fileprivate lazy var badgeListView: BadgeListView = {
        let view = BadgeListView()
        return view
    }()
    
    
    
    fileprivate var hasLoadTag: Bool = false
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProperty()
    }
    
    func setupProperty() {
//        backgroundView = backgroundImageView
        contentView.addSubview(cardView)
        cardView.addSubview(checkBoxView)
        cardView.addSubview(avatarView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(badgeListView)
        avatarView.image = UIImage(named: "avatar")
        setupConstrains()
    }
    
    func setupConstrains() {
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        checkBoxView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeListView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["checkBoxView":checkBoxView, "avatarView":avatarView, "titleLabel":titleLabel] as [String : Any]
        
        let leading = 8, trailing = 8, top = 2, bottom = 2
        let cardViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-leading-[cardView]-trailing-|", options: [], metrics: ["leading":leading, "trailing":trailing], views: ["cardView":cardView])
        let cardViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[cardView]-bottom-|", options: [], metrics: ["top":top, "bottom":bottom], views: ["cardView":cardView])
        NSLayoutConstraint.activate(cardViewHorizontalConstraints + cardViewVerticalConstraints)
        
        let checkBoxWidth: CGFloat = 16.0, avatarWidth: CGFloat = 24.0
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-12-[checkBoxView(==checkBoxWidth)]-8-[avatarView(==avatarWidth)]-8-[titleLabel]-10-|", options: [], metrics: ["checkBoxWidth":checkBoxWidth, "avatarWidth":avatarWidth], views: views)
        let checkboxHeightConstraint = NSLayoutConstraint(item: checkBoxView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: checkBoxWidth)
        let avatarHeightConstraints = NSLayoutConstraint(item: avatarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: avatarWidth)
        let checkboxTopConstraint = NSLayoutConstraint(item: checkBoxView, attribute: .top, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1.0, constant: 13.0)
        let avatarTopConstraint = NSLayoutConstraint(item: avatarView, attribute: .top, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1.0, constant: 10.0)
        let titleLabelTopConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1.0, constant: 14.0)
        let badgeListViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-36-[badgeListView]-8-|", options: [], metrics: nil, views: ["badgeListView":badgeListView])
        let badgeListViewTopConstraint = NSLayoutConstraint(item: badgeListView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 12.0)
        
        NSLayoutConstraint.activate(horizontalConstraints + [checkboxHeightConstraint, checkboxTopConstraint, avatarHeightConstraints, avatarTopConstraint, titleLabelTopConstraint, badgeListViewTopConstraint] + badgeListViewHorizontalConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !hasLoadTag {
            cardView.layoutIfNeeded()
            let badge: BadgeView = BadgeView(frame: CGRect.zero)
            badge.image = UIImage(named: "dueDate_icon")
            badge.backgroundImage = UIImage(named: "dueDate_background")
            badge.text = "16 Oct"
            badge.textColor = UIColor.white
            badge.imageWidth = 8.0
            badge.sizeToFit()
            badge.textFont = UIFont.systemFont(ofSize: 10.0)
            
            let bbadge: BadgeView = BadgeView(frame: CGRect.zero)
            bbadge.image = UIImage(named: "tag_icon")
            bbadge.backgroundImage = UIImage(named: "tag_background")
            bbadge.text = "交互设计"
            bbadge.textColor = UIColor.gray
            bbadge.imageWidth = 4.0
            bbadge.sizeToFit()
            bbadge.textFont = UIFont.systemFont(ofSize: 10.0)
            
            let cbadge: BadgeView = BadgeView(frame: CGRect.zero)
            cbadge.image = UIImage(named: "subtask_icon")
            cbadge.imageWidth = 9.0
            cbadge.text = "2/3"
            cbadge.textColor = UIColor.gray
            cbadge.sizeToFit()
            cbadge.textFont = UIFont.systemFont(ofSize: 10.0)
            
            badgeListView.addBadge(badge)
            badgeListView.addBadge(bbadge)
            badgeListView.addBadge(cbadge)
            
            hasLoadTag = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
