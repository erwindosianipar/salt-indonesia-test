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
    private let imageView = UIImageView().then {
        $0.backgroundColor = .red
    }
    
    private let nameLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    private let emailLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    private let logoutButton = UIButton().then {
        $0.addTarget(self, action: #selector(onTapLogout), for: .touchUpInside)
    }
    
    private var viewModel: HomeViewModel?
    
    let some = UIView().then {
        $0.backgroundColor = .yellow
    }
    
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
    
    private func setupView() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        fetchData()
    }
    
    private func fetchData() {
        self.view.toggleLoadingIndicator()
        self.viewModel?.user()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] response in
                    print("DEBUG", response)
                    self?.view.toggleLoadingIndicator()
                    if response.data.isEmpty {
                        self?.showAlert(title: "Error", message: "Data Not Found", action: nil)
                        return
                    }
                    let data = response.data.filter { $0.email == self?.viewModel?.screenResult.email }
                    self?.setDataView(data: data[0])
                },
                onError: { [weak self] error in
                    self?.view.toggleLoadingIndicator()
                    self?.checkInternetConnection(error: error, action: {
                        self?.fetchData()
                    })
                    print("DEBUG", error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func setDataView(data: UserDataResponseModel) {
        imageView.loadImage(icon: .custom(data.avatar))
        nameLabel.text = "\(data.firstName) \(data.lastName)"
        emailLabel.text = "\(data.email)"
    }
    
    @objc private func onTapLogout() {
        
    }
}
