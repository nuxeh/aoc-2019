.PHONY: test
test: intcode.rs
	rustc intcode.rs -o test --test
	./test
