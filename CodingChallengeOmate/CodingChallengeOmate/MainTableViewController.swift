//
//  MainTableViewController.swift
//  CodingChallengeOmate
//
//  Created by manpreet sandhu on 28/06/2016.
//  Copyright © 2016 ManpreetSandhu. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController
{
    // reference to ViewModel and this reference will be used to transfer information to countryVIewController class that which country has been selected by user, so that it can be displayed over there
    var _viewModalCSVObject: ViewModelCSV!
    
    // search controller and it will be used to search the countries from the tableview
    var searchController =  UISearchController(searchResultsController: nil)
    
    // it works along with searchController and stores the countries name that appears during the search
    var filteredCountries = [[String]]()
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // instantiate the object of viewmodel class and pass the name and extension of the file that has to parsed
        _viewModalCSVObject = ViewModelCSV(fileName: "data", typeOf: "csv")
        
        
        // it links the searchController to the tableViewController
        searchController.searchResultsUpdater = self
        
        // it won't let the content dims while the search operation will be performed
        searchController.dimsBackgroundDuringPresentation = false
        
        // it removes the searchbar and its results when any value is selected from the filtered values and displays new view only when its value is true, but if its value is false then it will loads the new view but the searchbar wont disappear
        definesPresentationContext = true
        
        // sets the searchbar to the header of the tableView
        tableView.tableHeaderView = searchController.searchBar
        
        
   }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // return the number of rows
        
        // if searchbar is active, then total number of items will be displayed according to the filtered countries
        if searchController.active && searchController.searchBar.text != ""
        {
            return filteredCountries.count
        }
            // else countries loaded from the viewModel will be displayed
        else
        {
            return _viewModalCSVObject.numberOfCountries
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // creates cell and links it with identifier
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // saves an array of a country from array of arrays
        let country : [String]
        
        // loads country to the cell from filtered search
        if searchController.active && searchController.searchBar.text != ""
        {
            country = filteredCountries[indexPath.row]
        }
            //else country will have data from viewmodel
        else
        {
            country = _viewModalCSVObject.countries[indexPath.row]
        }
        
        
        // cell's textlabel property stores the title of the cell to be displayed and detailed text label stores the subtitle to the cell
        cell.textLabel?.text = country[0] as String
        cell.detailTextLabel?.text = country[2] as String
        
        return cell
    }
    
    // search engine to search countries from viewmodel
    func filteredCountriesForSearchController(searchText: String)
    {
        // compares country name from viewmodel countries using lowercasestring scenario and stores to the filteredCountries is matches
        filteredCountries = _viewModalCSVObject.countries.filter{ country in
        return country[0].lowercaseString.containsString(searchText.lowercaseString)
        }
        
        // refresh the table data to show the search result
        tableView.reloadData()
    }
    
    // segue to load countryViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // index path stores the index of selected cell
        let indexPath = self.tableView.indexPathForSelectedRow!
        
        // destination stores the segue to the countryDetailsViewController to show the information about the countries
        let destination = segue.destinationViewController as! CountryDetailUIViewController
        
        // shows country from filtered countries if the search is active
        if searchController.active && searchController.searchBar.text != ""
        {
            destination.countrySelected.append(filteredCountries[indexPath.row])
        }
            //else show the country details of the country selected from the tableview cell
        else
        {
            destination.countrySelected.append(_viewModalCSVObject.countries[indexPath.row])
        }
    }

}

// mandatory extension to use searchController
extension MainTableViewController: UISearchResultsUpdating
{
    //calls function updateSearchResultsForSearchController everytime when user click on search bar and stores search data in the fileteredCountries array
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredCountriesForSearchController(searchController.searchBar.text!)
    }
}