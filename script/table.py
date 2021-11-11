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

def format_perc(n):
    if n is None:
        return "---"

    return "%.1f\\%%" % (n * 100)


def format_float(n, raw=False):
    if n is None:
        return "---"

    if raw or n < 100:
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

def tbl_approx_solve_deg2(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "    \\caption[]{Final objective values of our ILP (LP-2) and our approx. approach (A-2), both with deg-2 heuristic for grid cell sizes $D=0.75 \\cdot \\bar d, D=1 \\cdot \\bar d$ and $D=1.25 \\cdot \\bar d$. The approximation error is given as $\\delta$. Scores of --- mean no solution could be found. If no optimal LP solution was found in under 12 hours, we give the best bound. \\label{TBL:eval_approx_deg2}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{3pt}\n"
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r r r r r r r}\n"
    ret += "     & \\multicolumn{3}{c}{\\footnotesize $D=0.75 \\cdot \\bar d$} & & \\multicolumn{3}{c}{\\footnotesize $D=1.0 \\cdot \\bar d$} & & \\multicolumn{3}{c}{\\footnotesize $D=1.25 \\cdot \\bar d$} \\\\\n"
    ret += "      \\cline{2-4} \\cline{6-8} \\cline{10-12}  \\\\[-2ex] \\toprule\n"
    ret += "        & LP-2 & A-2 & $\\delta$ & & LP-2 & A-2 & $\\delta$ & & LP-2 & A-2 & $\\delta$  \\\\\\midrule\n"

    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))


    for dataset_id in sort:
        r = results[dataset_id]

        ilp_score_75 = get(results[dataset_id], ["ilp", "octilinear", "75", "deg2", "scores", "total-score"])
        heur_score_75 = get(results[dataset_id], ["heur", "octilinear", "75", "deg2", "scores", "total-score"])
        err_75 = None
        if ilp_score_75 is not None and heur_score_75 is not None:
            err_75 = (heur_score_75  - ilp_score_75) / ilp_score_75

        ilp_score_100 = get(results[dataset_id], ["ilp", "octilinear", "100", "deg2", "scores", "total-score"])
        heur_score_100 = get(results[dataset_id], ["heur", "octilinear", "100", "deg2", "scores", "total-score"])
        err_100 = None
        if ilp_score_100 is not None and heur_score_100 is not None:
            err_100 = (heur_score_100  - ilp_score_100) / ilp_score_100

        ilp_score_125 = get(results[dataset_id], ["ilp", "octilinear", "125", "deg2", "scores", "total-score"])
        heur_score_125 = get(results[dataset_id], ["heur", "octilinear", "125", "deg2", "scores", "total-score"])
        err_125 = None
        if ilp_score_125 is not None and heur_score_125 is not None:
            err_125 = (heur_score_125  - ilp_score_125) / ilp_score_125


        ret += "   %s  & %s  & %s  & %s\\%% && %s & %s  & %s\\%% && %s  & %s & %s\\%%   \\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
                format_float(ilp_score_75, True),
                format_float(heur_score_75, True),
                format_float(err_75),
                format_float(ilp_score_100, True),
                format_float(heur_score_100, True),
                format_float(err_100),
                format_float(ilp_score_125, True),
                format_float(heur_score_125, True),
                format_float(err_125))

    ret += "\\bottomrule"
    ret += "\\end{tabular*}}\n"
    ret += "\\end{table}\n"

    return ret

def tbl_time_comp(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "    \\caption[]{TODO \\label{TBL:solvetimes}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{3pt}\n"
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r r r r r r r r}\n"
    ret += "    \\toprule  & LP & A & its. & LP-2 & A-2 & its. & \\textbf{A-2+D} & its. \\\\\\midrule\n"

    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))


    for dataset_id in sort:
        r = results[dataset_id]

        ret += "   %s  & %s  & %s & %s & %s  & %s & %s & \\textbf{%s} & %s \\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
                format_msecs(get(results[dataset_id], ["ilp", "octilinear", "100", "base", "ilp", "solve-time"])),
                format_msecs(get(results[dataset_id], ["heur", "octilinear", "100", "base", "time-ms"])),
                format_int(get(results[dataset_id], ["heur", "octilinear", "100", "base", "iterations"])),
                format_msecs(get(results[dataset_id], ["ilp", "octilinear", "100", "deg2", "ilp", "solve-time"])),
                format_msecs(get(results[dataset_id], ["heur", "octilinear", "100", "deg2", "time-ms"])),
                format_int(get(results[dataset_id], ["heur", "octilinear", "100", "deg2", "iterations"])),
                format_msecs(get(results[dataset_id], ["heur", "octilinear", "100", "deg2-dpen", "time-ms"])),
                format_int(get(results[dataset_id], ["heur", "octilinear", "100", "deg2-dpen", "iterations"]))
                )

    ret += "\\bottomrule"
    ret += "\\end{tabular*}}\n"
    ret += "\\end{table}\n"

    return ret

def get_ordering_res(a, meth):
    res = get(a, ["heur", "octilinear", "100", meth, "scores", "total-score"])
    topo_vios =  get(a, ["heur", "octilinear", "100",meth, "scores", "topo-violations"])

    if res == None:
        return "---"

    if topo_vios is not None and topo_vios > 0:
        return "%d$w_\\infty$" % topo_vios

    return format_float(res, True)


