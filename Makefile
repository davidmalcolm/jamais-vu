test:
	./jv test

compare-changing-linenums:
	./jv compare test-changing-linenums/old test-changing-linenums/new \
	  --old-source-path=test-changing-linenums/old/src \
	  --new-source-path=test-changing-linenums/new/src

pep8:
	python3-pep8 jv
