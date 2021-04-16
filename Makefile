MODULES= types model levels view controller main
MLS=$(MODULES:=.ml)
MLIS=$(MODULES:=.mli)
MAIN=main
BYTE=$(MAIN:=.byte)
JS=$(MAIN:=.js)
TEST=test.byte
OBJECTS=$(MODULES:=.cmo)
OCAMLBUILD=ocamlbuild -use-ocamlfind -plugin-tag 'package(js_of_ocaml-ocamlbuild)'
PKGS=js_of_ocaml,js_of_ocaml-ppx

build:
	$(OCAMLBUILD) $(OBJECTS)
	$(OCAMLBUILD) $(BYTE) 
	js_of_ocaml -o $(JS) $(BYTE)


docs: docs-public docs-private

docs-public:  build
	mkdir -p doc.public
	ocamlfind ocamldoc -I _build -package $(PKGS) \
		-html -stars -d doc.public authors.mli types.mli model.mli levels.mli \
		view.mli controller.mli

docs-private: build
	mkdir -p doc.private
	ocamlfind ocamldoc -I _build -package $(PKGS) \
		-html -stars -d doc.private \
		-inv-merge-ml-mli -m A -hide-warnings authors.mli types.mli model.mli \
		levels.mli view.mli controller.mli $(MLS)
	
clean:
	ocamlbuild -clean
	rm -rf doc.public doc.private jocalf.zip _coverage bisect*.coverage

test:
	BISECT_COVERAGE=YES $(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST) \
	-runner sequential

install:
	opam install js_of_ocaml js_of_ocaml-ppx js_of_ocaml-lwt

zip:
	zip -r final_project.zip *.ml* _tags Makefile *.txt images .merlin \
	.ocamlinit *.pdf *.html *.css


