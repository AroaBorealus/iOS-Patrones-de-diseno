//
//  DBUnit.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

protocol DBUnit: Codable, Hashable{
    var name: String { get set }
    var photo: String { get set }
    var id: String { get set }
    var description: String { get set }
}
