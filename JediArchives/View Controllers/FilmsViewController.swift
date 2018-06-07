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

class FilmsViewController: UITableViewController {

  let dataSource = ListDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    loadFilms()
  }

  func configure() {
    applyDarkStyle()
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
    dataSource.configure(with: tableView)
  }
}

// MARK: Table View
extension FilmsViewController {

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch dataSource.sections[indexPath.section] {
    case .references(_, let models):
      let model = models[indexPath.row]
      let detailVC = FilmDetailViewController(filmID: model.id)
      navigationController?.pushViewController(detailVC, animated: true)
    default:
      break
    }
  }
}

// MARK: Data
extension FilmsViewController {

  func loadFilms() {
    let query = AllFilmsQuery()
    Apollo.shared.client.fetch(query: query) { [weak tableView, weak dataSource] (results, error) in
      guard let films = results?.data?.allFilms?.films?.flatMap({$0?.fragments.listFilmFragment}) else {
        print("Error loading data \(String(describing: error))")
        return
      }
      
      let models = films.map(RefItem.init)
      let sections: [Section] = [.references(title: NSLocalizedString("Films", comment: ""), models: models)]
      dataSource?.sections = sections
      tableView?.reloadData()
    } // end of fetch query
  }// end of func loadFilms

}
