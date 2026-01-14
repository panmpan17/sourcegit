.PHONY: build run build-mac-release pack-mac build-mac clean clean-mac

MAC_OUTPUT_FOLDER := output/macos
MAC_APP_NAME := SourceGit
VERSION := 0.0.1

run:
	@dotnet run --project src/SourceGit.csproj

build-mac-release:
	@mkdir -p $(MAC_OUTPUT_FOLDER)
	@dotnet publish -c Release -r osx-arm64 -o $(MAC_OUTPUT_FOLDER) src/SourceGit.csproj

pack-mac:
	@mkdir -p $(MAC_OUTPUT_FOLDER)/../$(MAC_APP_NAME).app/Contents/Resources
	@mkdir -p $(MAC_OUTPUT_FOLDER)/../$(MAC_APP_NAME).app/Contents/MacOS
	@cp -a $(MAC_OUTPUT_FOLDER)/* $(MAC_OUTPUT_FOLDER)/../$(MAC_APP_NAME).app/Contents/MacOS/
	@cp build/resources/app/App.icns $(MAC_OUTPUT_FOLDER)/../$(MAC_APP_NAME).app/Contents/Resources/App.icns
	@sed "s/SOURCE_GIT_VERSION/$(VERSION)/g" build/resources/app/App.plist > $(MAC_OUTPUT_FOLDER)/../$(MAC_APP_NAME).app/Contents/Info.plist
	@rm -rf $(MAC_OUTPUT_FOLDER)/../$(MAC_APP_NAME).app/Contents/MacOS/SourceGit.dsym

build-mac: build-mac-release pack-mac

clean: clean-mac

clean-mac:
	@rm -rf $(MAC_OUTPUT_FOLDER)
