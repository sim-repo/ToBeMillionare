import Foundation


enum ModuleEnum: String {
    
    case profile
    case createProfile
    case options
    case menu
    case leaderboard
    case play
    case callFriends
    case progress
    case unknown
    
    
    init(vc: PresentableView) {
        switch vc {
        case is ProfileViewController:
            self = .profile
        case is NewProfileViewController:
            self = .createProfile
        case is OptionsViewController:
            self = .options
        case is MenuViewController:
            self = .menu
        case is LeaderboardViewController:
            self = .leaderboard
        case is PlayV2ViewController:
            self = .play
        case is CallFriendsViewController:
            self = .callFriends
        case is ProgressViewController:
            self = .progress
        default:
            //TODO: catch err
            self = .unknown
        }
    }
    
    
    init(presenter: PresenterProtocol) {
        switch presenter {
        case is ProfilePresenter:
            self = .profile
        case is CreateProfilePresenter:
            self = .createProfile
        case is OptionsPresenter:
            self = .options
        case is MenuPresenter:
            self = .menu
        case is LeaderboardPresenter:
            self = .leaderboard
        case is PlayPresenter:
            self = .play
        case is CallFriendsPresenter:
            self = .callFriends
        case is ProgressPresenter:
            self = .progress
        default:
            //TODO: catch err
            self = .unknown
        }
    }
    
    
    init(presenterType: PresenterProtocol.Type) {
        switch presenterType {
        case is ProfilePresenter.Type:
            self = .profile
        case is CreateProfilePresenter.Type:
            self = .createProfile
        case is OptionsPresenter.Type:
            self = .options
        case is MenuPresenter.Type:
            self = .menu
        case is LeaderboardPresenter.Type:
            self = .leaderboard
        case is PlayPresenter.Type:
            self = .play
        case is CallFriendsPresenter.Type:
            self = .callFriends
        case is ProgressPresenter.Type:
            self = .progress
        default:
            //TODO: catch err
            self = .unknown
        }
    }
    
    
    var presenter: PresenterProtocol.Type {
        switch self {
        case .profile:
            return ProfilePresenter.self
        case .createProfile:
            return CreateProfilePresenter.self
        case .options:
            return OptionsPresenter.self
        case .menu:
            return MenuPresenter.self
        case .leaderboard:
            return LeaderboardPresenter.self
        case .play:
            return PlayPresenter.self
        case .callFriends:
            return CallFriendsPresenter.self
        case .progress:
            return ProgressPresenter.self
        default:
            //TODO: catch err
            return ProfilePresenter.self
        }
    }
}
