//
//  ProgressView.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import UIKit
import MapKit

class ProgressView: UIView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    
    var isScanView: Bool
    var cancelHandler: (()->())?
    
    var headingText: String? {
        willSet {
            self.noteLabel.text = newValue ?? ""
        }
    }
    
    override init(frame: CGRect) {
        isScanView = true
        super.init(frame: frame)
        initialSettings()
    }
    
    init(frame: CGRect, isScannedView: Bool = true) {
        isScanView = isScannedView
        super.init(frame: frame)
        initialSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        isScanView = true
        super.init(coder: aDecoder)
    }
    
    private func loadFromNib() {
        guard let view = Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)?.first as? UIView else { return }
        view.frame = bounds
        addSubview(view)
    }
    
    func initialSettings() {
        isScanView ? initialSettingsForSacnnedView() : settingsForActivityView()
    }
    
    func settingsForActivityView() {
        loadFromNib()
        activityView.roundedBorders(radius: 5)
        activityView.getShadow(radius: 5)
        activityIndicator.startAnimating()
    }
    
    private func initialSettingsForSacnnedView() {
        loadFromNib()
        self.addblurEffect()
        activityIndicator.startAnimating()
    }
}


