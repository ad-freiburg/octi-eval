# (C) 2019 University of Freiburg
# Chair of Algorithms and Data Structures
# Authors: Patrick Brosi (brosi@cs.uni-freiburg.de)

OCTI = /home/patrick/repos/loom/build/octi
GUROBI_THREADS = 8
GUROBI_TIMEOUT = 86400 # timeout = 24 hours
GUROBI_NODEFILE_DIR = .

DATASETS = $(basename $(notdir $(wildcard datasets/*.json)))

ILPS_75 := $(patsubst %, ilp/75/base/%/problem.mps, $(DATASETS))
ILPS_100 := $(patsubst %, ilp/100/base/%/problem.mps, $(DATASETS))
ILPS_125 := $(patsubst %, ilp/125/base/%/problem.mps, $(DATASETS))

ILPS_DEG2_75 := $(patsubst %, ilp/75/deg2/%/problem.mps, $(DATASETS))
ILPS_DEG2_100 := $(patsubst %, ilp/100/deg2/%/problem.mps, $(DATASETS))
ILPS_DEG2_125 := $(patsubst %, ilp/125/deg2/%/problem.mps, $(DATASETS))

ILP_SOLVES_75 := $(patsubst %, solver_runs/75/base/%/solution.sol, $(DATASETS))
ILP_SOLVES_100 := $(patsubst %, solver_runs/100/base/%/solution.sol, $(DATASETS))
ILP_SOLVES_125 := $(patsubst %, solver_runs/125/base/%/solution.sol, $(DATASETS))

ILP_SOLVES_DEG2_75 := $(patsubst %, solver_runs/75/deg2/%/solution.sol, $(DATASETS))
ILP_SOLVES_DEG2_100 := $(patsubst %, solver_runs/100/deg2/%/solution.sol, $(DATASETS))
ILP_SOLVES_DEG2_125 := $(patsubst %, solver_runs/125/deg2/%/solution.sol, $(DATASETS))

ILP_WOS_SOLVES_75 := $(patsubst %, solver_runs/75/base/%/solution_wostart.sol, $(DATASETS))
ILP_WOS_SOLVES_100 := $(patsubst %, solver_runs/100/base/%/solution_wostart.sol, $(DATASETS))
ILP_WOS_SOLVES_125 := $(patsubst %, solver_runs/125/base/%/solution_wostart.sol, $(DATASETS))

ILP_WOS_SOLVES_DEG2_75 := $(patsubst %, solver_runs/75/deg2/%/solution_wostart.sol, $(DATASETS))
ILP_WOS_SOLVES_DEG2_100 := $(patsubst %, solver_runs/100/deg2/%/solution_wostart.sol, $(DATASETS))
ILP_WOS_SOLVES_DEG2_125 := $(patsubst %, solver_runs/125/deg2/%/solution_wostart.sol, $(DATASETS))

RNDR_DEG2_75 := $(patsubst %, render/75/deg2/%/res_approx.json, $(DATASETS))
RNDR_DEG2_100 := $(patsubst %, render/100/deg2/%/res_approx.json, $(DATASETS))
RNDR_DEG2_125 := $(patsubst %, render/125/deg2/%/res_approx.json, $(DATASETS))

RNDR_DEG2_DPEN_75 := $(patsubst %, render/75/deg2-dpen/%/res_approx.json, $(DATASETS))
RNDR_DEG2_DPEN_100 := $(patsubst %, render/100/deg2-dpen/%/res_approx.json, $(DATASETS))
RNDR_DEG2_DPEN_125 := $(patsubst %, render/125/deg2-dpen/%/res_approx.json, $(DATASETS))

RNDR_75 := $(patsubst %, render/75/base/%/res_approx.json, $(DATASETS))
RNDR_100 := $(patsubst %, render/100/base/%/res_approx.json, $(DATASETS))
RNDR_125 := $(patsubst %, render/125/base/%/res_approx.json, $(DATASETS))

.PHONY: render render-base render-deg2 render-deg2-dpen ilp-base ilp-deg2 ilp ilp-solve-base ilp-solve-deg2 ilp-solve clean list all help

.SECONDARY:


# ILP problem file with presolve

## with deg 2

ilp/75/deg2/%/problem.mps: datasets/%.json
	@printf "[%s] Building ILP $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "75%" --deg2-heur < $< --ilp-no-solve -o ilp --ilp-out $@ > /dev/null 2> $(basename $@).log
	@printf "[%s] Done.\n" "$$(date -Is)"

ilp/100/deg2/%/problem.mps: datasets/%.json
	@printf "[%s] Building ILP $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "100%" --deg2-heur < $< --ilp-no-solve -o ilp --ilp-out $@ > /dev/null 2> $(basename $@).log
	@printf "[%s] Done.\n" "$$(date -Is)"

ilp/125/deg2/%/problem.mps: datasets/%.json
	@printf "[%s] Building ILP $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "125%" --deg2-heur < $< --ilp-no-solve -o ilp --ilp-out $@ > /dev/null 2> $(basename $@).log
	@printf "[%s] Done.\n" "$$(date -Is)"

## without deg 2

ilp/75/base/%/problem.mps: datasets/%.json
	@printf "[%s] Building ILP $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "75%" < $< --ilp-no-solve -o ilp --ilp-out $@ > /dev/null 2> $(basename $@).log
	@printf "[%s] Done.\n" "$$(date -Is)"

ilp/100/base/%/problem.mps: datasets/%.json
	@printf "[%s] Building ILP $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "100%" < $< --ilp-no-solve -o ilp --ilp-out $@ > /dev/null 2> $(basename $@).log
	@printf "[%s] Done.\n" "$$(date -Is)"

ilp/125/base/%/problem.mps: datasets/%.json
	@printf "[%s] Building ILP $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "125%" < $< --ilp-no-solve -o ilp --ilp-out $@ > /dev/null 2> $(basename $@).log
	@printf "[%s] Done.\n" "$$(date -Is)"


# solve the ILPs

solver_runs/%/solution.sol: ilp/%/problem.mps
	@printf "[%s] Producing solution $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@((timeout $(GUROBI_TIMEOUT) /usr/bin/time --format=" == Took total wallclock time of %E ==" gurobi_cl ResultFile=$@ NodefileDir=$(GUROBI_NODEFILE_DIR) LogFile="" NodefileStart=10 Threads=$(GUROBI_THREADS) InputFile=$(dir $<)/problem.mst $< 2>&1) || echo " == Timeout after" $(GUROBI_TIMEOUT) "seconds =="  2>&1) > $(basename $@).log
	@printf "[%s] Done.\n" "$$(date -Is)"

solver_runs/%/solution_wostart.sol: ilp/%/problem.mps
	@printf "[%s] Producing solution (without start) $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@((timeout $(GUROBI_TIMEOUT) /usr/bin/time --format=" == Took total wallclock time of %E ==" gurobi_cl ResultFile=$@ NodefileDir=$(GUROBI_NODEFILE_DIR) LogFile="" NodefileStart=10 Threads=$(GUROBI_THREADS) $< 2>&1) || echo " == Timeout after" $(GUROBI_TIMEOUT) "seconds =="  2>&1) > $(basename $@).log
	@printf "[%s] Done.\n" "$$(date -Is)"


# octilinearize evaluation inputs

## with deg 2 + density

render/75/deg2-dpen/%/res_approx.json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "75%" --deg2-heur --density-pen 10 --restr-loc-search < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/100/deg2-dpen/%/res_approx.json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "100%" --deg2-heur --density-pen 10 --restr-loc-search < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"
	@printf "[%s] Done.\n" "$$(date -Is)"

render/125/deg2-dpen/%/res_approx.json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "125%" --deg2-heur --density-pen 10 --restr-loc-search < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## with deg 2

render/75/deg2/%/res_approx.json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "75%" --deg2-heur --restr-loc-search < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/100/deg2/%/res_approx.json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "100%" --deg2-heur --restr-loc-search < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/125/deg2/%/res_approx.json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "125%" --deg2-heur --restr-loc-search < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

## without deg 2

render/75/base/%/res_approx.json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "75%" --restr-loc-search < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/100/base/%/res_approx.json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "100%" --restr-loc-search < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"

	@printf "[%s] Done.\n" "$$(date -Is)"

render/125/base/%/res_approx.json: datasets/%.json
	@printf "[%s] Schematizing $< to $@ ... \n" "$$(date -Is)"
	@mkdir -p $(dir $@)
	@$(OCTI) --grid-size "125%" --restr-loc-search < $< > $@ 2> $(basename $@).log || printf "[%s] Schematization not successful.\n" "$$(date -Is)"
	@printf "[%s] Done.\n" "$$(date -Is)"

list:
	@echo $(DATASETS) | tr ' ' '\n'

render-deg2-dpen: $(RNDR_DEG2_DPEN_75) $(RNDR_DEG2_DPEN_100) $(RNDR_DEG2_DPEN_125)

render-deg2: $(RNDR_DEG2_75) $(RNDR_DEG2_100) $(RNDR_DEG2_125)

render-base: $(RNDR_75) $(RNDR_100) $(RNDR_125)

render: render-deg2-dpen render-deg2 render-base

ilp-base: $(ILPS_75) $(ILPS_100) $(ILPS_125)

ilp-deg2: $(ILPS_DEG2_75) $(ILPS_DEG2_100) $(ILPS_DEG2_125)

ilp: ilp-base ilp-deg2

ilp: ilp-base ilp-deg2

ilp-solve-base: $(ILP_SOLVES_75) $(ILP_SOLVES_100) $(ILP_SOLVES_125)

ilp-solve-deg2: $(ILP_SOLVES_DEG2_75) $(ILP_SOLVES_DEG2_100) $(ILP_SOLVES_DEG2_125)

ilp-solve: ilp-solve-base ilp-solve-deg2

ilp-solve-base-wos: $(ILP_WOS_SOLVES_75) $(ILP_WOS_SOLVES_100) $(ILP_WOS_SOLVES_125)

ilp-solve-deg2-wos: $(ILP_WOS_SOLVES_DEG2_75) $(ILP_WOS_SOLVES_DEG2_100) $(ILP_WOS_SOLVES_DEG2_125)

ilp-solve-wos: ilp-solve-base-wos ilp-solve-deg2-wos

all: render ilp ilp-solve ilp-solve-wos

help:
	cat README.md

clean:
	rm -rf ilp
	rm -rf render
	rm -rf solver_runs
