test:
	@swipl -g "load_files([ \
			tests/test_solutions_teaser, \
			tests/test_brainteaser \
		]), run_tests" -t halt
