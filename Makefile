all: watch

watch:
	rm -r bin
	mkdir bin
	jitter coffee bin &

	rm -r test/bin
	mkdir test/bin
	jitter test test/bin &

