//
//  HomeViewController.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let viewModel: HomeViewModel
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorStackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HomeView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CharacterTableViewCell.nib, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
        
        viewModel.load()
    }
    
    
    func bind(){
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .loading:
                self?.caseLoading()
            case .ready:
                self?.caseReady()
            case .error(let reason):
                self?.caseError(reason)
            }
        }
    }
    
    private func caseLoading() {
        errorStackView.isHidden = true
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func caseReady() {
        errorStackView.isHidden = true
        tableView.isHidden = false
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    private func caseError(_ reason: String) {
        errorStackView.isHidden = false
        tableView.isHidden = true
        activityIndicator.stopAnimating()
        errorLabel.text = reason
    }
    
    @IBAction func onRetryButtonTapped(_ sender: UIButton) {
        viewModel.load()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? CharacterTableViewCell {
            let character = viewModel.characters[indexPath.row]
            cell.setImage(character.photo)
            cell.setName(character.name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row < viewModel.characters.count else {
            return
        }
        let characterFound = viewModel.characters[indexPath.row]
        let characterInfo = CharacterInfo(characterName: characterFound.name, characterId: characterFound.id)
        self.navigationController?.show(CharacterDetailBuilder(characterInfo).build(), sender: nil)
    }
    
    
}
