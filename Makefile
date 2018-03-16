all: pep8 test

test:
	./jv test

compare-changing-linenums:
	./jv compare test-changing-linenums/old test-changing-linenums/new \
	  --old-source-path=test-changing-linenums/old/src \
	  --new-source-path=test-changing-linenums/new/src

jit-workaround-clean:
	./jv compare testdata/jit-workaround/clean/old testdata/jit-workaround/clean/new

jit-workaround-new-failure:
	./jv compare testdata/jit-workaround/new-failure/old testdata/jit-workaround/new-failure/new

pep8:
	python3-pep8 jv
