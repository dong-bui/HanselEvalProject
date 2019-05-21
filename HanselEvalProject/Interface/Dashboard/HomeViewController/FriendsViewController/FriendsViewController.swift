//
//  FriendsViewController.swift
//  HanselEvalProject
//
//  Created by Max on 11/16/18.
//  Copyright © 2018 Hansel. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    // UIComponents
    @IBOutlet weak var tblFriends: UITableView!
    // Variables
    var friends: [Person]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize() {
        // Decode friends array from JSON
        friends = Person.decodeFromJson(filename: "friends")
        tblFriends.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: UITableViewDelegate and UITableViewDataSource
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FriendTableViewCell = tableView.dequeueReusableCell(withIdentifier: .IDENTIFIER_FRIENDS_TABLEVIEWCELL, for: indexPath) as! FriendTableViewCell
        
        // Set follow friend delegate
        cell.delegate = self
        // Get person from the friends array
        let item: Person? = friends?[indexPath.row] as Person?
        // Just add an empty cell if there's no enough data
        guard let friend = item else {
            cell.imgProfile.image = nil
            cell.lblFullName.text = "Unknown"
            cell.lblUserName.text = "@unknown"
            cell.isFollowing = false
            return cell
        }
        // Otherwise fill UI components with values
        cell.imgProfile.image = UIImage(named: friend.profileImageURL ?? "")
        cell.lblFullName.text = friend.fullName
        cell.lblUserName.text = friend.userName
        cell.isFollowing = friend.isFollowing
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69.0
    }
}

// MARK: FollowFriendDelegate
extension FriendsViewController: FollowFriendDelegate {
    func didPressFollowFriendButton(_ sender: FriendTableViewCell) {
        let val: IndexPath? =  tblFriends.indexPath(for: sender)
        guard let indexPath = val else {
            return
        }
        let friend: Person? = friends?[indexPath.row]
        guard var updatedFriend = friend else {
            return;
        }
        
        updatedFriend.isFollowing = sender.isFollowing
        friends?[indexPath.row] = updatedFriend
        tblFriends.reloadRows(at: [indexPath], with: .none)
    }
}
