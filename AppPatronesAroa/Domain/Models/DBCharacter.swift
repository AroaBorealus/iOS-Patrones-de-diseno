//
//  DBCharacter.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import Foundation

struct DBCharacter: DBUnit{
    var name: String
    var photo: String
    var id: String
    var description: String
    let favorite: Bool
}

// Este es un ejemplo de como usar Coding Keys

struct CustomCodableCharacter: Codable {
    let nombreCompleto: String
    let fotoURL: String
    let id: String
    let descripcion: String
    let favorito: Bool
}

extension CustomCodableCharacter {
    enum CodingKeys: String, CodingKey {
        case nombreCompleto = "name"
        case fotoURL = "photo"
        case id = "id"
        case descripcion = "description"
        case favorito = "favorite"
    }
}
