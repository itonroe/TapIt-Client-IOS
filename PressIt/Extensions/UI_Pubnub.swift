import UIKit
import PubNub

class ViewController: UIViewController {

  var pubnub: PubNub!
  let channels = ["awesomeChannel"]
  let listener = SubscriptionListener(queue: .main)

  override func viewDidLoad() {
    super.viewDidLoad()

    listener.didReceiveMessage = { message in
      print("[Message]: \(message)")
    }
    listener.didReceiveStatus = { status in
      switch status {
      case .success(let connection):
        if connection == .connected {
          self.pubnub.publish(channel: self.channels[0], message: "Hello PubNub Swift!") { result in
            print(result.map { "Publish Response at \($0.timetoken.timetokenDate)" })
          }
        }
      case .failure(let error):
        print("Status Error: \(error.localizedDescription)")
      }
    }

    pubnub.add(listener)

    pubnub.subscribe(to: channels, withPresence: true)
  }
}
