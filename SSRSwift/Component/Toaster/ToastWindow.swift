import UIKit

open class ToastWindow: UIWindow {

  public static let shared = ToastWindow(frame: UIScreen.main.bounds)

  /// Will not return `rootViewController` while this value is `true`. Needed for iOS 13.
  var isShowing = false

  /// Returns original subviews. `ToastWindow` overrides `addSubview()` to add a subview to the
  /// top window instead itself.
  private var originalSubviews = NSPointerArray.weakObjects()

  /// Don't rotate manually if the application:
  ///
  /// - is running on iPad
  /// - is running on iOS 9
  /// - supports all orientations
  /// - doesn't require full screen
  /// - has launch storyboard
  ///
  var shouldRotateManually: Bool {
    let iPad = UIDevice.current.userInterfaceIdiom == .pad
    let application = UIApplication.shared
    let window = application.delegate?.window ?? nil
    let supportsAllOrientations = application.supportedInterfaceOrientations(for: window) == .all

    let info = Bundle.main.infoDictionary
    let requiresFullScreen = (info?["UIRequiresFullScreen"] as? NSNumber)?.boolValue == true
    let hasLaunchStoryboard = info?["UILaunchStoryboardName"] != nil

    if #available(iOS 9, *), iPad && supportsAllOrientations && !requiresFullScreen && hasLaunchStoryboard {
      return false
    }
    return true
  }

  override open var rootViewController: UIViewController? {
    get {
      // TODO: avoid iOS 13 warning without breaking preferredStatusBarStyle
      //guard !self.isShowing else { return nil }
      guard let firstWindow = UIApplication.shared.delegate?.window else { return nil }
      return firstWindow is ToastWindow ? nil : firstWindow?.rootViewController
    }
    set { /* Do nothing */ }
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.isUserInteractionEnabled = false
    #if swift(>=4.2)
    self.windowLevel = .init(rawValue: .greatestFiniteMagnitude)
    let didBecomeVisibleName = UIWindow.didBecomeVisibleNotification
    let didBecomeActiveName = UIApplication.didBecomeActiveNotification
    let keyboardWillShowName = UIWindow.keyboardWillShowNotification
    let keyboardDidHideName = UIWindow.keyboardDidHideNotification
    #else
    self.windowLevel = .greatestFiniteMagnitude
    let didBecomeVisibleName = NSNotification.Name.UIWindowDidBecomeVisible
    let didBecomeActiveName = NSNotification.Name.UIApplicationDidBecomeActive
    let keyboardWillShowName = NSNotification.Name.UIKeyboardWillShow
    let keyboardDidHideName = NSNotification.Name.UIKeyboardDidHide
    #endif
    self.backgroundColor = .clear
    self.isHidden = false
    self.handleRotate(UIApplication.shared.statusBarOrientation)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.windowDidBecomeVisible),
      name: didBecomeVisibleName,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.applicationDidBecomeActive),
      name: didBecomeActiveName,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.keyboardWillShow),
      name: keyboardWillShowName,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.keyboardDidHide),
      name: keyboardDidHideName,
      object: nil
    )
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented: please use ToastWindow.shared")
  }

  @objc func windowDidBecomeVisible(_ notification: Notification) {
    if !(notification.object is ToastWindow) {
      self.bringWindowToTop()
    }
  }
  @objc func applicationDidBecomeActive() {
    let orientation = UIApplication.shared.statusBarOrientation
    self.handleRotate(orientation)
  }

  func handleRotate(_ orientation: UIInterfaceOrientation) {
    let angle = self.angleForOrientation(orientation)
    if self.shouldRotateManually {
      self.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }

    if let window = UIApplication.shared.windows.first {
      if orientation.isPortrait || !self.shouldRotateManually {
        self.frame.size.width = window.bounds.size.width
        self.frame.size.height = window.bounds.size.height
      } else {
        self.frame.size.width = window.bounds.size.height
        self.frame.size.height = window.bounds.size.width
      }
    }

    self.frame.origin = .zero

    DispatchQueue.main.async {
      ToastCenter.default.currentToast?.view.setNeedsLayout()
    }
  }

  @objc func keyboardWillShow() {
    guard let topWindow = self.topWindow(),
      let subviews = self.originalSubviews.allObjects as? [UIView] else { return }
    for subview in subviews {
      topWindow.addSubview(subview)
    }
  }

  @objc func keyboardDidHide() {
    guard let subviews = self.originalSubviews.allObjects as? [UIView] else { return }
    for subview in subviews {
      super.addSubview(subview)
    }
  }

  func angleForOrientation(_ orientation: UIInterfaceOrientation) -> Double {
    switch orientation {
    case .landscapeLeft: return -.pi / 2
    case .landscapeRight: return .pi / 2
    case .portraitUpsideDown: return .pi
    default: return 0
    }
  }

  override open func addSubview(_ view: UIView) {
    super.addSubview(view)
    self.originalSubviews.addPointer(Unmanaged.passUnretained(view).toOpaque())
    self.topWindow()?.addSubview(view)
  }

  override open var isHidden: Bool {
    willSet {
      isShowing = true
    }
    didSet {
      isShowing = false
    }
  }

  /// Returns top window that isn't self
  private func topWindow() -> UIWindow? {
    if let window = UIApplication.shared.windows.last, window !== self {
      return window
    }
    return nil
  }

  /// Brings ToastWindow to top when another window is being shown.
  private func bringWindowToTop() {
    ToastWindow.shared.isHidden = true
    ToastWindow.shared.isHidden = false
  }
}
