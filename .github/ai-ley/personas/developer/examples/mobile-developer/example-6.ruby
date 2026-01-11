# ios/fastlane/Fastfile
default_platform(:ios)

platform :ios do
  desc "Build and upload to TestFlight"
  lane :beta do
    increment_build_number(xcodeproj: "YourApp.xcodeproj")
    build_app(scheme: "YourApp")
    upload_to_testflight(
      skip_waiting_for_build_processing: true,
      skip_submission: true
    )
  end

  desc "Build and upload to App Store"
  lane :release do
    increment_build_number(xcodeproj: "YourApp.xcodeproj")
    build_app(scheme: "YourApp")
    upload_to_app_store(
      force: true,
      reject_if_possible: true,
      skip_metadata: false,
      skip_screenshots: false,
      submit_for_review: true,
      automatic_release: true
    )
  end
end