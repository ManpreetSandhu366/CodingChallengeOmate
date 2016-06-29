//
//  ViewModelCSV.swift
//  CodingChallengeOmate
//
//  Created by manpreet sandhu on 28/06/2016.
//  Copyright © 2016 ManpreetSandhu. All rights reserved.
//

import Foundation

class ViewModelCSV
{
    // array to save all countries and each row will have different country record
    var countries: [[String]]
    
    // stores number of countries
    var numberOfCountries: Int
    
    
    
    // initialize method
    init(fileName: String, typeOf: String)
    {
        // initializes variable
        self.countries  = [[String]]()
        self.numberOfCountries = Int()
        
        // parse csv file 
        parseCSVFile(fileName, type: typeOf)
    }
    
    
    
    
    func parseCSVFile(fileName:String, type:String)
    {
        // gets the file path
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: type)
        
        // filemanager helps to access file
        let fileManager = NSFileManager.defaultManager()
        
        // checks if file exist or not
        if fileManager.fileExistsAtPath(path!)
        {
            // getting the content of the csv file in one string can throws exception, to handle that exception we use do-tryCatch
            do
            {
                // encodes the file data into a string
                let csvString = try String(contentsOfFile: path!, encoding: NSMacOSRomanStringEncoding)
                
                // converts the string into an array which will have only one row
                let csvArraywithSingleRow = csvString.componentsSeparatedByString("\n") as [String]
                
                // converts into array having multiple rows and each index will contains particular country's data as a single string
                let csvArrayWithMultipleRows = csvArraywithSingleRow[0].componentsSeparatedByString("\r")
                
                // for loop will help to save data in an array of arrays which later will be used to populate in tableview. Index of for loop starts with 1 as csvArrayWithMultipleRows[0] contains header of the csv
                for index in 1..<csvArrayWithMultipleRows.count
                {
                    // converts each row of csvArrayWithMultipleRows into an array as it was as a string before and it will be required as an array later when we have to show whole details of each country
                    let countryDetails = csvArrayWithMultipleRows[index].componentsSeparatedByString(",")
                    
                    // counrties is an array of array and each row contains detail of a country
                    countries.append(countryDetails)
                }
                
                // stores number of countries which we will display as the title of the app
                numberOfCountries = countries.count
            }
                // catches error if thrown while converting csv file into string
            catch let er as NSError
            {
                // prints error message
                print(er)
            }
        }

    }
    
    
    
}