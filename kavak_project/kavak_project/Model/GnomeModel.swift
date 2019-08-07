//
//  GnomeModel.swift
//  kavak_project
//
//  Created by Eduardo Fonseca on 8/5/19.
//  Copyright © 2019 Eduardo Fonseca. All rights reserved.
//

import UIKit
/*
 Example:
 
 "id":20,
 "name":"Tinadette Magnarocket",
 "thumbnail":"http://www.publicdomainpictures.net/pictures/10000/nahled/1-1248160685P7iJ.jpg",
 "age":65,
 "weight":35.90778,
 "height":97.65068,
 "hair_color":"Pink",
 "professions":[
 "Farmer",
 "Carpenter",
 "Smelter",
 "Potter",
 "Mason",
 "Leatherworker",
 "Sculptor"
 ],
 "friends":[
 "Whitwright Gimbaltorque",
 "Sarabink Nozzlebooster",
 "Milli Switchrocket",
 "Milli Mystratchet"
 ]
 },
 */

struct RootNode_Brastlewarkon : Decodable,  Hashable {
    let Brastlewark : [Gnome]
}

struct Gnome : Decodable, Hashable {
    let id : Int
    let name : String
    let thumbnail : String
    let age : Int
    let weight : Float
    let height : Float
    let hair_color : Hair_Color
    let professions : [String]?
    let friends : [String]?
}

enum Hair_Color : String, Codable, Hashable {
    case RED = "Red"
    case PINK = "Pink"
    case BLACK = "Black"
    case GRAY = "Gray"
    case GREEN = "Green"
}
