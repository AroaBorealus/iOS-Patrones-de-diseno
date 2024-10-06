//
//  CharacterTableViewCell.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CharacterTableViewCell"
    static var nib: UINib { UINib(nibName: "CharacterTableViewCell", bundle: Bundle(for: CharacterTableViewCell.self)) }
    
    @IBOutlet weak var characterImage: AsyncImageView!
    @IBOutlet weak var characterName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.cancel()
    }
    
    func setImage(_ characterPhoto: String) {
        self.characterImage.setImage(characterPhoto)
    }
    
    func setName (_ name: String) {
        self.characterName.text = name
    }

}
