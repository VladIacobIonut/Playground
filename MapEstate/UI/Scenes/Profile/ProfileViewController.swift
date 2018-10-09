//
//  ProfileViewController.swift
//  Mapbox
//
//  Created by Vlad on 13/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Properties
    private let addBtn = CustomButton()
    private let tableView = UITableView()
    private var viewModel: ProfileViewModel
    private var presenter: ProfilePresenter
    
    // MARK: - Init
    
    init(viewModel: ProfileViewModel, presenter: ProfilePresenter) {
        self.viewModel = viewModel
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter.retrieveExamples()
        setupVC()
    }
    
    // MARK: - Private Functions
    
    private func setupVC() {
        view.backgroundColor = UIColor.black
        navigationItem.title = "Examples"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.register(ExampleCell.self, forCellReuseIdentifier: "ExampleCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - TableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell") as? ExampleCell else {
            return UITableViewCell()
        }

        cell.viewModel = viewModel.examples[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.presentExample(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func didProvidedExamples() {
        
    }
}
