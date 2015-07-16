OPTIONS= -unsafe

UNIX= -package unix
PCRE= -package pcre
STR = -package str
RE  = -package re.str

REGEXP_DIR= regexp/_build
REGEXP= regexp.cmx
MLOBJS= common.cmx re_string_regexp_bench.cmx re_regexp_bench.cmx pcre_nogroup_regexp_bench.cmx pcre_regexp_bench.cmx str_regexp_bench.cmx re_str_bench.cmx re_bench.cmx

TARGET= driver_unix.native

all: $(TARGET)

$(REGEXP):
	make -C regexp

re_regexp_bench.cmx: $(REGEXP) common.cmx re_regexp_bench.ml
	ocamlfind ocamlopt $(OPTIONS) $(UNIX) -I $(REGEXP_DIR) -c $^ -o $@

re_string_regexp_bench.cmx: $(REGEXP) common.cmx re_string_regexp_bench.ml
	ocamlfind ocamlopt $(OPTIONS) $(UNIX) -I $(REGEXP_DIR) -c $^ -o $@

pcre_regexp_bench.cmx: common.cmx pcre_regexp_bench.ml
	ocamlfind ocamlopt $(OPTIONS) $(UNIX) $(PCRE) -c $^ -o $@

pcre_nogroup_regexp_bench.cmx: common.cmx pcre_nogroup_regexp_bench.ml
	ocamlfind ocamlopt $(OPTIONS) $(UNIX) $(PCRE) -c $^ -o $@

str_regexp_bench.cmx: common.cmx str_regexp_bench.ml
	ocamlfind ocamlopt $(OPTIONS) $(UNIX) $(STR) -c $^ -o $@

re_bench.cmx: common.cmx re_bench.ml
	ocamlfind ocamlopt $(OPTIONS) $(UNIX) $(RE) -c $^ -o $@

re_str_bench.cmx: common.cmx re_str_bench.ml
	ocamlfind ocamlopt $(OPTIONS) $(UNIX) $(RE) -c $^ -o $@

$(TARGET): $(REGEXP) $(MLOBJS) $(subst native,ml,$(TARGET))
	ocamlfind ocamlopt $(OPTIONS) $(UNIX) $(STR) $(PCRE) $(RE) -linkpkg -I $(REGEXP_DIR) $^ -o $@

%.cmx: %.ml
	ocamlfind ocamlopt $(OPTIONS) -c -g $<


clean:
	rm -rf $(TARGET) myocamlbuild.ml *.cm* *.o
	rm -rf _build regexp/_build
