//
//  LoginViewController.swift
//  AppPatronesAroa
//
//  Created by Aroa Miguel Garcia on 3/10/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    init(_ loginViewModel: LoginViewModel) {
        self.viewModel = loginViewModel
        super.init(nibName: "LoginView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        bind()
    }
    
    private func bind(){
        viewModel.onStateChanged.bind { [weak self] loginState in
            switch loginState {
            case .logging:
                self?.caseLogging()
            case .ready:
                self?.caseReady()
            case .error(let reason):
                self?.caseError(reason)
            }
        }
    }
    
    private func caseLogging() {
        loginButton.isHidden = true
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
    }
    
    private func caseReady() {
        loginButton.isHidden = false
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
        self.present(HomeBuilder().build(), animated: true)
    }
        
    private func caseError(_ reason: String) {
        loginButton.isHidden = false
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
        errorLabel.text = reason
    }
    
    
    @IBAction private func onLoginButtonTapped(_ sender: UIButton) {
        viewModel.login(emailTextField.text, passwordTextField.text)
    }
}
