test:
	@swipl -g "load_files([tests/test_solutions_teaser]), run_tests" -t halt