def tbl_ordering_comp(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "    \\caption[]{Initial results of our heuristic approach \\emph{without} the local search phase using 6 different methods of ordering the input edges for rendering: by number of lines on the edge (num lines), by the length of the edge in the input graph, shortest first (length), by adjacent node degree (deg), by adjacent node line degree (ldeg), and growth-based approaches based on the node degree (gr-deg) and the line node degree (gr-ldeg). There is no clear winner.\\label{TBL:orderingcomp}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{3pt}\n"
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r r r r r r }\n"
    ret += "    \\toprule  & num lines & length &  $\\deg$ & ldeg & gr-$\\deg$ & gr-ldeg \\\\\\midrule\n"

    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))


    for dataset_id in sort:
        r = results[dataset_id]

        methods = ["deg2-init-num-lines", "deg2-init-length", "deg2-init-adj-nd-deg", "deg2-init-adj-nd-ldeg", "deg2-init-growth-deg", "deg2-init-growth-ldeg"]

        raw_scores = [get(results[dataset_id], ["heur", "octilinear", "100", meth, "scores", "total-score"]) for meth in methods]

        best = sorted(range(len(raw_scores)), key=raw_scores.__getitem__)[0]

        ret += "   %s  & %s  & %s & %s & %s  & %s & %s\\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
                bold_if(get_ordering_res(results[dataset_id], methods[0]), best == 0),
                bold_if(get_ordering_res(results[dataset_id], methods[1]), best == 1),
                bold_if(get_ordering_res(results[dataset_id], methods[2]), best == 2),
                bold_if(get_ordering_res(results[dataset_id], methods[3]), best == 3),
                bold_if(get_ordering_res(results[dataset_id], methods[4]), best == 4),
                bold_if(get_ordering_res(results[dataset_id], methods[5]), best == 5)
                )

    ret += "\\bottomrule"
    ret += "\\end{tabular*}}\n"
    ret += "\\end{table}\n"

    return ret

def tbl_sparse_size_comp(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "    \\caption[]{Effects of various methods of base grid simplification on base grid graph size, given as number of nodes $|\\gV'|$ and number of edges $|\\gE'|$. Under `red.` we give the reduction of the number of edges when compared to the full extended grid\\label{TBL:gridsize_simple}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{3pt}\n"
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r r r r r r}\n"
    ret += "    & \\multicolumn{2}{c}{Convex Hull} & & \\multicolumn{2}{c}{Quadtree}  & & \\multicolumn{2}{c}{OHG-1}   & & \\multicolumn{2}{c}{OHG-2} \\\\\n"
    ret += " \\cline{2-3} \\cline{5-6} \\cline{8-9}  \\cline{11-12} \\\\[-2ex] \\toprule\n"
    ret += "& $|\\gE'|$ & red. && $|\\gE'|$ & red. && $|\\gE'|$ & red.  && $|\\gE'|$ & red.  \\\\\\midrule\n"


    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))

    avg_chull = 0
    avg_quad = 0
    avg_hanan = 0
    avg_hanan2 = 0

    for dataset_id in sort:
        r = results[dataset_id]

        edges_full = get(results[dataset_id],["heur", "octilinear", "100", "deg2", "gridgraph-size", "edges"])

        avg_chull += (edges_full - get(results[dataset_id],["heur", "chulloctilinear", "100", "deg2", "gridgraph-size", "edges"])) / edges_full
        avg_quad += (edges_full - get(results[dataset_id],["heur", "quadtree", "100", "deg2", "gridgraph-size", "edges"])) / edges_full
        avg_hanan += (edges_full - get(results[dataset_id],["heur", "octihanan", "100", "deg2", "gridgraph-size", "edges"])) / edges_full
        avg_hanan2 += (edges_full - get(results[dataset_id],["heur", "octihanan2", "100", "deg2", "gridgraph-size", "edges"])) / edges_full

        ret += "   %s &  %s  & %s && %s  & %s  &&  %s  & %s &&  %s  & %s \\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
                format_int(get(results[dataset_id],["heur", "chulloctilinear", "100", "deg2", "gridgraph-size", "edges"])),
                format_perc((edges_full - get(results[dataset_id],["heur", "chulloctilinear", "100", "deg2", "gridgraph-size", "edges"])) / edges_full),
                format_int(get(results[dataset_id],["heur", "quadtree", "100", "deg2", "gridgraph-size", "edges"])),
                format_perc((edges_full - get(results[dataset_id],["heur", "quadtree", "100", "deg2", "gridgraph-size", "edges"])) / edges_full),
                format_int(get(results[dataset_id],["heur", "octihanan", "100", "deg2", "gridgraph-size", "edges"])),
                format_perc((edges_full - get(results[dataset_id],["heur", "octihanan", "100", "deg2", "gridgraph-size", "edges"])) / edges_full),
                format_int(get(results[dataset_id],["heur", "octihanan2", "100", "deg2", "gridgraph-size", "edges"])),
                format_perc((edges_full - get(results[dataset_id],["heur", "octihanan2", "100", "deg2", "gridgraph-size", "edges"])) / edges_full)
                )


    ret += "\\midrule"

    ret += " avg &  & %s &&  & %s  &&  & %s &&  & %s \\\\\n" %(format_perc(avg_chull / len(sort)), format_perc(avg_quad / len(sort)), format_perc(avg_hanan / len(sort)), format_perc(avg_hanan2 / len(sort)))

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

    if sys.argv[1] == "ilp-solve-deg2":
        print(tbl_ilp_solve_deg2(results))

    if sys.argv[1] == "approx-solve-deg2":
        print(tbl_approx_solve_deg2(results))

    if sys.argv[1] == "time-comp":
        print(tbl_time_comp(results))

    if sys.argv[1] == "ordering-comp":
        print(tbl_ordering_comp(results))

    if sys.argv[1] == "sparse-size-comp":
        print(tbl_sparse_size_comp(results))

if __name__ == "__main__":
    main()
