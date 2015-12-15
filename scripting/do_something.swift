#!/home/ddohler/swift/usr/bin/swift

extension Int {
  var seconds: Int { return self * 1000 }
  var minutes: Int { return 60 * self * self.seconds }
  var hours: Int { return 60 * self.minutes }
}

print("2 hours have \(2.hours) milliseconds")
print("2 minutes have \(2.minutes) milliseconds")
print("2 seconds have \(2.seconds) milliseconds")
