# (C) 2019 University of Freiburg
# Chair of Algorithms and Data Structures
# Authors: Patrick Brosi (brosi@cs.uni-freiburg.de)

OCTI = /home/patrick/repos/loom/build/octi
ILP_TIMEOUT = 43200 # timeout = 12 hours
ILP_CACHE_DIR = /tmp
METHOD = heur

GLOB_ARGS = --stats -o $(METHOD) --ilp-cache-dir $(ILP_CACHE_DIR) --ilp-time-limit $(ILP_TIMEOUT) --restr-loc-search

DATASETS = $(basename $(notdir $(wildcard datasets/*.json)))

# standard graph

RNDR_DEG2_75 := $(patsubst %, render/75/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_DEG2_100 := $(patsubst %, render/100/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_DEG2_125 := $(patsubst %, render/125/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_DEG2_DPEN_75 := $(patsubst %, render/75/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_DEG2_DPEN_100 := $(patsubst %, render/100/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_DEG2_DPEN_125 := $(patsubst %, render/125/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_75 := $(patsubst %, render/75/base/%/res_$(METHOD).json, $(DATASETS))
RNDR_100 := $(patsubst %, render/100/base/%/res_$(METHOD).json, $(DATASETS))
RNDR_125 := $(patsubst %, render/125/base/%/res_$(METHOD).json, $(DATASETS))

# special graphs without deg 2

RNDR_HEXALINEAR_75 := $(patsubst %, render-hexalinear/75/%/res_$(METHOD).json, $(DATASETS))
RNDR_HEXALINEAR_100 := $(patsubst %, render-hexalinear/100/%/res_$(METHOD).json, $(DATASETS))
RNDR_HEXALINEAR_125 := $(patsubst %, render-hexalinear/125/%/res_$(METHOD).json, $(DATASETS))

RNDR_QUADTREE_75 := $(patsubst %, render-quadtree/75/%/res_$(METHOD).json, $(DATASETS))
RNDR_QUADTREE_100 := $(patsubst %, render-quadtree/100/%/res_$(METHOD).json, $(DATASETS))
RNDR_QUADTREE_125 := $(patsubst %, render-quadtree/125/%/res_$(METHOD).json, $(DATASETS))

RNDR_CHULLOCTILINEAR_75 := $(patsubst %, render-chulloctilinear/75/%/res_$(METHOD).json, $(DATASETS))
RNDR_CHULLOCTILINEAR_100 := $(patsubst %, render-chulloctilinear/100/%/res_$(METHOD).json, $(DATASETS))
RNDR_CHULLOCTILINEAR_125 := $(patsubst %, render-chulloctilinear/125/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN_75 := $(patsubst %, render-octihanan/75/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN_100 := $(patsubst %, render-octihanan/100/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN_125 := $(patsubst %, render-octihanan/125/%/res_$(METHOD).json, $(DATASETS))

RNDR_PORTHORAD_75 := $(patsubst %, render-porthorad/75/%/res_$(METHOD).json, $(DATASETS))
RNDR_PORTHORAD_100 := $(patsubst %, render-porthorad/100/%/res_$(METHOD).json, $(DATASETS))
RNDR_PORTHORAD_125 := $(patsubst %, render-porthorad/125/%/res_$(METHOD).json, $(DATASETS))

# special graphs with deg 2

RNDR_HEXALINEAR_DEG2_75 := $(patsubst %, render-hexalinear/75/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_HEXALINEAR_DEG2_100 := $(patsubst %, render-hexalinear/100/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_HEXALINEAR_DEG2_125 := $(patsubst %, render-hexalinear/125/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_QUADTREE_DEG2_75 := $(patsubst %, render-quadtree/75/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_QUADTREE_DEG2_100 := $(patsubst %, render-quadtree/100/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_QUADTREE_DEG2_125 := $(patsubst %, render-quadtree/125/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_75 := $(patsubst %, render-chulloctilinear/75/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_CHULLOCTILINEAR_DEG2_100 := $(patsubst %, render-chulloctilinear/100/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_CHULLOCTILINEAR_DEG2_125 := $(patsubst %, render-chulloctilinear/125/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_75 := $(patsubst %, render-octihanan/75/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN_DEG2_100 := $(patsubst %, render-octihanan/100/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN_DEG2_125 := $(patsubst %, render-octihanan/125/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_75 := $(patsubst %, render-octihanan2/75/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN2_DEG2_100 := $(patsubst %, render-octihanan2/100/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN2_DEG2_125 := $(patsubst %, render-octihanan2/125/deg2/%/res_$(METHOD).json, $(DATASETS))

RNDR_PORTHORAD_DEG2_75 := $(patsubst %, render-porthorad/75/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_PORTHORAD_DEG2_100 := $(patsubst %, render-porthorad/100/deg2/%/res_$(METHOD).json, $(DATASETS))
RNDR_PORTHORAD_DEG2_125 := $(patsubst %, render-porthorad/125/deg2/%/res_$(METHOD).json, $(DATASETS))

# special graphs with deg 2 and density penalty

RNDR_HEXALINEAR_DEG2_DPEN_75 := $(patsubst %, render-hexalinear/75/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_HEXALINEAR_DEG2_DPEN_100 := $(patsubst %, render-hexalinear/100/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_HEXALINEAR_DEG2_DPEN_125 := $(patsubst %, render-hexalinear/125/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_QUADTREE_DEG2_DPEN_75 := $(patsubst %, render-quadtree/75/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_QUADTREE_DEG2_DPEN_100 := $(patsubst %, render-quadtree/100/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_QUADTREE_DEG2_DPEN_125 := $(patsubst %, render-quadtree/125/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_DPEN_75 := $(patsubst %, render-chulloctilinear/75/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_CHULLOCTILINEAR_DEG2_DPEN_100 := $(patsubst %, render-chulloctilinear/100/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_CHULLOCTILINEAR_DEG2_DPEN_125 := $(patsubst %, render-chulloctilinear/125/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_DPEN_75 := $(patsubst %, render-octihanan/75/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN_DEG2_DPEN_100 := $(patsubst %, render-octihanan/100/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN_DEG2_DPEN_125 := $(patsubst %, render-octihanan/125/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_DPEN_75 := $(patsubst %, render-octihanan2/75/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN2_DEG2_DPEN_100 := $(patsubst %, render-octihanan2/100/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_OCTIHANAN2_DEG2_DPEN_125 := $(patsubst %, render-octihanan2/125/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

RNDR_PORTHORAD_DEG2_DPEN_75 := $(patsubst %, render-porthorad/75/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_PORTHORAD_DEG2_DPEN_100 := $(patsubst %, render-porthorad/100/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))
RNDR_PORTHORAD_DEG2_DPEN_125 := $(patsubst %, render-porthorad/125/deg2-dpen/%/res_$(METHOD).json, $(DATASETS))

.PHONY: render render-octihanan render-octihanan2 render-porthoradial render-base render-deg2 render-deg2-dpen ilp-base ilp-deg2 ilp ilp-solve-base ilp-solve-deg2 ilp-solve clean list all help

.SECONDARY:


# octilinearize evaluation inputs

## with deg 2 + density

render/75/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --deg2-heur --density-pen 10  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/100/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%" --deg2-heur --density-pen 10  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"
	@printf "[%s] Done.\n" "$$(date -Is)"

render/125/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --deg2-heur --density-pen 10  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## with deg 2

render/75/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/100/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%" --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/125/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## without deg 2

render/75/base/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%"  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/100/base/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%"  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/125/base/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%"  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"
	@printf "[%s] Done.\n" "$$(date -Is)"

## hexalinear with deg 2

render-hexalinear/75/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --base-graph=hexalinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-hexalinear/100/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%" --base-graph=hexalinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-hexalinear/125/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --base-graph=hexalinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## hexalinear with deg 2 + density pen

render-hexalinear/75/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --density-pen 10 --base-graph=hexalinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-hexalinear/100/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%"  --density-pen 10 --base-graph=hexalinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-hexalinear/125/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --density-pen 10  --base-graph=hexalinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## convex hull octilinear with deg 2

render-chulloctilinear/75/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --base-graph=chulloctilinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-chulloctilinear/100/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%" --base-graph=chulloctilinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-chulloctilinear/125/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --base-graph=chulloctilinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## convex hull with deg 2 + density pen

render-chulloctilinear/75/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --density-pen 10 --base-graph=chulloctilinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-chulloctilinear/100/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%"  --density-pen 10 --base-graph=chulloctilinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-chulloctilinear/125/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --density-pen 10  --base-graph=chulloctilinear --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## quad tree with deg 2

render-quadtree/75/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --base-graph=quadtree --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-quadtree/100/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%" --base-graph=quadtree --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-quadtree/125/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --base-graph=quadtree --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## convex hull with deg 2 + density pen

render-quadtree/75/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --density-pen 10 --base-graph=quadtree --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-quadtree/100/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%"  --density-pen 10 --base-graph=quadtree --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-quadtree/125/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --density-pen 10  --base-graph=quadtree --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## octihanan with deg 2

render-octihanan/75/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-octihanan/100/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%" --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-octihanan/125/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## octihanan with deg 2 + density pen

render-octihanan/75/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --density-pen 10 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-octihanan/100/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%"  --density-pen 10 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-octihanan/125/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --density-pen 10  --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## octihanan2 with deg 2

render-octihanan2/75/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --hanan-iters 2 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-octihanan2/100/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%" --hanan-iters 2 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-octihanan2/125/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --hanan-iters 2 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## octihanan2 with deg 2 + density pen

render-octihanan2/75/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --hanan-iters 2 --density-pen 10 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-octihanan2/100/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%" --hanan-iters 2   --density-pen 10 --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-octihanan2/125/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --hanan-iters 2 --density-pen 10  --base-graph=octihanan --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## pseudo orthoradial with deg 2

render-porthorad/75/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --base-graph=porthoradial --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-porthorad/100/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%" --base-graph=porthoradial --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-porthorad/125/deg2/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --base-graph=porthoradial --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## porthoradial with deg 2 + density pen

render-porthorad/75/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "75%" --density-pen 10 --base-graph=porthoradial --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-porthorad/100/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "100%"  --density-pen 10 --base-graph=porthoradial --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render-porthorad/125/deg2-dpen/%/res_$(METHOD).json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) $(GLOB_ARGS) --grid-size "125%" --density-pen 10  --base-graph=porthoradial --deg2-heur  < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

list:
	@echo $(DATASETS) | tr ' ' '\n'

render-quadtree-deg2: $(RNDR_QUADTREE_DEG2_75) $(RNDR_QUADTREE_DEG2_100) $(RNDR_QUADTREE_DEG2_125)

render-hexalinear-deg2: $(RNDR_HEXALINEAR_DEG2_75) $(RNDR_HEXALINEAR_DEG2_100) $(RNDR_HEXALINEAR_DEG2_125)

render-chulloctilinear-deg2: $(RNDR_CHULLOCTILINEAR_DEG2_75) $(RNDR_CHULLOCTILINEAR_DEG2_100) $(RNDR_CHULLOCTILINEAR_DEG2_125)

render-octihanan-deg2: $(RNDR_OCTIHANAN_DEG2_75) $(RNDR_OCTIHANAN_DEG2_100) $(RNDR_OCTIHANAN_DEG2_125)

render-octihanan2-deg2: $(RNDR_OCTIHANAN2_DEG2_75) $(RNDR_OCTIHANAN2_DEG2_100) $(RNDR_OCTIHANAN2_DEG2_125)

render-porthoradial-deg2: $(RNDR_PORTHORAD_DEG2_75) $(RNDR_PORTHORAD_DEG2_100) $(RNDR_PORTHORAD_DEG2_125)

render-quadtree-deg2-dpen: $(RNDR_QUADTREE_DEG2_DPEN_75) $(RNDR_QUADTREE_DEG2_DPEN_100) $(RNDR_QUADTREE_DEG2_DPEN_125)

render-hexalinear-deg2-dpen: $(RNDR_HEXALINEAR_DEG2_DPEN_75) $(RNDR_HEXALINEAR_DEG2_DPEN_100) $(RNDR_HEXALINEAR_DEG2_DPEN_125)

render-chulloctilinear-deg2-dpen: $(RNDR_CHULLOCTILINEAR_DEG2_DPEN_75) $(RNDR_CHULLOCTILINEAR_DEG2_DPEN_100) $(RNDR_CHULLOCTILINEAR_DEG2_DPEN_125)

render-octihanan-deg2-dpen: $(RNDR_OCTIHANAN_DEG2_DPEN_75) $(RNDR_OCTIHANAN_DEG2_DPEN_100) $(RNDR_OCTIHANAN_DEG2_DPEN_125)

render-octihanan2-deg2-dpen: $(RNDR_OCTIHANAN2_DEG2_DPEN_75) $(RNDR_OCTIHANAN2_DEG2_DPEN_100) $(RNDR_OCTIHANAN2_DEG2_DPEN_125)

render-porthoradial-deg2-dpen: $(RNDR_PORTHORAD_DEG2_DPEN_75) $(RNDR_PORTHORAD_DEG2_DPEN_100) $(RNDR_PORTHORAD_DEG2_DPEN_125)

render-deg2-dpen: $(RNDR_DEG2_DPEN_75) $(RNDR_DEG2_DPEN_100) $(RNDR_DEG2_DPEN_125)

render-deg2: $(RNDR_DEG2_75) $(RNDR_DEG2_100) $(RNDR_DEG2_125)

render-base: $(RNDR_75) $(RNDR_100) $(RNDR_125)

render: render-deg2-dpen render-deg2 render-base

all: render

help:
	cat README.md

clean:
	rm -rf ilp
	rm -rf render
	rm -rf render-orthorad
	rm -rf solver_runs
