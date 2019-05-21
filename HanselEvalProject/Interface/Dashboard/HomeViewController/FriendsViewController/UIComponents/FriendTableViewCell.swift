//
//  FriendTableViewCell.swift
//  HanselEvalProject
//
//  Created by Max on 11/16/18.
//  Copyright © 2018 Hansel. All rights reserved.
//

import UIKit

protocol FollowFriendDelegate {
    func didPressFollowFriendButton(_ sender: FriendTableViewCell)
}

class FriendTableViewCell: UITableViewCell {

    // UIComponents
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    
    // Variables
    var delegate:FollowFriendDelegate!
    
    // Change follow button style based on the value
    var isFollowing: Bool = false {
        didSet {
            btnFollow.borderWidth = isFollowing ? 1 : 0
            btnFollow.setTitleColor(isFollowing ? .FOLLOW_COLOR : .UNFOLLOW_COLOR, for: .normal)
            btnFollow.setTitle(isFollowing ? "Follow" : "Unfollow", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func onTapFollow(_ sender: Any) {
        isFollowing = !isFollowing
        delegate.didPressFollowFriendButton(self)
    }
}
