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

class CharacterDetailViewController: UITableViewController {

  let characterID: String
  let dataSource = ListDataSource()

  init(characterID: String) {
    self.characterID = characterID
    super.init(style: .grouped)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    loadCharacter()
  }

  func configure() {
    applyDarkStyle()
    dataSource.configure(with: tableView)
  }
}

// MARK: Table View
extension CharacterDetailViewController {

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
extension CharacterDetailViewController {

  func loadCharacter() {
    func infoItem(from key: String, with value: String?) -> InfoItem {
      return InfoItem(label: NSLocalizedString(key, comment: ""), value: value ?? "NA")
    }
    Apollo.shared.client.fetch(query: CharacterDetailQuery(id: characterID)) { [weak self] (result, error) in
      guard let `self` = self else { return }
      
      guard let character = result?.data?.person else {
        print("Error loading character with id \(String(describing: self.characterID)). \(String(describing: error))")
        return
      }
      
      self.navigationItem.title = character.name
      let infoItems = [
        infoItem(from: "Name", with: character.name),
        infoItem(from: "Birth Year", with: character.birthYear),
        infoItem(from: "Eye color", with: character.eyeColor),
        infoItem(from: "Gender", with: character.gender),
        infoItem(from: "Hair color", with: character.hairColor),
        infoItem(from: "Skin color", with: character.skinColor),
        infoItem(from: "Home world", with: character.homeworld?.name)
      ]
      
      var sections: [Section] = [.info(title: "Info", models: infoItems)]
      
      if let films = character.filmConnection?.films?.flatMap({$0}).map({ RefItem(film: $0.fragments.listFilmFragment) }), films.count > 0 {
        sections.append(.references(title: NSLocalizedString("Appears In", comment: ""), models: films))
      }
      
      self.dataSource.sections = sections
      self.tableView.reloadData()
    }
  }

}
