# octi eval

Evaluation runs for octi.

This repo contains test line graphs for several test network. The Makefile is intended to evaluate octi on all of these datasets, using various methods, and write the results into .tex tables. It also produces PDF versions of these tables for debugging and quick checking.

**IMPORTANT:** To evaluate the ILPs against the `gurobi` solver, a gurobi license file must be present on your system at the location specified in the environment variable `GRB_LICENSE_FILE`. If you use the Docker container (see below), the file must be placed at `/output/gurobi.lic`.

## Usage

The following targets are provided:

**`list`**: List all available networks in `./datasets`

**`help`**: Show this README.

**`check`**: Run some checks on the environment.

**`render`**: Octilinearize all input line graphs in `./datasets` to `./results`.

**`tables`**: Generate all tables in `./tables`

For additional targets, see the Makefile itself.

Log files are always written to the corresponding output directory and have the same name as the generated file, ending with `.log`.

### Parameters

The following parameters are read by the Makefile:

**`DATASETS`**: Datasets to use, whitespace separated. For each dataset, the line graph must be present at `./datasets/<dataset>.json`. By default, this is set to all networks in `dataset`.

**`OCTI`**: Path to the octi binary.

**`ILP_TIMEOUT`** `(=43200)`: Seconds after which the ILP solve will be cancelled (in seconds, default is 12 hours).

**`ILP_CACHE_DIR`** `(=.)`: If supported by the solver, cache directory

**`ILP_SOLVER** `(=gurobi)`: The ILP solver to use.

### Usage examples

**`make DATASETS=freiburg table`**
Produce evaluation tables for the Freiburg dataset

## Run with Docker

Build the container:

    $ docker build -t octi-eval .

Run the evaluation:

    $ docker run octi-eval <TARGET>

where `<TARGET>` is the Makefile target (see above).

Evaluation results will be output to `/output` inside the container. To retrieve them, mount `/output` to a local folder:

    $ docker run -v /local/folder/:/output octi-eval <TARGET>
