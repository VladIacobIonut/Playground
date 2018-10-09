//
//  DetailsViewController.swift
//  MapEstate
//
//  Created by Vlad on 14/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit
import SnapKit

final class DetailsViewController: UIViewController {
    // MARK: - Properties
    
    var dismissTapped: VoidClosure?
    private let backgroundView = UIView()
    private let ownerLabel = UILabel()
    private let idLabel = UILabel()
    private let scrollView = UIScrollView()
    private let instructionsView = UIView()
    private let likeButton = UIButton()
    private var presenter: DetailsPresenter
    private var isLiked: Bool = false {
        didSet {
            likeButton.setImage(isLiked ? #imageLiteral(resourceName: "like") : #imageLiteral(resourceName: "unlike"), for: .normal)
        }
    }
    private let tableView = UITableView()
    private let tableViewContent = ["This property is free of charge ✅", "Situated in a good spot", "Very appropiate if you have children because it's close to many schools and universities", "Nice view 🏞", "Lovely location by the artificial lake, surrounded by brand new building with nice restaurants and bars where you can enjoy your night. The room was clean. Comfortable bad with good quality bedding. A large selection of food for breakfast 🇷🇴", "Quick overnight stay here on our way back home. Hotel very new and staff friendly. Breakfast included and good selection. You can park out front to check in but then drive 5 min to underground garage at back of hotel, so quick walk back.,", "Consistently good quality of the Hampton hotel chain. Clean and comfy room. Working desk with ergonomic office chair in the room. Coffee&tea set in the room. Tasty and varied breakfast with an option to eat it on the terrace outside. Wonderful location next to the lakeside promenade with plenty of restaurants, bars but also bikepaths and walking/running tracks. Easy to reach by public transport (subway & train station 4mins walk)."]
    
    // MARK: - Init
    
    init(presenter: DetailsPresenter) {
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
    
        setupUI()
        presenter.retrieveDetailsForCurrentProperty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateEntrance()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.persistDetails(for: isLiked)
    }
        
    // MARK: - Private functions
    
    private func setupUI() {
        view.backgroundColor = .clear
        view.addSubview(backgroundView)
        view.addSubview(scrollView)
        scrollView.addSubview(instructionsView)
        instructionsView.addSubview(tableView)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 150))
        headerView.addSubview(ownerLabel)
        headerView.addSubview(idLabel)
        headerView.addSubview(likeButton)
        headerView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        
        backgroundView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        instructionsView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(500)
            $0.height.equalTo(700)
        }
        
        ownerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(20)
        }

        idLabel.snp.makeConstraints {
            $0.leading.equalTo(ownerLabel.snp.leading)
            $0.bottom.equalTo(ownerLabel.snp.top)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        ownerLabel.text = "Owner"
        ownerLabel.numberOfLines = 2
        ownerLabel.textAlignment = .center
        ownerLabel.font = UIFont.ceraPro(size: 34)
        ownerLabel.textColor = UIColor.black
        
        idLabel.text = "ID"
        idLabel.textAlignment = .center
        idLabel.font = UIFont.ceraPro(size: 17)
        idLabel.textColor = UIColor.lightGray
        
        likeButton.setImage(#imageLiteral(resourceName: "unlike"), for: .normal)
        likeButton.addTarget(self, action: #selector(toogleLikeButton), for: .touchUpInside)
        
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        
        instructionsView.backgroundColor = .white
        instructionsView.clipsToBounds = true
        instructionsView.layer.cornerRadius = 0
        
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
        
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "standardCell")
        
        instructionsView.addShadow(opacity: 0.5, color: UIColor.black.cgColor)
    }
    
    func presentIn(containerVC: UIViewController?) {
        guard let containerVC = containerVC else { return }
        containerVC.view.endEditing(true)
        modalTransitionStyle = .crossDissolve
        containerVC.present(self, animated: true, completion: nil)
    }
    
    @objc private func dismissView() {
        presenter.persistDetails(for: isLiked)
        animateEntranceOut()
    }
    
    @objc private func toogleLikeButton() {
        isLiked.toogle()
    }
    
    private func animateEntrance() {
        instructionsView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.backgroundView.alpha = 0.6
            self.instructionsView.layer.cornerRadius = 15
        }
    }
    
    private func animateEntranceOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.instructionsView.transform = CGAffineTransform(translationX: 0, y: self.instructionsView.frame.height)
            self.backgroundView.alpha = 0
        }) { _ in
            self.dismissTapped?()
        }
    }
    
    private func handleBackgroundAlpha(for percent: CGFloat) {
        guard !scrollView.isDecelerating else {
            return
        }
        if percent < 0 {
            backgroundView.alpha -= 0.01
            backgroundView.alpha = backgroundView.alpha < 0 ? 0 : backgroundView.alpha
        }
    }
}

// MARK: - DetailsViewProtocol

extension DetailsViewController: DetailsViewProtocol {
    func didRecieveDetails(for current: Property) {
        ownerLabel.text = current.owner
        idLabel.text = "\(current.id)"
    }
}

// MARK: - UIScrollViewDeletegate

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY >= 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            return
        }
        
        handleBackgroundAlpha(for: contentOffsetY)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.6
        }
    
        guard velocity.y < -2 else {
            targetContentOffset.pointee = CGPoint(x: 0, y: 0)
            return
        }

        animateEntranceOut()
    }
}

// MARK: - TableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "standardCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .darkGray
        cell.textLabel?.font = UIFont.ceraPro(size: 17)
        let comment = NSMutableAttributedString()
        let user = NSAttributedString(string: "Vlad \n ", attributes: [NSAttributedString.Key.font : UIFont.ceraPro(size: 17),
                                                                          NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        let commentText = NSAttributedString(string: tableViewContent[indexPath.row], attributes: [NSAttributedString.Key.font : UIFont.ceraPro(size: 17),
                                                                                                 NSAttributedString.Key.foregroundColor : UIColor.black])
        comment.append(user)
        comment.append(commentText)
        cell.textLabel?.attributedText = comment
        return cell
    }
}


extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
