import UIKit

class OnboardingViewController: UIViewController {

    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()

    let heroImageName: String
    let titleText: String

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }

    init(heroImageName: String, titleText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingViewController {
    func style() {
        view.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        imageView.image = UIImage(named: heroImageName)
        imageView.contentMode = .scaleAspectFit

        label.text = titleText
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
    }

    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}
