import UIKit

public class Delay: NSObject {
  @available(*, unavailable) private override init() {}
  // `short` and `long` (lowercase) are reserved words in Objective-C
  // so we capitalize them instead of the default `short_` and `long_`
  @objc(Short) public static let short: TimeInterval = 2.0
  @objc(Long) public static let long: TimeInterval = 3.5
}

open class Toast: Operation {

  // MARK: Properties
  @objc public var text: String? {
    get { return self.view.text }
    set { self.view.text = newValue }
  }
    @objc public var image: UIImage?{
        get{
            return self.view.image
        }
        set{
            self.view.image = newValue
        }
    }
    @objc public var backgroundColor: UIColor?{
        get{
            return self.view.backgroundColor
        }
        set{
            self.view.backgroundColor = newValue
        }
    }
    @objc public var textColor: UIColor?{
        get{
            return self.view.textColor
        }
        set{
            self.view.textColor = newValue
        }
    }
  @objc public var delay: TimeInterval
  @objc public var duration: TimeInterval

  private var _executing = false
  override open var isExecuting: Bool {
    get {
      return self._executing
    }
    set {
      self.willChangeValue(forKey: "isExecuting")
      self._executing = newValue
      self.didChangeValue(forKey: "isExecuting")
    }
  }

  private var _finished = false
  override open var isFinished: Bool {
    get {
      return self._finished
    }
    set {
      self.willChangeValue(forKey: "isFinished")
      self._finished = newValue
      self.didChangeValue(forKey: "isFinished")
    }
  }


  // MARK: UI

  @objc public var view: ToastView = ToastView()


  // MARK: Initializing

  /// Initializer.
  /// Instantiates `self.view`, so must be called on main thread.
    @objc public init(text: String?, delay: TimeInterval = 0, duration: TimeInterval = Delay.short) {
    self.delay = delay
    self.duration = duration
    super.init()
    self.text = text
  }
    @objc public init(text: String?, image: UIImage?, backgroundColor: UIColor = UIColor.white, delay: TimeInterval = 0, duration: TimeInterval = Delay.short){
        self.delay = delay
        self.duration = duration
        super.init()
        self.text = text
        self.image = image
        self.backgroundColor = backgroundColor
    }
    @objc public init(text: String?, image: UIImage?, textColor: UIColor?, backgroundColor: UIColor?, delay: TimeInterval = 0, duration: TimeInterval = Delay.short){
        self.delay = delay
        self.duration = duration
        super.init()
        self.text = text
        self.image = image
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    /// Toast   
    ///
    /// - Parameters:
    ///   - text: text description
    ///   - type: Toast 类型 0 积极 1 中性 2 消极
    ///   - duration: duration description
    @objc public init(text: String,  type: Int, duration: TimeInterval = Delay.short){
        self.delay = 0
        self.duration = duration
        super.init()
        self.textColor = .white
        self.text = text
        if type == 0{
            self.textColor = .black
            self.backgroundColor = UIColor(hex6: "#75FFC4")
        }else if type == 1{
            self.backgroundColor = .black
        }else if type == 2{
            self.backgroundColor = .black
        }
    }
    @objc public init(greentext: String, duration: TimeInterval = Delay.short){
        self.delay = 0
        self.duration = duration
        super.init()
        self.textColor = .black
        self.text = greentext
        self.backgroundColor = UIColor(hex6: "#75FFC4")
        
    }
  // MARK: Showing

  @objc public func show() {
    ToastCenter.default.cancelAll()
    ToastCenter.default.add(self)
  }
  // MARK: Cancelling
  open override func cancel() {
    super.cancel()
    self.finish()
    self.view.removeFromSuperview()
  }
  // MARK: Operation Subclassing

  override open func start() {
    let isRunnable = !self.isFinished && !self.isCancelled && !self.isExecuting
    guard isRunnable else { return }
    guard Thread.isMainThread else {
      DispatchQueue.main.async { [weak self] in
        self?.start()
      }
      return
    }
    main()
  }

  override open func main() {
    self.isExecuting = true

    DispatchQueue.main.async {
      self.view.setNeedsLayout()
      self.view.alpha = 0
      ToastWindow.shared.addSubview(self.view)

      UIView.animate(
        withDuration: 0.5,
        delay: self.delay,
        options: .beginFromCurrentState,
        animations: {
          self.view.alpha = 1
        },
        completion: { completed in
          UIView.animate(
            withDuration: self.duration,
            animations: {
              self.view.alpha = 1.0001
            },
            completion: { completed in
              self.finish()
              UIView.animate(
                withDuration: 0.5,
                animations: {
                  self.view.alpha = 0
                },
                completion: { completed in
                  self.view.removeFromSuperview()
                }
              )
            }
          )
        }
      )
    }
  }

  func finish() {
    self.isExecuting = false
    self.isFinished = true
  }
}
/*
 eg:
 
 Toast(text: "撒发顺丰", image: UIImage(named: "cheer"), textColor: .black, backgroundColor: .yellow).show()
 Toast(text: "阿多少发多少分").show()
 
 */
