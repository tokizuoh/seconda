.PHONY: run
run-debug:
	export SECONDA_WORKING_DIRECTORY=$PWD
	swift run
run-release:
	export SECONDA_WORKING_DIRECTORY=$PWD
	swift run --configuration release
