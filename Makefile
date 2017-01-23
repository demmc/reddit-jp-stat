SHELL=/bin/bash
.PHONY: all fetch data plot clean clean-all

all: plot table

fetch:
	./get-all.sh -a -b -s

data:
	./apply-all.sh mk-data.sh
	./mk-stat.sh

plot: data
	./plot-stat.sh
	./apply-all.sh plot.sh

table: data
	./to-table.sh

clean:
	rm -f data/*
	rm -f r/*/*.{png,data}

clean-all: clean
	rm -f r/*/*
