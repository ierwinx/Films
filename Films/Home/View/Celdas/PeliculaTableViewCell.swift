import UIKit

class PeliculaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func setData(strTitle: String, strDescr: String, strImage: String) {
        lblName.text = strTitle
        lblDescription.text = strDescr

        let strUrl = Constants.URL.imagenes + strImage
        if let url = URL(string: strUrl), let data = try? Data(contentsOf: url) {
            imgPoster.image = UIImage(data: data)
        } else {
            imgPoster.image = UIImage(named: "claqueta")
        }
    }

}
