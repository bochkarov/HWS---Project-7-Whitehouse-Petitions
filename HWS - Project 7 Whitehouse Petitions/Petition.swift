//
//  Petition.swift
//  HWS - Project 7 Whitehouse Petitions
//
//  Created by Bochkarov Valentyn on 16/08/2020.
//  Copyright © 2020 Bochkarov Valentyn. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
