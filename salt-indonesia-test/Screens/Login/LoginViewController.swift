//
//  LoginViewController.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 20/09/22.
//

import UIKit
import RxSwift

internal final class LoginViewController: ViewController {
    
    private let disposeBag = DisposeBag()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    private let emailTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "Email Address"
        $0.layer.cornerRadius = 3
    }
    
    private let passwordTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "Password"
        $0.layer.cornerRadius = 3
    }
    
    private let submitButton = UIButton().then {
        $0.backgroundColor = .link
        $0.layer.cornerRadius = 3
        $0.setTitle("Login", for: .normal)
        $0.addTarget(self, action: #selector(onTapButtonSubmit), for: .touchUpInside)
    }
    
    private var viewModel: LoginViewModel?
    
    init(viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        setupStackView()
    }
    
    private func setupStackView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(submitButton)
    }
    
    private func login(email: String, password: String) {
        self.view.toggleLoadingIndicator()
        self.viewModel?.login(email: email, password: password)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.view.toggleLoadingIndicator()
                    if response.token.isEmpty {
                        self?.showAlert(title: "Error", message: "User Not Found", action: nil)
                        return
                    }
                    UserDefaultConfig.email = email
                    self?.navigationEvent.send(.next(HomeScreenResult(email: email)))
                },
                onError: { [weak self] error in
                    self?.view.toggleLoadingIndicator()
                    self?.checkInternetConnection(error: error, action: {
                        self?.login(email: email, password: password)
                    })
                }
            )
            .disposed(by: disposeBag)
    }
    
    @objc private func onTapButtonSubmit() {
        if let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty {
            login(email: email, password: password)
            return
        }
        
        self.showAlert(title: "Error", message: "Email and password must be filled", action: nil)
    }
}
