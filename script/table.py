#!/usr/bin/python3

# (C) 2021 University of Freiburg
# Chair of Algorithms and Data Structures
# Authors: Patrick Brosi (brosi@cs.uni-freiburg.de)

import json
from statistics import median
import sys
import os
import math

DATASET_LABELS = {
    "test" : "!!TEST!!",
    "freiburg": "Freiburg",
    "dallas": "Dallas",
    "chicago": "Chicago",
    "sydney": "Sydney",
    "sydney2": "Sydney",
    "wien": "Vienna",
    "london": "London",
    "stuttgart": "Sydney",
    "turin": "Turin",
    "nyc_subway": "New York",
    "berlin": "Berlin", 
}

DATASET_LABELS_SHORT = {
    "test": "T!",
    "freiburg": "FR",
    "dallas": "DA",
    "chicago": "CG",
    "sydney": "SD",  
    "berlin": "BE",    
    "wien": "VN",
    "sydney2": "SD2",    
    "london": "LO",
    "stuttgart": "ST",
    "turin": "TU",
    "nyc_subway": "NY",
}


def read_result(path):
    ret = {}
    try:
        with open(path) as f:
            full = json.load(f)
            ret = full["properties"]["statistics"]
    except BaseException:
        pass

    return ret


def read_results(path):
    # all methods are hardcoded here
    ret = {}

    for root, subdirs, files in os.walk(path):
        for filename in files:
            _, ext = os.path.splitext(filename)
            if ext != ".json":
                continue
            file_path = os.path.join(root, filename)
            rel_path = os.path.relpath(file_path, path)
            comps = rel_path.split(os.sep)

            method = filename.split("_")[1].split(".")[0]

            if not method in ret:
                ret[method] = {}

            if not comps[0] in ret[method]:
                ret[method][comps[0]] = {}

            if not comps[1] in ret[method][comps[0]]:
                ret[method][comps[0]][comps[1]] = {}

            result = read_result(file_path)
            if result is not None:
                ret[method][comps[0]][comps[1]][comps[2]] = result

    return ret


def scinot(num):
    if num is None:
        return "---"
    magni = math.floor(math.log(num, 10))
    ret = "\\Hsci{"
    ret += "%.0f" % (num / (math.pow(10, magni)))
    ret += "}{"
    ret += str(magni)
    ret += "}"

    return ret

def get(res, path):
  ret = res
  for i in range(0,len(path)):
    if path[i] not in ret:
        return None
    ret = ret[path[i]]
  return ret


def format_int(n):
    if n is None:
        return "---"

    if n < 1000:
        return "%d" % n

    if n < 1000000:
        return "%.1f\\Hk" % (n / 1000)

    if n < 1000000000:
        return "%.1f\\HM" % (n / 1000000)

    return "%.1f\\HB" % (n / 1000000000)


def format_float(n):
    if n is None:
        return "---"

    if n < 100:
        return "%.1f" % n

    if n < 1000000:
        return "%.1f\\Hk" % (n / 1000)

    if n < 1000000000:
        return "%.1f\\HM" % (n / 1000000)

    return "%.1f\\HB" % (n / 1000000000)


def format_secs(s):
    return format_msecs(s * 1000)


def format_msecs(ms):
    if ms is None:
        return "---"

    if ms < 0.1:
        return "$<1$\\Hms"

    if ms < 1:
        return "%.1f\\Hms" % ms

    if ms < 100:
        return "%.0f\\Hms" % ms

    if ms < 1000 * 60:
        return "%.1f\\Hs" % (ms / 1000.0)

    if ms < 1000 * 60 * 60:
        return "%.0f\\Hm" % (ms / (60 * 1000.0))

    return "%.0f\\Hh" % (ms / (60 * 60 * 1000.0))


def format_approxerr(perfect, approx):
    if perfect is None or approx is None:
        return "---"

    return "%.1f" % ((approx - perfect) / perfect)


