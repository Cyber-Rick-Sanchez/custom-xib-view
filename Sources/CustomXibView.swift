/**
 *  CustomXibView
 *  Copyright (c) Piotr Więcaszek 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

@IBDesignable
open class CustomXibView: UIView {
    
    private var contentView : UIView!
    
    @IBInspectable private(set) open lazy var xibName: String = String(describing: type(of: self))
    
    open var bundle: Bundle? {
        return self.bundlesContainingXib.first
    }
    
    // Called by IBDesignablesAgentCocoaTouch
    // Can be used to create view programmatically
    override public init(frame: CGRect) {
        super.init(frame: frame)
        // IBDesignablesAgentCocoaTouch calls init(frame:)
        // but IBInspectables are not set yet so we do not want to setup the xib
        if self.isAppRunnig {
            self.xibSetup()
        }
    }
    
    // Called in running app when view is nested in Storyboard or Xib
    // IBInspectables are not set yet
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Called in running app when view is nested in Storyboard or Xib
    // IBInspectables are set
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.xibSetup()
    }
    
    // Called only by IBDesignablesAgentCocoaTouch after IBInspectables are set
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.xibSetup()
    }
    
    private func xibSetup() {
        
        guard self.contentView == nil else { return }
        
        guard let contentView = self.viewFromXib else { return }
        
        self.contentView = contentView
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(contentView)
        
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private var viewFromXib: UIView? {
        
        guard let bundle = self.bundle else {
            return errorViewFor(viewFromXibProblem: .nilBundle)
        }
        
        let xib = UINib(nibName: self.xibName, bundle: bundle)
        
        guard let view = self.viewFromXib(xib) else {
            return errorViewFor(viewFromXibProblem: .emptyXib)
        }
        
        return view
    }
    
    private func errorViewFor(viewFromXibProblem: ViewFromXibProblem) -> UIView? {
        let text = self.textFor(viewFromXibProblem: viewFromXibProblem)
        if self.isAppRunnig {
            assertionFailure(text)
            return nil
        } else {
            return self.errorViewWithText(text)
        }
    }
    
    private func textFor(viewFromXibProblem: ViewFromXibProblem) -> String {
        switch viewFromXibProblem {
        case .nilBundle:
            if self.xibName == "CustomView" {
                return "Provide Xib Name"
            }
            return "Cannot find \(self.xibName).xib"
        case .emptyXib:
            return "\(self.xibName).xib has no views"
        }
    }
    
    private enum ViewFromXibProblem {
        case nilBundle
        case emptyXib
    }
    
    private func errorViewWithText(_ text: String) -> UIView {
        
        let errorLabel = UILabel()
        errorLabel.backgroundColor = .red
        errorLabel.textColor = .black
        errorLabel.textAlignment = .center
        errorLabel.text = text
        
        return errorLabel
    }
    
    private var isAppRunnig: Bool {
        return UIApplication.shared.delegate != nil
    }
    
    private var bundlesContainingXib: [Bundle] {
        return Bundle.allBundles.filter { bundle -> Bool in
            return self.xibExistsForBundle(bundle)
        }
    }
    
    private func xibExistsForBundle(_ bundle: Bundle) -> Bool {
        return bundle.url(forResource: self.xibName, withExtension: "nib") != nil
    }
    
    private func viewFromXib(_ nib: UINib) -> UIView? {
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
