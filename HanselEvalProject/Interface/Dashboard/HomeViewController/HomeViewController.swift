//
//  HomeViewController.swift
//  HanselEvalProject
//
//  Created by Max on 11/15/18.
//  Copyright © 2018 Hansel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, SegmentCircleButtonDelegate {

    @IBOutlet weak var segmentButtonPlaces: SegmentCircleButton!
    @IBOutlet weak var segmentButtonFavorites: SegmentCircleButton!
    @IBOutlet weak var segmentButtonFriends: SegmentCircleButton!
    @IBOutlet weak var vwViewControllerContainer: UIView!
    
    var segmentButtonTitles: [String] = ["Places", "Favorites", "Friends"]
    var segmentButtons = [SegmentCircleButton]()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        segmentButtons.append(segmentButtonPlaces)
        segmentButtons.append(segmentButtonFavorites)
        segmentButtons.append(segmentButtonFriends)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Initialze UI related operations
        initializeUI()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: SegmentCircleButtonDelegate Handler
    func didPressButton(_ sender: SegmentCircleButton) {
        // Deactivate all the segment buttons first
        // And activate only the selected one
        for i in 0...(segmentButtons.count - 1) {
            segmentButtons[i].active = false
        }
        sender.active = true
        updateView(indexToChoose: sender.tag)
    }
    
   
    // MARK: Declare Child ViewControllers - Places, Favorites, Friends
    private lazy var placesViewController: PlacesViewController = {
        // Instantiate ViewController
        var viewController = UIStoryboard(name: "Dashboard", bundle: Bundle.main).instantiateViewController(withIdentifier: .IDENTIFIER_PLACES_VIEWCONTROLLER)
        // Add ViewController as Child ViewController
        
        return viewController as! PlacesViewController
    }()
    
    private lazy var favoritesViewController: FavoritesViewController = {
        // Instantiate ViewController
        var viewController = UIStoryboard(name: "Dashboard", bundle: Bundle.main).instantiateViewController(withIdentifier: .IDENTIFIER_FAVORITES_VIEWCONTROLLER)
        // Add ViewController as Child ViewController
        
        return viewController as! FavoritesViewController
    }()
    
    private lazy var friendsViewController: FriendsViewController = {
        // Instantiate ViewController
        var viewController = UIStoryboard(name: "Dashboard", bundle: Bundle.main).instantiateViewController(withIdentifier: .IDENTIFIER_FRIENDS_VIEWCONTROLLER)
        // Add ViewController as Child ViewController
        
        return viewController as! FriendsViewController
    }()
    
    // MARK: Custom Functions
    
    // Initialize UI. Will be called inside of ViewDidAppeaer
    func initializeUI() {
        // Initialize Segment Buttons
        for i in 0...(segmentButtonTitles.count - 1) {
            segmentButtons[i].active = (i == 0)
            segmentButtons[i].delegate = self
            segmentButtons[i].title = segmentButtonTitles[i]
        }
        updateView(indexToChoose: 0)
    }
    
    // Add Child ViewController to Container ViewController
    // 1. Add child viewcontroller to the container viewcontroller by invoking addChild. This will let child viewcontroller automatically receives a message of willMove
    // 2. Add view of Child ViewController to container view
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child ViewController
        addChild(viewController)
        // Add Child view as Subview
        vwViewControllerContainer.addSubview(viewController.view)
        // Configure Child View
        viewController.view.frame = vwViewControllerContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Notify Child ViewController
        viewController.didMove(toParent: self)
    }
    
    // Remove Child ViewController from Container ViewController
    // 1. Notify child viewcontroller that it is about to be removed from the container viewcontroller by sending it a message of willMove()
    // 2. The child viewcontroller's view is removed from the view hierarchy of the container view controller
    // 3. The child viewcontroller is notified that it is removed from the container viewcontroller by sending it a message of removeFromParent
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        // Remove child View From Superview
        viewController.view.removeFromSuperview()
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    // Update interated view based on the selected index
    private func updateView(indexToChoose index: Int) {
        remove(asChildViewController: favoritesViewController)
        remove(asChildViewController: friendsViewController)
        remove(asChildViewController: placesViewController)
        
        switch index {
        case 0:
            add(asChildViewController: placesViewController)
        case 1:
            add(asChildViewController: favoritesViewController)
        case 2:
            add(asChildViewController: friendsViewController)
        default:
            add(asChildViewController: placesViewController)
        }
    }
}
