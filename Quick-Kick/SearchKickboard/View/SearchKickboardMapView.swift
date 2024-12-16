//
//  SearchKickboardMapView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit
import MapKit
import SnapKit

final class SearchKickboardMapView: MKMapView {
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.preferredConfiguration = MKHybridMapConfiguration()
        map.showsUserLocation = true
        map.setUserTrackingMode(.follow, animated: true)
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMapView() {
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
