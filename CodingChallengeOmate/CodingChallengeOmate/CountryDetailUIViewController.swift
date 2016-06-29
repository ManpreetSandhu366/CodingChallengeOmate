//
//  CountryDetailUIViewController.swift
//  CodingChallengeOmate
//
//  Created by manpreet sandhu on 29/06/2016.
//  Copyright © 2016 ManpreetSandhu. All rights reserved.
//

import UIKit

class CountryDetailUIViewController: UIViewController
{
    // contains country information selected from the country list and information is provided from the perform segue method of MainTableViewController class
    var countrySelected = [[String]]()
    
    // variables to store longitude and latitude from MainTableViewController class and these will be used to display the country on the map
    var Longitute = String()
    var latitude = String()
    
    // outlets to the label to display the information about the country
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var continentLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var coastlineLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var birthRateLabel: UILabel!
    @IBOutlet weak var deathRateLabel: UILabel!
    @IBOutlet weak var lifeExpectancyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting value to the labels, title, longitude and latitude for a country selected from mainTableViewControler class
        self.title = countrySelected[0][0]
        countryCodeLabel.text = countrySelected[0][1]
        continentLabel.text = countrySelected[0][2]
        populationLabel.text = countrySelected[0][3]
        areaLabel.text = countrySelected[0][4]
        coastlineLabel.text = countrySelected[0][5]
        currencyLabel.text = countrySelected[0][6]
        currencyCodeLabel.text = countrySelected[0][7]
        birthRateLabel.text = countrySelected[0][8]
        deathRateLabel.text = countrySelected[0][9]
        lifeExpectancyLabel.text = countrySelected[0][10]
        latitude = countrySelected[0][11]
        Longitute = countrySelected[0][12]
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // prepares segue to load the map
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // destinationSegue contains the control of MapViewController and using it we will assign values to the variables of that class
        let destinationSegue = segue.destinationViewController as! MapsViewController
        
        // assigning values to latitude, longitude, annotation title and annotation sub-title
        destinationSegue._latitude = latitude
        destinationSegue._longitude = Longitute
        destinationSegue._titleToAnnotation = self.title!
        destinationSegue._subTitleToAnnotation = continentLabel.text!
        
    }
    
}
