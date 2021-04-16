# (C) 2019 University of Freiburg
# Chair of Algorithms and Data Structures
# Authors: Patrick Brosi (brosi@cs.uni-freiburg.de)

OCTI = /home/patrick/repos/loom/build/octi
ILP_TIMEOUT = 43200 # timeout = 12 hours
ILP_CACHE_DIR = /tmp
METHOD = heur
GRIDSIZE = 100

GLOB_ARGS = --stats -o $(METHOD) --ilp-cache-dir $(ILP_CACHE_DIR) --ilp-time-limit $(ILP_TIMEOUT) --restr-loc-search

DATASETS = $(basename $(notdir $(wildcard datasets/*.json)))

# standard graph

RNDR_DEG2 := $(patsubst %, render/octilinear/$(GRIDSIZE)/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_DEG2_DPEN := $(patsubst %, render/octilinear/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR := $(patsubst %, render/octilinear/$(GRIDSIZE)/base/%/res_$(METHOD).json, $(DATASETS))

# special graphs without deg 2

RNDR_HEXALINEAR := $(patsubst %, render/hexalinear/$(GRIDSIZE)/%/res_$(METHOD).json, $(DATASETS))

RNDR_QUADTREE := $(patsubst %, render/quadtree/$(GRIDSIZE)/%/res_$(METHOD).json, $(DATASETS))

RNDR_CHULLOCTILINEAR := $(patsubst %, render/chulloctilinear/$(GRIDSIZE)/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN := $(patsubst %, render/octihanan/$(GRIDSIZE)/%/res_$(METHOD).json, $(DATASETS))

RNDR_PORTHORAD := $(patsubst %, render/porthorad/$(GRIDSIZE)/%/res_$(METHOD).json, $(DATASETS))

# special graphs with deg 2

RNDR_HEXALINEAR_DEG2 := $(patsubst %, render/hexalinear/$(GRIDSIZE)/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_QUADTREE_DEG2 := $(patsubst %, render/quadtree/$(GRIDSIZE)/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2 := $(patsubst %, render/chulloctilinear/$(GRIDSIZE)/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN_DEG2 := $(patsubst %, render/octihanan/$(GRIDSIZE)/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2 := $(patsubst %, render/octihanan2/$(GRIDSIZE)/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_PORTHORAD_DEG2 := $(patsubst %, render/porthorad/$(GRIDSIZE)/deg2/%/res_$(METHOD).json, $(DATASETS))

# special graphs with deg 2 and density penalty

RNDR_HEXALINEAR_DEG2_DPEN := $(patsubst %, render/hexalinear/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_QUADTREE_DEG2_DPEN := $(patsubst %, render/quadtree/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_DPEN := $(patsubst %, render/chulloctilinear/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_DPEN := $(patsubst %, render/octihanan/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_DPEN := $(patsubst %, render/octihanan2/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_PORTHORAD_DEG2_DPEN := $(patsubst %, render/porthorad/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

.PHONY: render render-octihanan render-octihanan2 render-porthoradial render-base render-deg2 render-deg2-dpen ilp-base ilp-deg2 ilp ilp-solve-base ilp-solve-deg2 ilp-solve clean list all help

.SECONDARY:


# octilinearize evaluation inputs

## with deg 2 + density

render/octilinear/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --deg2-heur --density-pen 10  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## with deg 2

render/octilinear/$(GRIDSIZE)/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## without deg 2

render/octilinear/$(GRIDSIZE)/base/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%"  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## hexalinear with deg 2

render/hexalinear/$(GRIDSIZE)/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --base-graph=hexalinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## hexalinear with deg 2 + density pen

render/hexalinear/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --density-pen 10 --base-graph=hexalinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## convex hull octilinear with deg 2

render/chulloctilinear/$(GRIDSIZE)/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --base-graph=chulloctilinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## convex hull with deg 2 + density pen

render/chulloctilinear/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --density-pen 10 --base-graph=chulloctilinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## quad tree with deg 2

render/quadtree/$(GRIDSIZE)/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --base-graph=quadtree --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## convex hull with deg 2 + density pen

render/quadtree/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --density-pen 10 --base-graph=quadtree --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## octihanan with deg 2

render/octihanan/$(GRIDSIZE)/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## octihanan with deg 2 + density pen

render/octihanan/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --density-pen 10 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## octihanan2 with deg 2

render/octihanan2/$(GRIDSIZE)/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --hanan-iters 2 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## octihanan2 with deg 2 + density pen

render/octihanan2/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --hanan-iters 2 --density-pen 10 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## pseudo orthoradial with deg 2

render/porthorad/$(GRIDSIZE)/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --base-graph=porthoradial --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## porthoradial with deg 2 + density pen

render/porthorad/$(GRIDSIZE)/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "$(GRIDSIZE)%" --density-pen 10 --base-graph=porthoradial --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

list:
	@echo $(DATASETS) | tr ' ' '\n'

render-quadtree-deg2: $(RNDR_QUADTREE_DEG2)

render-hexalinear-deg2: $(RNDR_HEXALINEAR_DEG2)

render-chulloctilinear-deg2: $(RNDR_CHULLOCTILINEAR_DEG2)

render-octihanan-deg2: $(RNDR_OCTIHANAN_DEG2)

render-octihanan2-deg2: $(RNDR_OCTIHANAN2_DEG2)

render-porthoradial-deg2: $(RNDR_PORTHORAD_DEG2)

render-quadtree-deg2-dpen: $(RNDR_QUADTREE_DEG2_DPEN)

render-hexalinear-deg2-dpen: $(RNDR_HEXALINEAR_DEG2_DPEN)

render-chulloctilinear-deg2-dpen: $(RNDR_CHULLOCTILINEAR_DEG2_DPEN)

render-octihanan-deg2-dpen: $(RNDR_OCTIHANAN_DEG2_DPEN)

render-octihanan2-deg2-dpen: $(RNDR_OCTIHANAN2_DEG2_DPEN)

render-porthoradial-deg2-dpen: $(RNDR_PORTHORAD_DEG2_DPEN)

render-deg2-dpen: $(RNDR_DEG2_DPEN)

render-deg2: $(RNDR_DEG2)

render-base: $(RNDR)

render: render-deg2-dpen render-deg2 render-base

all: render

help:
	cat README.md

clean:
	rm -rf ilp
	rm -rf render
	rm -rf render-orthorad
	rm -rf solver_runs
