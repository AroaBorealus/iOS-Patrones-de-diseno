//
//  CharacterDetailViewController.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    let viewModel: CharacterDetailModel
    
    @IBOutlet weak var characterImage: AsyncImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var errorStackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var transformationsButton: UIButton!
    
    
    init(_ viewModel: CharacterDetailModel) {
        self.viewModel = viewModel
        super.init(nibName: "CharacterDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }
    

    func bind(){
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .loading:
                self?.caseLoading()
            case .ready(let selectedCharacter):
                self?.caseReady(selectedCharacter)
            case .error(let reason):
                self?.caseError(reason)
            }
        }
    }
    
    private func caseLoading() {
        activityIndicator.startAnimating()
        characterImage.isHidden = true
        characterDescription.isHidden = true
        characterName.isHidden = true
        errorStackView.isHidden = true
        transformationsButton.isHidden = true
    }
    
    private func caseReady(_ selectedCharacter: DBCharacter) {
        activityIndicator.stopAnimating()
        characterImage.isHidden = false
        characterDescription.isHidden = false
        characterName.isHidden = false
        transformationsButton.isHidden = false
        
        characterName.text = selectedCharacter.name
        characterDescription.text = selectedCharacter.description
        characterImage.setImage(selectedCharacter.photo)
    }
    
    private func caseError(_ reason: String) {
        activityIndicator.stopAnimating()
        errorStackView.isHidden = false
        errorLabel.text = reason
    }
    
    @IBAction func onTransformationsButtonTapped(_ sender: UIButton) {

    }
    
    @IBAction func onRetryButtonTapped(_ sender: UIButton) {
        viewModel.load()
    }
}