def tbl_overview(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "  \\caption[]{Line graphs used in our experimental evaluation. Under $|{\\cal S}|$ we give the number of station nodes in the graph. Under  $|V|$ we give the numer of nodes (including station nodes). Under $|E|$ we give the number of edges. Under $|{\\cal L}|$ we give the number of lines. $M$ is the maximum number of lines per edge. $D$ is the maximum node degree. $|\\Omega|$ is the line-ordering search space size on the original line graph. \\label{TBL:loom:dataset-overview}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{3pt}\n"
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} l r r r r r r r r r r r}\n"
    ret += "     &&&&\\multicolumn{2}{c}{\\footnotesize grid graph}&& \\multicolumn{2}{c}{\\footnotesize raw} & & \\multicolumn{2}{c}{\\footnotesize deg-2 heur}\\\\\n\\cline{5-6}\\cline{8-9} \\cline{11-12}\\\\[-2ex] \\toprule\n"
    ret += "       & $\\bar d$ & A & $\\deg_{\\text{max}}$ & $|\\Psi|$ & $|\\Omega|$ && $|V|$ & $|E|$ &&  $|V|$ & $|E|$\\\\\\midrule\n"

    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))

    for dataset_id in sort:
        r = results[dataset_id]
        ret += "    %s & %s & %s & %d & %s & %s && %d & %d && %d & %d \\\\\n" % (DATASET_LABELS[dataset_id] + " (" + DATASET_LABELS_SHORT[dataset_id] + ")",
                                                                    format_float(results[dataset_id]["heur"]["octilinear"]["100"]["deg2"]["input-graph-avg-node-dist"]),
                                                                    format_float(results[dataset_id]["heur"]["octilinear"]["100"]["deg2"]["area"] / (1000.0 * 1000.0)),
                                                                    results[dataset_id]["heur"]["octilinear"]["100"]["deg2"]["input-graph-size"]["max-deg"],
                                                                    format_int(results[dataset_id]["heur"]["octilinear"]["100"]["deg2"]["gridgraph-size"]["nodes"]),
                                                                    format_int(results[dataset_id]["heur"]["octilinear"]["100"]["deg2"]["gridgraph-size"]["edges"]),
                                                                    results[dataset_id]["heur"]["octilinear"]["100"]["deg2"]["input-graph-size"]["nodes"],
                                                                    results[dataset_id]["heur"]["octilinear"]["100"]["deg2"]["input-graph-size"]["edges"],
                                                                    results[dataset_id]["heur"]["octilinear"]["100"]["deg2"]["combgraph-size"]["nodes"],
                                                                    results[dataset_id]["heur"]["octilinear"]["100"]["deg2"]["combgraph-size"]["edges"])

    ret += "\\bottomrule"
    ret += "\\end{tabular*}}\n"
    ret += "\\end{table}\n"

    return ret

def tbl_ilp_solve_raw(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "    \\caption[]{Dimensions, final objective value $\\Theta$ and solution times $t$ of our ILP \\emph{without} the degree-2 heuristic (LP) for grid cell sizes $D=0.75 \\cdot \\bar d, D=1 \\cdot \\bar d$ and $D=1.25 \\cdot \\bar d$. Scores of --- mean no initial feasible solution could be found in under 12 hours. If no optimal ILP solution was found in under 12 hours, we give the best bound.  \\label{TBL:eval_ilp_raw}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{3pt}\n"
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r r r}\n"
    ret += "     & \\multicolumn{3}{c}{$D=0.75 \\cdot \\bar d$} & & \\multicolumn{3}{c}{$D=1.0 \\cdot \\bar d$} & & \\multicolumn{3}{c}{$D=1.25 \\cdot \\bar d$} \\\\\n"
    ret += "      \\cline{2-4} \\cline{6-8} \\cline{10-12}  \\\\[-2ex] \\toprule\n"
    ret += "               & rows$\\times$cols & $t$ & $\\Theta$ & & rows$\\times$cols & $t$ & $\\Theta$  & & rows$\\times$cols & $t$ & $\\Theta$ \\\\\\midrule\n"

    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))

    for dataset_id in sort:
        r = results[dataset_id]
        ret += "   %s  & %s$\\times$%s  & %s  & %s && %s$\\times$%s & %s  & %s && %s$\\times$ %s & %s  & %s  \\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "75", "base", "ilp", "size", "rows"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "75", "base", "ilp", "size", "cols"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "75", "base", "scores", "ilp", "solve-time"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "75", "base", "scores", "total-score"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "100", "base", "ilp", "size", "rows"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "100", "base", "ilp", "size", "cols"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "100", "base", "scores", "ilp", "solve-time"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "100", "base", "scores", "total-score"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "125", "base", "ilp", "size", "rows"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "125", "base", "ilp", "size", "cols"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "125", "base", "scores", "ilp", "solve-time"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "125", "base", "scores", "total-score"]))
                                                                   )

    ret += "\\bottomrule"
    ret += "\\end{tabular*}}\n"
    ret += "\\end{table}\n"

    return ret

