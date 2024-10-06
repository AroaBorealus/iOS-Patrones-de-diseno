//
//  TransformationsListViewController.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 6/10/24.
//

import UIKit

class TransformationsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let viewModel: TransformationsListModel
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorStackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    
    init(_ viewModel: TransformationsListModel) {
        self.viewModel = viewModel
        super.init(nibName: "TransformationsListView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TransformationTableViewCell.nib, forCellReuseIdentifier: TransformationTableViewCell.reuseIdentifier)
        
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
        viewModel.transformations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransformationTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? TransformationTableViewCell {
            let transformation = viewModel.transformations[indexPath.row]
            cell.setImage(transformation.photo)
            cell.setName(transformation.name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row < viewModel.transformations.count else {
            return
        }
        let transformationFound = viewModel.transformations[indexPath.row]
        self.navigationController?.show(TransformationDetailBuilder(transformationFound).build(), sender: nil)
//        self.present(CharacterDetailBuilder(characterInfo).build(), animated: true)
    }
}
