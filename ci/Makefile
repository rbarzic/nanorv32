run_gpio_toggle:
	@echo "-D- Testing gitlab CI environment"
	@echo "-D- PATH=" $(PATH)
	@echo "-D- USER=" $(USER)	
	export RISCV_GCC_PREFIX=riscv-none-embed- && cd ../sim && /usr/bin/python2.7 ./runtest.py ../ctests/gpio_toggle -v
