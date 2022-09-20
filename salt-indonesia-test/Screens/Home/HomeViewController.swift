//
//  HomeViewController.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 19/09/22.
//

import UIKit
import RxSwift

internal final class HomeViewController: ViewController {
    
    private let disposeBag = DisposeBag()
    private let scrollView = UIScrollView()
    private let imageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    private let nameLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
    }
    
    private let emailLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    private let logoutButton = UIButton().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 5
        $0.setTitle("Logout", for: .normal)
        $0.addTarget(self, action: #selector(onTapLogout), for: .touchUpInside)
    }
    
    private var viewModel: HomeViewModel?
    
    init(viewModel: HomeViewModel) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func setupLargeTitleAndSearchView() {
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func setupView() {
        setupLargeTitleAndSearchView()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.trailing.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(logoutButton)
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(34)
        }
        
        fetchData()
    }
    
    private func fetchData() {
        self.view.toggleLoadingIndicator()
        self.viewModel?.user()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.view.toggleLoadingIndicator()
                    if response.data.isEmpty {
                        self?.showAlert(title: "Error", message: "Data Not Found", action: nil)
                        return
                    }
                    if let data = response.data.first(where: { $0.email == self?.viewModel?.screenResult.email }) {
                        self?.setDataView(data: data)
                    }
                },
                onError: { [weak self] error in
                    self?.view.toggleLoadingIndicator()
                    self?.checkInternetConnection(error: error, action: {
                        self?.fetchData()
                    })
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func setDataView(data: UserDataResponseModel) {
        imageView.loadImage(url: data.avatar)
        nameLabel.text = "\(data.first_name) \(data.last_name)"
        emailLabel.text = "\(data.email)"
    }
    
    @objc private func onTapLogout() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else {
            return
        }
        UserDefaultConfig.email = ""
        let loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator.start()
    }
}
