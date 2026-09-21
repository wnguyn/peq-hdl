# I hate this.
SHELL := /bin/sh

RTL_DIR   ?= rtl
OBJ_DIR   ?= obj_dir
TOP       ?= top
VERILATOR ?= verilator

RTL_SOURCES := $(sort $(wildcard $(RTL_DIR)/*.v $(RTL_DIR)/*.sv))
MODEL_HEADER := $(OBJ_DIR)/V$(TOP).h

.PHONY: all verilate lint clean help

all: verilate

verilate: $(MODEL_HEADER)

$(MODEL_HEADER): $(RTL_SOURCES)
	$(VERILATOR) --cc --build --top-module $(TOP) --Mdir $(OBJ_DIR) $(RTL_SOURCES)

lint:
	$(VERILATOR) --lint-only -Wall -Wno-fatal --top-module $(TOP) $(RTL_SOURCES)

clean:
	rm -rf $(OBJ_DIR)

help:
	@printf '%s\n' \
		'make verilate  Verilate $(RTL_DIR)/ into $(OBJ_DIR)/ (V$(TOP).h + libV$(TOP).a)' \
		'make lint      Lint RTL with Verilator' \
		'make clean     Remove $(OBJ_DIR)/'
