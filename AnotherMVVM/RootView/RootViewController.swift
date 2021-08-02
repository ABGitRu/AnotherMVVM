//
//  RootViewController.swift
//  AnotherMVVM
//
//  Created by Mac on 02.08.2021.
//

import TinyConstraints

class RootViewController: UIViewController {
    
    var viewModel: RootViewModel! {
        didSet {
            navigationItem.title = "\(viewModel.user.name), \(viewModel.user.age)"
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = ConstantMessages.defaultMessage.rawValue
        label.backgroundColor = .black
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .gray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.rootViewModelDelegate = self
        
        setupNavigation()
        setupViews()
    }
    
    private func setupNavigation() {
        let resetBarButtonItem = UIBarButtonItem(title: ConstantTitles.reset.rawValue,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(resetBarButtonItemTapped))
        let fetchBarButtonItem = UIBarButtonItem(title: ConstantTitles.fetch.rawValue,
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(fetchBarButtonItemTapped))
        
        navigationItem.setLeftBarButton(resetBarButtonItem,
                                        animated: false)
        navigationItem.setRightBarButton(fetchBarButtonItem,
                                         animated: false)
    }
    
    @objc private func resetBarButtonItemTapped() {
        label.text = ConstantMessages.defaultMessage.rawValue
    }
    
    @objc private func fetchBarButtonItemTapped() {
        viewModel.fetchMessage()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(activityIndicator)
        label.centerInSuperview()
        activityIndicator.topToBottom(of: label, offset: 12)
        activityIndicator.centerXToSuperview()
    }
    
}
extension RootViewController: RootViewModelDelegate {
    
    func didStartFetchingMessage(_ message: String?) {
        label.text = message
        activityIndicator.startAnimating()
    }
    
    func didFinishFetchingMessage(_ message: String?) {
        label.text = message
        activityIndicator.stopAnimating()
    }
}

