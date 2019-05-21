//
//  SegmentCircleButton.swift
//  HanselEvalProject
//
//  Created by Max on 11/15/18.
//  Copyright © 2018 Hansel. All rights reserved.
//

import UIKit

protocol SegmentCircleButtonDelegate {
    func didPressButton(_ sender: SegmentCircleButton)
}

class SegmentCircleButton: UIView {

    // UIComponents
    @IBOutlet var vwContainer: UIView!
    @IBOutlet weak var lblSegmentTitle: UILabel!
    @IBOutlet weak var vwSegmentCircle: UIView!
    
    // Variables
    var delegate:SegmentCircleButtonDelegate!
    let nibName:String = "SegmentCircleButton"
    
    // Set segment buttons status
    // Set true to active or false to deactive
    var active: Bool = false {
        didSet {
            lblSegmentTitle?.textColor = active ? .ACTIVE_SEGMENT_TEXT_COLOR : .DEACTIVE_SEGMENT_TEXT_COLOR
            vwSegmentCircle?.backgroundColor = active ? .ACTIVE_SEGMENT_CIRCLE_COLOR : .DEACTIVE_SEGMENT_CIRCLE_COLOR
        }
    }
    
    var title: String = "Places" {
        didSet {
            lblSegmentTitle.text = title
        }
    }

    // Delegates button action back to its caller
    @IBAction func onTapSegment(_ sender: Any) {
        delegate.didPressButton(self)
    }
    
    // Initialize via code
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit();
    }
    
    // Initialize via IB
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit();
    }
   
    // Initialize frame of the custom view to match its parent
    private func commonInit() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(vwContainer)
        vwContainer.frame = self.bounds
        vwContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        vwContainer.translatesAutoresizingMaskIntoConstraints = true
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
