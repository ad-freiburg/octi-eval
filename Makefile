# (C) 2019 University of Freiburg
# Chair of Algorithms and Data Structures
# Authors: Patrick Brosi (brosi@cs.uni-freiburg.de)

OCTI = octi

RESULTS_DIR := results
TABLES_DIR := tables

ILP_TIMEOUT = 43200 # timeout = 12 hours
ILP_CACHE_DIR = /tmp

GLOB_ARGS = OCTI=$(OCTI) ILP_TIMEOUT=$(ILP_TIMEOUT) ILP_CACHE_DIR=$(ILP_CACHE_DIR) RESULTS_DIR=$(RESULTS_DIR)

DATASETS = $(basename $(notdir $(wildcard datasets/*.json)))

# standard graph, heur

## 75
RNDR_DEG2_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/75/deg2/res_heur.json, $(DATASETS))

RNDR_DEG2_DPEN_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/75/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/75/base/res_heur.json, $(DATASETS))

## 100
RNDR_DEG2_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/100/deg2/res_heur.json, $(DATASETS))

RNDR_DEG2_DPEN_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/100/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/100/base/res_heur.json, $(DATASETS))

## 125
RNDR_DEG2_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/125/deg2/res_heur.json, $(DATASETS))

RNDR_DEG2_DPEN_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/125/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/125/base/res_heur.json, $(DATASETS))


# standard graph, ILP

## 75
RNDR_DEG2_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/75/deg2/res_ilp.json, $(DATASETS))

RNDR_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/75/base/res_ilp.json, $(DATASETS))

## 100
RNDR_DEG2_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/100/deg2/res_ilp.json, $(DATASETS))

RNDR_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/100/base/res_ilp.json, $(DATASETS))

## 125
RNDR_DEG2_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/125/deg2/res_ilp.json, $(DATASETS))

RNDR_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/octilinear/125/base/res_ilp.json, $(DATASETS))


RNDR_BASE :=  $(RNDR_HEUR_75) $(RNDR_HEUR_100) $(RNDR_HEUR_125) $(RNDR_ILP_75) $(RNDR_ILP_100) $(RNDR_ILP_125)

RNDR_DEG2 := $(RNDR_DEG2_HEUR_75) $(RNDR_DEG2_HEUR_100) $(RNDR_DEG2_HEUR_125) $(RNDR_DEG2_ILP_75) $(RNDR_DEG2_ILP_100) $(RNDR_DEG2_ILP_125)

RNDR_DEG2_DPEN := $(RNDR_DEG2_DPEN_HEUR_75) $(RNDR_DEG2_DPEN_HEUR_100) $(RNDR_DEG2_DPEN_HEUR_125) $(RNDR_HEUR_125)


# special graphs without deg 2, heur

## 75
RNDR_HEXALINEAR_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/75/res_heur.json, $(DATASETS))

RNDR_QUADTREE_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/75/res_heur.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/75/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/75/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/75/res_heur.json, $(DATASETS))

## 100
RNDR_HEXALINEAR_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/100/res_heur.json, $(DATASETS))

RNDR_QUADTREE_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/100/res_heur.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/100/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/100/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/100/res_heur.json, $(DATASETS))

## 125
RNDR_HEXALINEAR_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/125/res_heur.json, $(DATASETS))

RNDR_QUADTREE_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/125/res_heur.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/125/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/125/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/125/res_heur.json, $(DATASETS))


# special graphs without deg 2, ILP

## 75
RNDR_HEXALINEAR_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/75/res_ilp.json, $(DATASETS))

RNDR_QUADTREE_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/75/res_ilp.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/75/res_ilp.json, $(DATASETS))

RNDR_OCTIHANAN_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/75/res_ilp.json, $(DATASETS))

RNDR_PORTHORAD_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/75/res_ilp.json, $(DATASETS))

## 100
RNDR_HEXALINEAR_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/100/res_ilp.json, $(DATASETS))

RNDR_QUADTREE_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/100/res_ilp.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/100/res_ilp.json, $(DATASETS))

RNDR_OCTIHANAN_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/100/res_ilp.json, $(DATASETS))

RNDR_PORTHORAD_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/100/res_ilp.json, $(DATASETS))

## 125
RNDR_HEXALINEAR_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/125/res_ilp.json, $(DATASETS))

RNDR_QUADTREE_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/125/res_ilp.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/125/res_ilp.json, $(DATASETS))

RNDR_OCTIHANAN_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/125/res_ilp.json, $(DATASETS))

RNDR_PORTHORAD_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/125/res_ilp.json, $(DATASETS))


# special graphs with deg 2, heur

## 75
RNDR_HEXALINEAR_DEG2_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/75/deg2/res_heur.json, $(DATASETS))

RNDR_QUADTREE_DEG2_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/75/deg2/res_heur.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/75/deg2/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/75/deg2/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/octihanan2/75/deg2/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/75/deg2/res_heur.json, $(DATASETS))

## 100
RNDR_HEXALINEAR_DEG2_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/100/deg2/res_heur.json, $(DATASETS))

RNDR_QUADTREE_DEG2_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/100/deg2/res_heur.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/100/deg2/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/100/deg2/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/octihanan2/100/deg2/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/100/deg2/res_heur.json, $(DATASETS))

## 125
RNDR_HEXALINEAR_DEG2_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/125/deg2/res_heur.json, $(DATASETS))

RNDR_QUADTREE_DEG2_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/125/deg2/res_heur.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/125/deg2/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/125/deg2/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/octihanan2/125/deg2/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/125/deg2/res_heur.json, $(DATASETS))


# special graphs with deg 2, ILP

## 75
RNDR_HEXALINEAR_DEG2_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/75/deg2/res_ilp.json, $(DATASETS))

RNDR_QUADTREE_DEG2_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/75/deg2/res_ilp.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/75/deg2/res_ilp.json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/75/deg2/res_ilp.json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/octihanan2/75/deg2/res_ilp.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_ILP_75 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/75/deg2/res_ilp.json, $(DATASETS))

## 100
RNDR_HEXALINEAR_DEG2_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/100/deg2/res_ilp.json, $(DATASETS))

RNDR_QUADTREE_DEG2_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/100/deg2/res_ilp.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/100/deg2/res_ilp.json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/100/deg2/res_ilp.json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/octihanan2/100/deg2/res_ilp.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_ILP_100 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/100/deg2/res_ilp.json, $(DATASETS))

## 125
RNDR_HEXALINEAR_DEG2_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/125/deg2/res_ilp.json, $(DATASETS))

RNDR_QUADTREE_DEG2_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/125/deg2/res_ilp.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/125/deg2/res_ilp.json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/125/deg2/res_ilp.json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/octihanan2/125/deg2/res_ilp.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_ILP_125 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/125/deg2/res_ilp.json, $(DATASETS))


RNDR_PORTHORAD_DEG2 = $(RNDR_PORTHORAD_DEG2_HEUR_75) $(RNDR_PORTHORAD_DEG2_HEUR_100) $(RNDR_PORTHORAD_DEG2_HEUR_125) $(RNDR_PORTHORAD_DEG2_ILP_75) $(RNDR_PORTHORAD_DEG2_ILP_100) $(RNDR_PORTHORAD_DEG2_ILP_125)
RNDR_CHULLOCTILINEAR_DEG2 = $(RNDR_CHULLOCTILINEAR_DEG2_HEUR_75) $(RNDR_CHULLOCTILINEAR_DEG2_HEUR_100) $(RNDR_CHULLOCTILINEAR_DEG2_HEUR_125) $(RNDR_CHULLOCTILINEAR_DEG2_ILP_75) $(RNDR_CHULLOCTILINEAR_DEG2_ILP_100) $(RNDR_CHULLOCTILINEAR_DEG2_ILP_125)
RNDR_OCTIHANAN_DEG2 = $(RNDR_OCTIHANAN_DEG2_HEUR_75) $(RNDR_OCTIHANAN_DEG2_HEUR_100) $(RNDR_OCTIHANAN_DEG2_HEUR_125) $(RNDR_OCTIHANAN_DEG2_ILP_75) $(RNDR_OCTIHANAN_DEG2_ILP_100) $(RNDR_OCTIHANAN_DEG2_ILP_125)
RNDR_QUADTREE_DEG2 = $(RNDR_QUADTREE_DEG2_HEUR_75) $(RNDR_QUADTREE_DEG2_HEUR_100) $(RNDR_QUADTREE_DEG2_HEUR_125) $(RNDR_QUADTREE_DEG2_ILP_75) $(RNDR_QUADTREE_DEG2_ILP_100) $(RNDR_QUADTREE_DEG2_ILP_125)
RNDR_HEXALINEAR_DEG2 = $(RNDR_HEXALINEAR_DEG2_HEUR_75) $(RNDR_HEXALINEAR_DEG2_HEUR_100) $(RNDR_HEXALINEAR_DEG2_HEUR_125) $(RNDR_HEXALINEAR_DEG2_ILP_75) $(RNDR_HEXALINEAR_DEG2_ILP_100) $(RNDR_HEXALINEAR_DEG2_ILP_125)
RNDR_PORTHORAD_DEG2 = $(RNDR_PORTHORAD_DEG2_HEUR_75) $(RNDR_PORTHORAD_DEG2_HEUR_100) $(RNDR_PORTHORAD_DEG2_HEUR_125) $(RNDR_PORTHORAD_DEG2_ILP_75) $(RNDR_PORTHORAD_DEG2_ILP_100) $(RNDR_PORTHORAD_DEG2_ILP_125)


# special graphs with deg 2 and density penalty, heur

## 75

RNDR_HEXALINEAR_DEG2_DPEN_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/75/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_QUADTREE_DEG2_DPEN_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/75/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_DPEN_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/75/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_DPEN_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/75/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_DPEN_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/octihanan2/75/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_DPEN_HEUR_75 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/75/deg2-dpen/res_heur.json, $(DATASETS))

## 100

RNDR_HEXALINEAR_DEG2_DPEN_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/100/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_QUADTREE_DEG2_DPEN_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/100/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_DPEN_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/100/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_DPEN_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/100/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_DPEN_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/octihanan2/100/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_DPEN_HEUR_100 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/100/deg2-dpen/res_heur.json, $(DATASETS))


## 125

RNDR_HEXALINEAR_DEG2_DPEN_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/hexalinear/125/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_QUADTREE_DEG2_DPEN_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/quadtree/125/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_CHULLOCTILINEAR_DEG2_DPEN_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/chulloctilinear/125/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN_DEG2_DPEN_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/octihanan/125/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_OCTIHANAN2_DEG2_DPEN_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/octihanan2/125/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_DPEN_HEUR_125 := $(patsubst %, $(RESULTS_DIR)/%/porthorad/125/deg2-dpen/res_heur.json, $(DATASETS))

RNDR_PORTHORAD_DEG2_DPEN = $(RNDR_PORTHORAD_DEG2_DPEN_HEUR_75) $(RNDR_PORTHORAD_DEG2_DPEN_HEUR_100) $(RNDR_PORTHORAD_DEG2_DPEN_HEUR_125)
RNDR_CHULLOCTILINEAR_DEG2_DPEN = $(RNDR_CHULLOCTILINEAR_DEG2_DPEN_HEUR_75) $(RNDR_CHULLOCTILINEAR_DEG2_DPEN_HEUR_100) $(RNDR_CHULLOCTILINEAR_DEG2_DPEN_HEUR_125)
RNDR_OCTIHANAN_DEG2_DPEN = $(RNDR_OCTIHANAN_DEG2_DPEN_HEUR_75) $(RNDR_OCTIHANAN_DEG2_DPEN_HEUR_100) $(RNDR_OCTIHANAN_DEG2_DPEN_HEUR_125)
RNDR_QUADTREE_DEG2_DPEN = $(RNDR_QUADTREE_DEG2_DPEN_HEUR_75) $(RNDR_QUADTREE_DEG2_DPEN_HEUR_100) $(RNDR_QUADTREE_DEG2_DPEN_HEUR_125)
RNDR_HEXALINEAR_DEG2_DPEN = $(RNDR_HEXALINEAR_DEG2_DPEN_HEUR_75) $(RNDR_HEXALINEAR_DEG2_DPEN_HEUR_100) $(RNDR_HEXALINEAR_DEG2_DPEN_HEUR_125)
RNDR_PORTHORAD_DEG2_DPEN = $(RNDR_PORTHORAD_DEG2_DPEN_HEUR_75) $(RNDR_PORTHORAD_DEG2_DPEN_HEUR_100) $(RNDR_PORTHORAD_DEG2_DPEN_HEUR_125)

list:
	@echo $(DATASETS) | tr ' ' '\n'

$(RESULTS_DIR)/%/octilinear/75/base/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=75 $@

$(RESULTS_DIR)/%/octilinear/100/base/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=100 $@

$(RESULTS_DIR)/%/octilinear/125/base/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=125 $@

$(RESULTS_DIR)/%/octilinear/75/deg2/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=75 $@

$(RESULTS_DIR)/%/octilinear/100/deg2/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=100 $@

$(RESULTS_DIR)/%/octilinear/100/deg2-glpk/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=100 $@

$(RESULTS_DIR)/%/octilinear/125/deg2/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=125 $@

$(RESULTS_DIR)/%/octilinear/75/deg2-dpen/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=75 $@

$(RESULTS_DIR)/%/octilinear/100/deg2-dpen/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=100 $@

$(RESULTS_DIR)/%/octilinear/125/deg2-dpen/res_heur.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=heur GRIDSIZE=125 $@




$(RESULTS_DIR)/%/octilinear/75/base/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=ilp GRIDSIZE=75 $@

$(RESULTS_DIR)/%/octilinear/100/base/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=ilp GRIDSIZE=100 $@

$(RESULTS_DIR)/%/octilinear/125/base/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=ilp GRIDSIZE=125 $@

$(RESULTS_DIR)/%/octilinear/75/deg2/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=ilp GRIDSIZE=75 $@

$(RESULTS_DIR)/%/octilinear/100/deg2/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=ilp GRIDSIZE=100 $@

# with explicit solvers
$(RESULTS_DIR)/%/octilinear/100/deg2-gurobi/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) ILP_SOLVER=gurobi METHOD=ilp GRIDSIZE=100 $@

$(RESULTS_DIR)/%/octilinear/100/deg2-cbc/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) ILP_SOLVER=cbc METHOD=ilp GRIDSIZE=100 $@

$(RESULTS_DIR)/%/octilinear/100/deg2-glpk/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) ILP_SOLVER=glpk METHOD=ilp GRIDSIZE=100 $@


$(RESULTS_DIR)/%/octilinear/125/deg2/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=ilp GRIDSIZE=125 $@

$(RESULTS_DIR)/%/octilinear/75/deg2-dpen/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=ilp GRIDSIZE=75 $@

$(RESULTS_DIR)/%/octilinear/100/deg2-dpen/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=ilp GRIDSIZE=100 $@

$(RESULTS_DIR)/%/octilinear/125/deg2-dpen/res_ilp.json:
	@make -f Makefile-aux $(GLOB_ARGS) METHOD=ilp GRIDSIZE=125 $@


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

render-base: $(RNDR_BASE)

render: render-deg2-dpen render-deg2 render-base render-quadtree-deg2 render-hexalinear-deg2 render-chulloctilinear-deg2 render-octihanan-deg2 render-octihanan2-deg2 render-porthoradial-deg2 render-quadtree-deg2-dpen render-hexalinear-deg2-dpen render-chulloctilinear-deg2-dpen render-octihanan-deg2-dpen render-octihanan2-deg2-dpen render-porthoradial-deg2-dpen

all: render

## tables
$(TABLES_DIR)/tbl-overview.tex: script/table.py script/template.tex $(RNDR_DEG2_HEUR_100)
	@mkdir -p $(TABLES_DIR)
	@python3 script/table.py overview $(patsubst %, $(RESULTS_DIR)/%, $(DATASETS)) > $@

$(TABLES_DIR)/tbl-overview.pdf: $(TABLES_DIR)/tbl-overview.tex
	@printf "[%s] Generating $@ ... \n" "$$(date -Is)"
	@cat script/template.tex > $(TABLES_DIR)/tmp
	@cat $^ >> $(TABLES_DIR)/tmp
	@echo "\\\end{document}" >> $(TABLES_DIR)/tmp
	@pdflatex -output-directory=$(TABLES_DIR) -jobname=tbl-overview $(TABLES_DIR)/tmp > /dev/null
	@rm $(TABLES_DIR)/tmp

$(TABLES_DIR)/tbl-ilp-solve-raw.tex: script/table.py script/template.tex $(RNDR_ILP_75) $(RNDR_ILP_100) $(RNDR_ILP_125)
	@mkdir -p $(TABLES_DIR)
	@python3 script/table.py ilp-solve-raw $(patsubst %, $(RESULTS_DIR)/%, $(DATASETS)) > $@

$(TABLES_DIR)/tbl-ilp-solve-raw.pdf: $(TABLES_DIR)/tbl-ilp-solve-raw.tex
	@printf "[%s] Generating $@ ... \n" "$$(date -Is)"
	@cat script/template.tex > $(TABLES_DIR)/tmp
	@cat $^ >> $(TABLES_DIR)/tmp
	@echo "\\\end{document}" >> $(TABLES_DIR)/tmp
	@pdflatex -output-directory=$(TABLES_DIR) -jobname=tbl-ilp-solve-raw $(TABLES_DIR)/tmp > /dev/null
	@rm $(TABLES_DIR)/tmp

$(TABLES_DIR)/tbl-ilp-solve-deg2.tex: script/table.py script/template.tex $(RNDR_DEG2_ILP_75) $(RNDR_DEG2_ILP_100) $(RNDR_DEG2_ILP_125)
	@mkdir -p $(TABLES_DIR)
	@python3 script/table.py ilp-solve-deg2 $(patsubst %, $(RESULTS_DIR)/%, $(DATASETS)) > $@

$(TABLES_DIR)/tbl-ilp-solve-deg2.pdf: $(TABLES_DIR)/tbl-ilp-solve-deg2.tex
	@printf "[%s] Generating $@ ... \n" "$$(date -Is)"
	@cat script/template.tex > $(TABLES_DIR)/tmp
	@cat $^ >> $(TABLES_DIR)/tmp
	@echo "\\\end{document}" >> $(TABLES_DIR)/tmp
	@pdflatex -output-directory=$(TABLES_DIR) -jobname=tbl-ilp-solve-deg2 $(TABLES_DIR)/tmp > /dev/null
	@rm $(TABLES_DIR)/tmp

help:
	@cat README.md

check:
	@echo "glpk version:  " `glpsol --version | head -n1 | cut -d'v' -f3`
	@echo "CBC version:   " `echo "x" | cbc | head -n2 | tail -n1 | cut -d' ' -f2`
	@echo "gurobi version:" `gurobi_cl --version | head -n1 | cut -dv -f3 | cut -d' ' -f1`
	@echo "gurobi license:"
	@gurobi_cl --license
	@echo "octi version:" `$(OCTI) --version`
	@echo "results dir:" $(RESULTS_DIR)
	@echo "timeout:" $(OVERALL_TIMEOUT)s
	@echo "ILP cache dir:" $(ILP_CACHE_DIR)

clean:
	rm -rf $(RESULTS_DIR)
	rm -rf $(TABLES_DIR)
