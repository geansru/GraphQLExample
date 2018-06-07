/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

enum Section {

  case info(title: String, models: [InfoItem])
  case references(title: String, models: [RefItem])

  var rowCount: Int {
    switch self {
    case .info(_, let models): return models.count
    case .references(_, let models): return models.count
    }
  }

  var title: String {
    switch self {
    case .info(let title, _): return title
    case .references(let title, _): return title
    }
  }
}

class ListDataSource: NSObject {

  var sections: [Section] = []

  func configure(with tableView: UITableView) {
    tableView.dataSource = self
    tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.cellID)
    tableView.register(RefCell.self, forCellReuseIdentifier: RefCell.cellID)
  }
}

// MARK: - UITableViewDataSource {
extension ListDataSource: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].rowCount
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].title
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let resultCell: UITableViewCell

    switch sections[indexPath.section] {
    case .info(_, let models):
      let model = models[indexPath.row]
      let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.cellID, for: indexPath) as! InfoCell
      cell.model = model
      resultCell =  cell
    case .references(_, let models):
      let model = models[indexPath.row]
      let cell = tableView.dequeueReusableCell(withIdentifier: RefCell.cellID, for: indexPath) as! RefCell
      cell.model = model
      resultCell = cell
    }

    return resultCell
  }
}
