//
//  Country.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/19/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class Country {
    
    var name:            String!  { didSet {if name == nil {name = ""}}}
    var topLevelDomain: [String]! { didSet {if topLevelDomain == nil {topLevelDomain = [""]}}}
    var alpha2Code:      String!  { didSet {if alpha2Code == nil {alpha2Code = ""}}}
    var alpha3Code:      String!  { didSet {if alpha3Code == nil {alpha3Code = ""}}}
    var callingCodes:   [String]! { didSet {if callingCodes == nil {callingCodes = [""]}}}
    var capital:         String!  { didSet {if capital == nil {capital = ""}}}
    var altSpellings:   [String]! { didSet {if altSpellings == nil {altSpellings = [""]}}}
    var region:          String!  { didSet {if region == nil {region = ""}}}
    var subregion:       String!  { didSet {if subregion == nil {subregion = ""}}}
    var population:      Double!  { didSet {if population == nil {population = 0.0}}}
    var latlng:         [Double]! { didSet {if latlng == nil {latlng = [0.0]}}}
    var demonym:         String!  { didSet {if demonym == nil {demonym = ""}}}
    var area:            Double!  { didSet {if area == nil {area = 0.0}}}
    var gini:            Double!  { didSet {if gini == nil {gini = 0.0}}}
    var timezones:      [String]! { didSet {if timezones == nil {timezones = [""]}}}
    var borders:        [String]! { didSet {if borders == nil {borders = [""]}}}
    var nativeName:      String!  { didSet {if nativeName == nil {nativeName = ""}}}
    var numericCode:     String!  { didSet {if numericCode == nil {numericCode = ""}}}
    var currencies:   [Dictionary<String, String>]! { didSet {if currencies == nil {currencies = [["" : ""]]}}}
    var languages:    [Dictionary<String, String>]! { didSet {if languages == nil {languages = [["":""]]}}}
    var translations:  Dictionary<String, String>!  { didSet {if translations == nil {translations = ["":""]}}}
    var flag:            String!  { didSet {if flag == nil {flag = ""}}}
    var flagImg:         String!  { didSet {if flagImg == nil {flagImg = ""}}}
    var flagTxt:         String!  { didSet {if flagTxt == nil {flagTxt = ""}}}
    var regionalBlocs: [Dictionary<String, Any>]! { didSet {if regionalBlocs == nil {regionalBlocs = [["" : ""]]}}}
    var cioc:            String!  { didSet {if cioc == nil {cioc = ""}}}
    
    init(countryDictionary: Dictionary<String, Any>) {
        let countryName = countryDictionary["name"]! as? String
        //if let mainKey = countryDictionary["main"] as? Dictionary<String, String> {
            //if let countryName = mainKey["name"] {
                self.name = countryName
                //self.lowTemp = "\(minTempKelvinToCelsius)"
            }
        //}
    //}
    
}
