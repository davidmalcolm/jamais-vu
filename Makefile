all: pep8 test

test:
	./jv test

compare-changing-linenums:
	./jv compare testdata/changing-linenums/old testdata/changing-linenums/new \
	  --old-source-path=testdata/changing-linenums/old/src \
	  --new-source-path=testdata/changing-linenums/new/src

compare-changing-linenums-2:
	./jv compare testdata/changing-linenums-2/old testdata/changing-linenums-2/new \
	  --old-source-path=testdata/changing-linenums-2/old/src \
	  --new-source-path=testdata/changing-linenums-2/new/src

jit-workaround-clean:
	./jv compare testdata/jit-workaround/clean/old testdata/jit-workaround/clean/new

jit-workaround-new-failure:
	./jv compare testdata/jit-workaround/new-failure/old testdata/jit-workaround/new-failure/new

new-failure:
	./jv compare testdata/new-failures/old/gcc.sum testdata/new-failures/new/gcc.sum

error-detection:
	./jv compare testdata/error-detection/old/g++.sum testdata/error-detection/new/g++.sum

pep8:
	python3-pep8 jv
