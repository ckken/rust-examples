RUSTC=echo -e "\033[32;1mRustc:\033[33m" $@ "\033[m"; rustc
LIBSRC=$(wildcard lib*.rs)
LIBSTAMP=$(patsubst %.rs,lib-stamps/%,$(LIBSRC))
TESTSRC=libfibonacci.rs unittests.rs
TESTPROG:=$(patsubst %.rs,test-%,$(TESTSRC))
SRC=$(wildcard *.rs)
SRC:=$(filter-out $(TESTSRC),$(SRC))
PROG:=$(patsubst %.rs,%,$(SRC))
RUSTFLAGS= -L .

.SILENT:
.PRECIOUS: $(LIBSTAMP)

all: exe test bench 
	# Build executables, run tests and benchmarks

help:
	# Show this help
	grep -A1 ^[a-z].*\: Makefile | sed -r 's/: (.*)$$/:/g' | sed ':a;N;$$!ba;s/:\n//g' | sed s,\\#,\\t,g | grep -v \\--

clean:
	# Remove executables, test files, libraries
	rm -fr $(PROG) $(TESTPROG) lib*.so *~ html-doc lib-stamps

bench: $(TESTPROG)
	# Run benchmarks
	@for EXE in $(TESTPROG); do\
		./$$EXE --bench;\
	done

exe: $(PROG)
	# Build executables

test: $(TESTPROG)
	# Run tests
	@for EXE in $(TESTPROG); do\
		./$$EXE;\
	done

% : %.rs $(LIBSTAMP)
	$(RUSTC) $(RUSTFLAGS) $< -o $@

lib-stamps/% : %.rs
	mkdir -p lib-stamps ; # --
	$(RUSTC) --lib $<  > $@;

test-% : %.rs $(LIBSTAMP)
	$(RUSTC) $(RUSTFLAGS) $< -o $@ --test
