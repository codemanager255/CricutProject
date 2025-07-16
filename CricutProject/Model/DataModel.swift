//
//  DataModel.swift
//  CricutProject
//
//  Created by Arpit Mallick on 6/17/25.
//

import Foundation

struct ShapeModel: Decodable {
    let buttons: [ShapeButton]
}

struct ShapeButton: Decodable {
    let name: String
    let drawPath: String
    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
}

extension ShapeButton: Identifiable {
    var id: UUID {
        return UUID()
    }
}
