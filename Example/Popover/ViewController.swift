//
//  ViewController.swift
//  Popover
//
//  Created by corin8823 on 8/16/15.
//  Copyright (c) 2015 corin8823. All rights reserved.
//

import UIKit
import Popover

class ViewController: UIViewController {

  @IBOutlet weak var rightBarButton: UIBarButtonItem!
  @IBOutlet weak var leftBottomButton: UIButton!
  @IBOutlet weak var rightButtomButton: UIButton!

  fileprivate var texts = ["Edit", "Delete", "Report"]

  fileprivate var popover: Popover!
  fileprivate var popoverOptions: [PopoverOption] = [
    .type(.up),
    .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func tappedRightBarButton(_ sender: UIBarButtonItem) {
    let startPoint = CGPoint(x: self.view.frame.width - 60, y: 55)
    let aView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 180))
    let popover = Popover(options: nil, showHandler: nil, dismissHandler: nil)
    popover.show(aView, point: startPoint)
  }

  @IBAction func tappedLeftBottomButton(_ sender: UIButton) {
    let width = self.view.frame.width / 4
    let aView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
    let options = [
      .type(.up),
      .cornerRadius(width / 2)
      ] as [PopoverOption]
    let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
    popover.show(aView, fromView: self.leftBottomButton)
  }

  @IBAction func tappedRightButtomButton(_ sender: UIButton) {
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 135))
    tableView.delegate = self
    tableView.dataSource = self
    tableView.isScrollEnabled = false
    self.popover = Popover(options: self.popoverOptions)
    self.popover.willShowHandler = {
      print("willShowHandler")
    }
    self.popover.didShowHandler = {
      print("didDismissHandler")
    }
    self.popover.willDismissHandler = {
      print("willDismissHandler")
    }
    self.popover.didDismissHandler = {
      print("didDismissHandler")
    }
    self.popover.show(tableView, fromView: self.rightButtomButton)
  }
}

extension ViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.popover.dismiss()
  }
}

extension ViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    cell.textLabel?.text = self.texts[(indexPath as NSIndexPath).row]
    return cell
  }
}
