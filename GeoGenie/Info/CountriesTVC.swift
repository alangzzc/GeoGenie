//
//  CountriesTVC.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/18/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class CountriesTVC: UITableViewController, UISearchBarDelegate {
    
    var filteredCountries = [Dictionary<String, String>]()
    var isSearchActive = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        //dismiss View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Lets work with one section for now
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredCountries.count > 0 {//if isSearchActive {
            return filteredCountries.count
        } else {
            return (countries?.count)!
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryListCell {
            
            if filteredCountries.count > 0 {//if isSearchActive {
                let country = filteredCountries[indexPath.row]
                cell.configureCell(country: country)
            } else {
                let country = simpleCountries[indexPath.row]
                cell.configureCell(country: country)
            }
            return cell
        } else {
            return CountryListCell() // empty cell
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountries = []
        
        if searchText != "" {
            let searchPredicate = NSPredicate(format: "name CONTAINS[C] %@", searchText)
            let array = (simpleCountries as NSArray).filtered(using: searchPredicate)
            
            for filteredCountriesIndex in 0..<array.count {
                filteredCountries.append(array[filteredCountriesIndex] as! Dictionary<String, String> )
            }
            
            if(filteredCountries.count == 0){
                isSearchActive = false;
            } else {
                isSearchActive = true;
            }
            tableView.reloadData()
        }
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarResultsListButtonClicked")
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarBookmarkButtonClicked")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
        //isSearchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
        //isSearchActive = false;
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        filteredCountries = []
        //isSearchActive = false;
        searchBar.text = ""
        searchBar.endEditing(true)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //isSearchActive = false;
        searchBar.endEditing(true) // dismiss keyboard
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.searchBar
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true) // if user drags, dismiss keyboard
    }

    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredCountries.count > 0 {// if isSearchActive {
            let selectedFilteredCountry = filteredCountries[indexPath.row] as Dictionary<String, String>
            let filteredRowIndex = Int(selectedFilteredCountry["row"]!)
            countryDictionary = countries![filteredRowIndex!]
        } else {
            countryDictionary = countries![indexPath.row]
        }
        
        //countryDictionary = countries![indexPath.row]
        performSegue(withIdentifier: "countryDetailSegue", sender: self)
    }
}
