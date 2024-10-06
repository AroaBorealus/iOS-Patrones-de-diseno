//
//  TransformationsTableViewCell.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import UIKit

class TransformationTableViewCell: UITableViewCell {
    static let reuseIdentifier = "TransformationTableViewCell"
    static var nib: UINib { UINib(nibName: "TransformationTableViewCell", bundle: Bundle(for: TransformationTableViewCell.self)) }
    
    @IBOutlet weak var transformationImage: AsyncImageView!
    @IBOutlet weak var transformationName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        transformationImage.cancel()
    }
    
    func setImage(_ characterPhoto: String) {
        self.transformationImage.setImage(characterPhoto)
    }
    
    func setName (_ name: String) {
        self.transformationName.text = name
    }
}
