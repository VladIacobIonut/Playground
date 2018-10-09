//
//  MapViewController.swift
//  Mapbox
//
//  Created by Vlad on 13/09/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit
import SnapKit
import Mapbox

final class MapViewController: UIViewController {
    // MARK: - Properties
    
    var presenter: MapPresenter
    private var mapView: MGLMapView
    private let viewModel: MapVM
    private var searchView = SearchView()

    // MARK: - Init
    
    init(presenter: MapPresenter, viewModel: MapVM) {
        mapView = MGLMapView(frame: .zero, styleURL: URL.geoMapURL)
        self.presenter = presenter
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        mapView.frame = view.bounds
        mapView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        setupMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.retrieveMappedRectangles()
    }
    
    // MARK: - Private functions
    
    private func setupMap() {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isOpaque = false
        mapView.setCenter(CLLocationCoordinate2D(latitude: 46.75, longitude: 23.56), zoomLevel: 9, animated: false)
        view.addSubview(mapView)
        mapView.addSubview(searchView)

        mapView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
    
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(20)
        }
        
        searchView.closedTransform = CGAffineTransform(translationX: 0, y: view.bounds.height * 0.7)
//        let instantPan = InstantPanGestureRecognizer()
//        instantPan.addTarget(self, action: #selector(panned(recognizer:)))
//        searchView.addGestureRecognizer(instantPan)
        searchView.transform = searchView.closedTransform
    }
    
    @objc private func panned(recognizer: UIPanGestureRecognizer) {
        
    }
}

// MARK: - MapViewProtocol

extension MapViewController: MapViewProtocol {
    func didRecieveCoordinates() {
        viewModel.polygons.forEach{ self.mapView.addAnnotation($0) }
    }
}

extension MapViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.9
    }
        
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return .blueishBlack
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        guard let tappedPolygon = annotation as? MGLPolygonFeature else {
            return
        }
        let tappedPoint: CGPoint = mapView.convert(tappedPolygon.coordinate, toPointTo: nil)
        presenter.presentReport(for: tappedPolygon, from: CGRect(x: tappedPoint.x, y: tappedPoint.y, width: 10, height: 10))
    }
}
