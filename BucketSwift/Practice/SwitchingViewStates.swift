import SwiftUI

enum LoadingState{
    case loading
    case success
    case failed
}


struct SwitchingViewStates: View {
    var loadingState = LoadingState.loading
    
    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
    }
}

struct SwitchingViewStates_Previews: PreviewProvider {
    static var previews: some View {
        SwitchingViewStates()
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}