def tbl_ilp_solve_deg2(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "    \\caption[]{Dimensions, final objective value $\\Theta$ and solution times $t$ of our ILP \\emph{with} the degree-2 heuristic (LP) for grid cell sizes $D=0.75 \\cdot \\bar d, D=1 \\cdot \\bar d$ and $D=1.25 \\cdot \\bar d$. Scores of --- mean no initial feasible solution could be found in under 12 hours. If no optimal ILP solution was found in under 12 hours, we give the best bound.  \\label{TBL:eval_ilp_deg2}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{3pt}\n"
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r r r}\n"
    ret += "     & \\multicolumn{3}{c}{$D=0.75 \\cdot \\bar d$} & & \\multicolumn{3}{c}{$D=1.0 \\cdot \\bar d$} & & \\multicolumn{3}{c}{$D=1.25 \\cdot \\bar d$} \\\\\n"
    ret += "      \\cline{2-4} \\cline{6-8} \\cline{10-12}  \\\\[-2ex] \\toprule\n"
    ret += "               & rows$\\times$cols & $t$ & $\\Theta$ & & rows$\\times$cols & $t$ & $\\Theta$  & & rows$\\times$cols & $t$ & $\\Theta$ \\\\\\midrule\n"

    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))

    for dataset_id in sort:
        r = results[dataset_id]
        ret += "   %s  & %s$\\times$%s  & %s  & %s && %s$\\times$%s & %s  & %s && %s$\\times$ %s & %s  & %s  \\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "75", "deg2", "ilp", "size", "rows"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "75", "deg2", "ilp", "size", "cols"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "75", "deg2", "scores", "ilp", "solve-time"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "75", "deg2", "scores", "total-score"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "100", "deg2", "ilp", "size", "rows"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "100", "deg2", "ilp", "size", "cols"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "100", "deg2", "scores", "ilp", "solve-time"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "100", "deg2", "scores", "total-score"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "125", "deg2", "ilp", "size", "rows"])),
                                                                    format_int(get(results[dataset_id], ["ilp", "octilinear", "125", "deg2", "ilp", "size", "cols"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "125", "deg2", "scores", "ilp", "solve-time"])),
                                                                    format_float(get(results[dataset_id], ["ilp", "octilinear", "125", "deg2", "scores", "total-score"]))
                                                                   )

    ret += "\\bottomrule"
    ret += "\\end{tabular*}}\n"
    ret += "\\end{table}\n"

    return ret


def bold(s):
    return "\\textbf{" + s + "}"


def bold_if(s, t):
    if not t:
        return s
    return "\\textbf{" + s + "}"


def main():
    if len(sys.argv) < 3:
        print("Generates .tex files for result tables\n")
        print("  Usage: " + sys.argv[0] + " <table> <dataset results paths>")
        print(
            "\n  where <table> is one of {overview}")
        sys.exit(1)

    results = {}

    for d in sys.argv[2:]:
        results[os.path.basename(os.path.normpath(d))] = read_results(d)

    if sys.argv[1] == "overview":
        print(tbl_overview(results))

    if sys.argv[1] == "ilp-solve-raw":
        print(tbl_ilp_solve_raw(results))

if __name__ == "__main__":
    main()
