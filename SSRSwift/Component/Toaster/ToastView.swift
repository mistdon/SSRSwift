import UIKit

open class ToastView: UIView {

  // MARK: Properties

  open var text: String? {
    get { return self.textLabel.text }
    set { self.textLabel.text = newValue }
  }
  open var image: UIImage?{
    get{return self.imageView.image}
    set{self.imageView.image = newValue}
  }

  // MARK: Appearance

  /// The background view's color.
  override open dynamic var backgroundColor: UIColor? {
    get { return self.backgroundView.backgroundColor }
    set { self.backgroundView.backgroundColor = newValue }
  }

  /// The background view's corner radius.
  @objc open dynamic var cornerRadius: CGFloat {
    get { return self.backgroundView.layer.cornerRadius }
    set { self.backgroundView.layer.cornerRadius = newValue }
  }

  /// The inset of the text label.
  @objc open dynamic var textInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 15)

  /// The color of the text label's text.
  @objc open dynamic var textColor: UIColor? {
    get { return self.textLabel.textColor }
    set { self.textLabel.textColor = newValue }
  }

  /// The font of the text label.
  @objc open dynamic var font: UIFont? {
    get { return self.textLabel.font }
    set { self.textLabel.font = newValue }
  }
  // MARK: UI
  private let backgroundView: UIView = {
    let `self` = UIView()
    self.backgroundColor = .white
    self.clipsToBounds = false
    return self
  }()
  let textLabel: UILabel = {
    let `self` = UILabel()
    self.font = UIFont.boldSystemFont(ofSize: 14)
    self.numberOfLines = 0
    self.textAlignment = .center
    return self
  }()
  private let imageView: UIImageView = {
    let `self` = UIImageView()
    self.contentMode = .scaleAspectFit
    return self
  }()

  // MARK: Initializing
  public init() {
    super.init(frame: .zero)
    self.isUserInteractionEnabled = false
    self.addSubview(self.backgroundView)
    self.addSubview(self.imageView)
    self.addSubview(self.textLabel)
  }

  required convenience public init?(coder aDecoder: NSCoder) {
    self.init()
  }
  // MARK: Layout
  override open func layoutSubviews() {
    super.layoutSubviews()
    let containerSize = ToastWindow.shared.frame.size
    let constraintSize = CGSize(
      width: containerSize.width * (280.0 / 320.0),
      height: CGFloat.greatestFiniteMagnitude
    )
    var imageViewWidth: CGFloat = 0
    if self.imageView.image != nil {
        self.imageView.frame = CGRect(x: 10, y: self.textInsets.top, width: 20, height: 20)
        imageViewWidth = 20
    }
    var textLabelSize = self.textLabel.sizeThatFits(constraintSize)
    if textLabel.text?.isEmpty ?? false {
        textLabelSize.height = 30
    }
    self.textLabel.frame = CGRect(
      x: self.textInsets.left + imageViewWidth + self.imageView.frame.origin.x,
      y: self.textInsets.top,
      width: textLabelSize.width,
      height: textLabelSize.height
    )
    self.backgroundView.frame = CGRect(
      x: 0,
      y: 0,
      width: self.textLabel.frame.size.width + self.textInsets.left + self.textInsets.right + imageViewWidth + self.imageView.frame.origin.x,
      height: self.textLabel.frame.size.height + self.textInsets.top + self.textInsets.bottom
    )
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat

    let orientation = UIApplication.shared.statusBarOrientation
    if orientation.isPortrait || !ToastWindow.shared.shouldRotateManually {
      width = containerSize.width
      height = containerSize.height
      y = 30.0
    } else {
      width = containerSize.height
      height = containerSize.width
      y = 20.0
    }

    let backgroundViewSize = self.backgroundView.frame.size
    x = (width - backgroundViewSize.width) * 0.5
    y = App.naviStatusHeight + 24.0 // 固定在顶部显示
    self.backgroundView.layer.cornerRadius = backgroundViewSize.height / 2
    self.frame = CGRect(
      x: x,
      y: y,
      width: backgroundViewSize.width,
      height: backgroundViewSize.height
    )
    self.backgroundView.layer.shadowPath = UIBezierPath(roundedRect: self.backgroundView.bounds, cornerRadius: self.backgroundView.layer.cornerRadius).cgPath
    self.imageView.centerY = self.height / 2.0
  }

  override open func hitTest(_ point: CGPoint, with event: UIEvent!) -> UIView? {
    if let superview = self.superview {
      let pointInWindow = self.convert(point, to: superview)
      let contains = self.frame.contains(pointInWindow)
      if contains && self.isUserInteractionEnabled {
        return self
      }
    }
    return nil
  }

}
