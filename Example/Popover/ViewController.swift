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

  private var texts = ["Edit", "Delete", "Report"]

  private var popover: Popover!
  private var popoverOptions: [PopoverOption] = [
    .Type(.Up),
    .BlackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func tappedRightBarButton(sender: UIBarButtonItem) {
    let startPoint = CGPoint(x: self.view.frame.width - 60, y: 55)
    let aView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 180))
    let popover = Popover(options: nil, showHandler: nil, dismissHandler: nil)
    popover.show(aView, point: startPoint)
  }

  @IBAction func tappedLeftBottomButton(sender: UIButton) {
    let width = self.view.frame.width / 4
    let aView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
    let options = [
      .Type(.Up),
      .CornerRadius(width / 2)
      ] as [PopoverOption]
    let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
    popover.show(aView, fromView: self.leftBottomButton)
  }

  @IBAction func tappedRightButtomButton(sender: UIButton) {
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 135))
    tableView.delegate = self
    tableView.dataSource = self
    tableView.scrollEnabled = false
    self.popover = Popover(options: self.popoverOptions, showHandler: nil, dismissHandler: nil)
    self.popover.show(tableView, fromView: self.rightButtomButton)
  }
}

extension ViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.popover.dismiss()
  }
}

extension ViewController: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 3
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
    cell.textLabel?.text = self.texts[indexPath.row]
    return cell
  }
}