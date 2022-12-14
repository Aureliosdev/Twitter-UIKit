//
//  ProfileHeader.swift
//  Twitter UIKit
//
//  Created by Aurelio Le Clarke on 23.09.2022.
//

import UIKit

class ProfileHeader: UIView {

    private enum SectionTabs: String {
        case tweets = "Tweets"
        case tweetAndReplies = "Tweet & Replies"
        case media = "Media"
        case likes = "Likes"
        
        var index: Int {
            switch self {
            case .tweets:
                return 0
            case .tweetAndReplies:
                return 1
            case .media:
                return 2
            case .likes:
                return 3
            }
        }
    }
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
    
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(displayP3Red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        
        return view
    }()
    
    
    private var selectedTab: Int = 0 {
        didSet {
            for i in 0..<tabs.count {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [ weak self] in
                    self?.sectionStack.arrangedSubviews[i].tintColor = i == self?.selectedTab ? .label : .secondaryLabel
                    self?.leadingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.trailingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.layoutIfNeeded()
                } completion: { _ in
                    
                }

            }
        }
    }
    
    
    //Multiple buttons in horizontal stack
    private var  tabs: [UIButton] = ["Tweets","Tweet & Replies","Media","Likes"].map { buttonTitle in
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .label
        return button
    }
    
    private lazy var sectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    private let followersTextLabel: UILabel = {
        let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.text = "Followers"
          label.textColor = .secondaryLabel
          label.font = .systemFont(ofSize: 14,weight: .regular)
          return label
          
        
    }()
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10M"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
        
        
        
    }()
    
    private let followingTextLabel: UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Following"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
        
    }()
    
    
    private let followingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14,weight: .bold)

        return label
    }()
    
    
    private let joinDataImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        image.tintColor = .secondaryLabel
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let joinDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Joined in 23 of September 2015"
        label.textColor = .secondaryLabel
       
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
        
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@Aurelio Le Clarke"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18,weight: .regular)
        return label
        
    }()
    
    private let userBioLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .label
        label.text = "Welcome to my profile!"
        return label
        
    }()
    
    private let displayName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Abylay"
        label.textColor = .label
        label.font = .systemFont(ofSize: 22,weight: .bold)
        return label
    
    }()
     
    
    private let profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.image = UIImage(named: "police")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        
        return imageView
    }()
    
    private let profileImageHeader: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.image = UIImage(named: "Korea5")
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(profileImageHeader)
        addSubview(profileAvatarImageView)
        addSubview(displayName)
        addSubview(userName)
        addSubview(userBioLabel)
        addSubview(joinDataImageView)
        addSubview(joinDateLabel)
        addSubview(followingCountLabel)
        addSubview(followersTextLabel)
        addSubview(followingTextLabel)
        addSubview(followersCountLabel)
        addSubview(sectionStack)
        addSubview(indicator)
        ProfileHeaderApplyConsts()
        configureStackButtons()
    
    }
    
    
    private func ProfileHeaderApplyConsts() {
        for i in 0..<tabs.count {
            let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].leadingAnchor)
            leadingAnchors.append(leadingAnchor)
            let trailingAnchor = indicator.trailingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].trailingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
        let profileImageHeaderConsts = [
        profileImageHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
        profileImageHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
        profileImageHeader.topAnchor.constraint(equalTo: topAnchor),
        profileImageHeader.heightAnchor.constraint(equalToConstant: 180)
      
       ]
        
      
  
    let profileAvatarConsts = [
        profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
        profileAvatarImageView.centerYAnchor.constraint(equalTo: profileImageHeader.bottomAnchor,constant: 10),
        profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
        profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80)
    
    ]
        
    let displayLabeConsts = [
        displayName.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
        displayName.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor,constant: 5),
    
    
    ]
        
    let userNameConsts = [
        userName.leadingAnchor.constraint(equalTo:  displayName.leadingAnchor),
        userName.topAnchor.constraint(equalTo: displayName.bottomAnchor,constant: 10)
    ]
        
    let userBioConsts = [
        userBioLabel.leadingAnchor.constraint(equalTo:  displayName.leadingAnchor),
        userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5),
        userBioLabel.topAnchor.constraint(equalTo: userName.bottomAnchor,constant: 5)
    ]
    
        let joinDataConsts = [
            joinDataImageView.leadingAnchor.constraint(equalTo: displayName.leadingAnchor),
            joinDataImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor,constant: 5),
        
        ]
        
        let joinDateConsts = [
            joinDateLabel.leadingAnchor.constraint(equalTo: joinDataImageView.trailingAnchor,constant: 2),
            joinDateLabel.bottomAnchor.constraint(equalTo: joinDataImageView.bottomAnchor)
        ]
        
        let followingCountConsts = [
            followingCountLabel.leadingAnchor.constraint(equalTo: displayName.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor,constant: 10)
        ]
        let followingTextConsts = [
            followingTextLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor,constant: 5),
            followingTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor)
        ]
        
        let followerCountConsts = [
            followersCountLabel.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor,constant: 8),
            followersCountLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor)
        ]
        
        let followersTextConsts = [
            followersTextLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor,constant: 5),
            followersTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor)
        ]
        let sectionStackConsts = [
            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 25),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -25),
            sectionStack.topAnchor.constraint(equalTo: followersCountLabel.bottomAnchor,constant: 5),
            sectionStack.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let indicatorConsts = [
            leadingAnchors[0],
            trailingAnchors[0],
            indicator.topAnchor.constraint(equalTo: sectionStack.arrangedSubviews[0].bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ]
        NSLayoutConstraint.activate(profileImageHeaderConsts)
        NSLayoutConstraint.activate(profileAvatarConsts)
        NSLayoutConstraint.activate(displayLabeConsts)
        NSLayoutConstraint.activate(userNameConsts)
        NSLayoutConstraint.activate(userBioConsts)
        NSLayoutConstraint.activate(joinDataConsts)
        NSLayoutConstraint.activate(joinDateConsts)
        NSLayoutConstraint.activate(followingCountConsts)
        NSLayoutConstraint.activate(followingTextConsts)
        NSLayoutConstraint.activate(followerCountConsts)
        NSLayoutConstraint.activate(followersTextConsts)
        NSLayoutConstraint.activate(indicatorConsts)
        NSLayoutConstraint.activate(sectionStackConsts)
    }
    
    private func configurecCOnstraints() {
     
    }
    
    private func configureStackButtons() {
        for(i,button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            button.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
            
            if i == selectedTab {
                button.tintColor = .label
            }else {
                button.tintColor = .secondaryLabel
            }
        }
    }
    
    
    @objc private func didTapTab(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text else { return }
        switch label {
        case SectionTabs.tweets.rawValue:
            selectedTab = 0
        case SectionTabs.tweetAndReplies.rawValue:
            selectedTab = 1
        case SectionTabs.media.rawValue:
            selectedTab = 2
        case SectionTabs.likes.rawValue:
            selectedTab = 3
        default:
            selectedTab = 0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




}
