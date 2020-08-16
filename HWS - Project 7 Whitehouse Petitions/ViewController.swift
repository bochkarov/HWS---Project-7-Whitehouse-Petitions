//
//  ViewController.swift
//  HWS - Project 7 Whitehouse Petitions
//
//  Created by Bochkarov Valentyn on 16/08/2020.
//  Copyright © 2020 Bochkarov Valentyn. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            //            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            //            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            } else {
                showError()
            }
        } else {
            showError()
        }
        
        //alternative variant
        //        if let url = URL(string: urlString) {
        //            if let data = try? Data(contentsOf: url) {
        //                parse(json: data)
        //                return
        //            }
        //        }
        //
        //        showError()
    }
    
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showSearchAlertController() {
        
        let searchAlertController = UIAlertController(title: "Filter", message: "", preferredStyle: .alert)
        
        searchAlertController.addTextField { (searchText) in
            searchText.placeholder = "Enter text"
            let text = searchText.text
            let filteredPetitions = petitions.filter($0.contains(text))
        }
        
        let okayAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            let filteredPetitions = petitions.filter()
        }

   
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        
        searchAlertController.addAction(okayAction)
        searchAlertController.addAction(cancelAction)
        
        self.present(searchAlertController, animated: true, completion: nil)
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    @IBAction func creditsButtonTaped(_ sender: UIBarButtonItem) {
        //        let creditsAlertController = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        //        creditsAlertController.addAction(UIAlertAction(title: "OK", style: .default))
        //        present(creditsAlertController,animated: true)
        showSearchAlertController()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

