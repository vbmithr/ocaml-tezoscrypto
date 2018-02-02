all:
	jbuilder build @install @runtest-tezoscrypto

.PHONY: clean
clean:
	rm -rf _build
