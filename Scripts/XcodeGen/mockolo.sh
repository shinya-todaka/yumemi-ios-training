if which mint >/dev/null; then
  xcrun --sdk macosx mint run uber/mockolo mockolo --sourcedirs $SRCROOT/yumemi-ios-training \
						   --destination $SRCROOT/$TARGET_NAME/Generated/MockResults.swift \
						   --testable-imports yumemi_ios_training \
						   --mock-final
					          
else
  echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
fi
