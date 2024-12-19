//
//  MyKickboardDetailView.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/18/24.
//

import UIKit
import SnapKit

protocol MyKickboardDetailViewDelegate: AnyObject {
    func getKickboardsCount() -> Int
    func getKickboards() -> [Kickboard]
}

final class MyKickboardDetailView: UIView {
    
    weak var modalViewDelegate: ModalViewDelegate?
    weak var delegate: MyKickboardDetailViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.itemSize = .init(width: 350, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
        collectionView.register(MyKickboardDetailViewItem.self, forCellWithReuseIdentifier: MyKickboardDetailViewItem.id)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCollectionView()
        setupLayout()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        
        self.addSubview(self.collectionView)
    }
    
    private func setupLayout() {
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func reloadCellData() {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.reloadData()
        }
    }
}

extension MyKickboardDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = delegate?.getKickboardsCount() else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let kickboards = delegate?.getKickboards(),
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyKickboardDetailViewItem.id, for: indexPath) as? MyKickboardDetailViewItem
        else {
            return UICollectionViewCell()
        }
        
        let kickboard = kickboards[indexPath.item]
        
        cell.insertKickboardImage(type: kickboard.isSaddled)
        cell.updateKickboardInfo(nickName: kickboard.nickName, location: kickboard.address)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let kickboard = delegate?.getKickboards()[indexPath.item],
            let nickName = kickboard.nickName
        else { return }
        self.modalViewDelegate?.editKickboardModalView(kickboard.isSaddled, nickName, kickboard.objectID)
    }
}


