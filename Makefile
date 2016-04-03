build:
	swift build
run: build
	.build/debug/SSSMain
test:
	swift build --fetch
	rm -rf Packages/*/Tests
	swift build
	swift build --configuration release
	swift test
clean:
	swift build --clean
	rm -rf Packages
release: clean
	swift build --configuration release

