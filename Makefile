all:
	jbuilder build @install @runtest-blake2

.PHONY: clean
clean:
	rm -rf _build
