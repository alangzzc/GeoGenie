//
//  DataSource.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/19/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import Foundation

// FIRST TASK IS TO DESERIALIZE JSON FILE
let path = Bundle.main.path(forResource: "CountriesInfo", ofType: "json")
let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe) // try
let countries = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? Array<Dictionary<String, Any>>

var totalNumberOfQuestions: Int = 0
var babyMode: Bool = false

var simpleCountries = [Dictionary<String, String>]()
var countryDictionary = Dictionary<String, Any>()
var regions = ["Africa","Americas","Asia","Europe","Oceania","Polar"]
var africanSubregions = ["Eastern Africa","Middle Africa","Northern Africa","Southern Africa","Western Africa"]
var americanSubregions = ["Caribbean","Central America","Northern America","South America"]
var asianSubregions = ["Central Asia","Eastern Asia","South-Eastern Asia","Southern Asia","Western Asia"]
var europeanSubregions = ["Eastern Europe","Northern Europe","Southern Europe","Western Europe"]
var oceaniaSubregions = ["Australia and New Zealand","Melanesia","Micronesia","Polynesia"]

