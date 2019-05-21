//
//  PlacesViewController.swift
//  HanselEvalProject
//
//  Created by Max on 11/16/18.
//  Copyright © 2018 Hansel. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController {
    
    // UIComponents
    @IBOutlet weak var tblPlaces: UITableView!
    // Variables
    var places: [Place]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
    }
    

    @IBAction func onTapAddPlace(_ sender: Any) {
        // Put add a new place code here
    }
    
    func initialize() {
        // Decode places array from JSON
        places = Place.decodeFromJson(filename: "places")
        tblPlaces.reloadData()
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
extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlaceTableViewCell = tableView.dequeueReusableCell(withIdentifier: .IDENTIFIER_PLACES_TABLEVIEWCELL, for: indexPath) as! PlaceTableViewCell
        
        let item: Place? = places?[indexPath.row] as Place?
        // Just add an empty cell if there's no enough data
        guard let place = item else {
            cell.imgPlace.image = nil
            cell.lblSpots.text = "0 spots"
            return cell
        }
        // Otherwise fill UI components with values
        cell.imgPlace.image = UIImage(named: place.placeImageURL ?? "")
        cell.lblSpots.text = String(place.numSpots) + " spots"
        
        return cell
    }
}
