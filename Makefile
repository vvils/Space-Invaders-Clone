.PHONY: test check

build:
	dune build

code:
	-dune build
	code .
	! dune build --watch

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

play:
	OCAMLRUNPARAM=b dune exec bin/main.exe

check:
	@bash check.sh

finalcheck:
	@bash check.sh final

zip:
	rm -f VVeganYam.zip
	zip -r VVeganYam.zip . -x@exclude.lst

clean:
	dune clean
	rm -f VVeganYam.zip

doc:
	dune build @doc

opendoc: doc
	@bash opendoc.sh