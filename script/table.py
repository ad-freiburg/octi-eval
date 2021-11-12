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

    return "%.1f\\makebox[1.6mm][l]{\\hspace{0.2mm}\\%%}" % (n * 100)


def format_float(n, raw=False, nd=1):
    if n is None:
        return "---"

    if raw or n < 100:
        return ("%." + str(nd) + "f") % n

    if n < 1000000:
        return ("%." + str(nd) + "f\\Hk") % (n / 1000)

    if n < 1000000000:
        return ("%." + str(nd) + "f\\HM") % (n / 1000000)

    return ("%.1" + str(nd) + "\\HB") % (n / 1000000000)


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
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r r r r r r r r}\n"
    ret += "    & \\multicolumn{1}{c}{Full} && \\multicolumn{2}{c}{Convex Hull} & & \\multicolumn{2}{c}{Quadtree}  & & \\multicolumn{2}{c}{OHG-1}   & & \\multicolumn{2}{c}{OHG-2} \\\\\n"
    ret += " \\cline{2-2} \\cline{4-5} \\cline{7-8} \\cline{10-11}  \\cline{13-14} \\\\[-2ex] \\toprule\n"
    ret += "& $|\\gE'|$ && $|\\gE'|$ & red. && $|\\gE'|$ & red. && $|\\gE'|$ & red.  && $|\\gE'|$ & red.  \\\\\\midrule\n"


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

        ret += "   %s &  %s &&  %s  & %s && %s  & %s  &&  %s  & %s &&  %s  & %s \\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
                format_int(edges_full),
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

    ret += " avg &  &&& %s &&  & %s  &&  & %s &&  & %s \\\\\n" %(format_perc(avg_chull / len(sort)), format_perc(avg_quad / len(sort)), format_perc(avg_hanan / len(sort)), format_perc(avg_hanan2 / len(sort)))

    ret += "\\bottomrule"
    ret += "\\end{tabular*}}\n"
    ret += "\\end{table}\n"

    return ret


def tbl_sparse_ilp_comp(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "    \\caption[]{Effects of various methods of base grid simplification on ILP sizes, solution times and optimality. ILPs were optimized using gurobi. \\label{TBL:eval_sparse_ilp}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{3pt}\n"
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r r r r r r r r r}\n"
    ret += "    & \\multicolumn{1}{c}{Full} && \\multicolumn{3}{c}{Convex Hull} & & \\multicolumn{3}{c}{Quadtree} & & \\multicolumn{3}{c}{OHG-1}  & & \\multicolumn{3}{c}{OHG-2}  \\\\\n"
    ret += "  \\cline{2-2} \\cline{4-6} \\cline{8-10} \\cline{12-14}  \\cline{16-18} \\\\[-2ex] \\toprule\n"
    ret += "& $\\Theta$ && $\\Theta$ & $\\delta$ & $t$ && $\\Theta$ & $\\delta$ & $t$  && $\\Theta$ & $\\delta$ & $t$ && $\\Theta$ & $\\delta$ & $t$ \\\\\\midrule\n"

    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))

    avg_chull = 0
    avg_quad = 0
    avg_hanan = 0
    avg_hanan2 = 0

    avg_t_chull = 0
    avg_t_quad = 0
    avg_t_hanan = 0
    avg_t_hanan2 = 0

    chull_c = 0
    quad_c = 0
    hanan_c = 0
    hanan2_c = 0

    for dataset_id in sort:
        r = results[dataset_id]

        score_full = get(results[dataset_id],["ilp", "octilinear", "100", "deg2", "scores", "total-score"])

        time_full = get(results[dataset_id], ["ilp", "octilinear", "100", "deg2", "ilp", "solve-time"])

        chull_impr = None
        quad_impr = None
        hanan_impr = None
        hanan2_impr = None

        if score_full is not None:
            if get(results[dataset_id],["ilp", "chulloctilinear", "100", "deg2", "scores", "total-score"]) is not None:
                avg_t_chull += (time_full - get(results[dataset_id],["ilp", "chulloctilinear", "100", "deg2", "ilp", "solve-time"])) / time_full
                chull_impr = (get(results[dataset_id],["ilp", "chulloctilinear", "100", "deg2", "scores", "total-score"]) - score_full) / score_full
                avg_chull +=  chull_impr
                chull_c += 1

            if get(results[dataset_id],["ilp", "quadtree", "100", "deg2", "scores", "total-score"]) is not None:
                avg_t_quad += (time_full - get(results[dataset_id],["ilp", "quadtree", "100", "deg2", "ilp", "solve-time"])) / time_full
                quad_impr = (get(results[dataset_id],["ilp", "quadtree", "100", "deg2", "scores", "total-score"]) - score_full) / score_full
                avg_quad +=  quad_impr
                quad_c += 1

            if get(results[dataset_id],["ilp", "octihanan", "100", "deg2", "scores", "total-score"]) is not None:
                avg_t_hanan += (time_full - get(results[dataset_id],["ilp", "octihanan", "100", "deg2", "ilp", "solve-time"])) / time_full
                hanan_impr = (get(results[dataset_id],["ilp", "octihanan", "100", "deg2", "scores", "total-score"]) - score_full) / score_full
                avg_hanan +=  hanan_impr
                hanan_c += 1

            if get(results[dataset_id],["ilp", "octihanan2", "100", "deg2", "scores", "total-score"]) is not None:
                avg_t_hanan2 += (time_full - get(results[dataset_id],["ilp", "octihanan2", "100", "deg2", "ilp", "solve-time"])) / time_full
                hanan2_impr = (get(results[dataset_id],["ilp", "octihanan2", "100", "deg2", "scores", "total-score"]) - score_full) / score_full
                avg_hanan2 += hanan2_impr
                hanan2_c += 1

        ret += "   %s  & %s && %s  & %s  & %s && %s & %s  & %s && %s & %s  & %s  && %s & %s  & %s \\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
                    format_float(get(results[dataset_id], ["ilp", "octilinear", "100", "deg2", "scores", "total-score"])),
                    format_float(get(results[dataset_id], ["ilp", "chulloctilinear", "100", "deg2", "scores", "total-score"])),
                    format_float(chull_impr, True, 2),
                    format_msecs(get(results[dataset_id], ["ilp", "chulloctilinear", "100", "deg2", "ilp", "solve-time"])),
                    format_float(get(results[dataset_id], ["ilp", "quadtree", "100", "deg2", "scores", "total-score"])),
                    format_float(quad_impr, True, 2),
                    format_msecs(get(results[dataset_id], ["ilp", "quadtree", "100", "deg2", "ilp", "solve-time"])),
                    format_float(get(results[dataset_id], ["ilp", "octihanan", "100", "deg2", "scores", "total-score"])),
                    format_float(hanan_impr, True, 2),
                    format_msecs(get(results[dataset_id], ["ilp", "octihanan", "100", "deg2", "ilp", "solve-time"])),
                    format_float(get(results[dataset_id], ["ilp", "octihanan2", "100", "deg2", "scores", "total-score"])),
                    format_float(hanan2_impr, True, 2),
                    format_msecs(get(results[dataset_id], ["ilp", "octihanan2", "100", "deg2", "ilp", "solve-time"]))
                )

    ret += "\\midrule"

    ret += "   avg  & && & %s  & %s&& & %s  &%s && & %s  & %s && & %s  &%s \\\\\n" % (format_float(avg_chull / chull_c) if chull_c != 0 else "---", format_perc(-avg_t_chull / chull_c) if chull_c != 0 else "---", format_float(avg_quad / quad_c) if quad_c != 0 else "---",  format_perc(-avg_t_quad / quad_c) if quad_c != 0 else "---", format_float(avg_hanan / hanan_c) if hanan_c != 0 else "---", format_perc(-avg_t_hanan / hanan_c) if hanan_c != 0 else "---", format_float(avg_hanan2 / hanan2_c) if hanan2_c != 0 else "---", format_perc(-avg_t_hanan2 / hanan2_c) if hanan2_c != 0 else "---")

    ret += "\\bottomrule"
    ret += "\\end{tabular*}}\n"
    ret += "\\end{table}\n"

    return ret


def tbl_sparse_heur_comp(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "    \\caption[]{Effects of various methods of base grid simplification on solution times and optimality of our approximate approach. \\label{TBL:eval_sparse_heur}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{0pt}\n"
    ret += "  \\footnotesize\\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r r r r r r r r r r}\n"
    ret += "    & \\multicolumn{1}{c}{Full} && \\multicolumn{3}{c}{Convex Hull} & & \\multicolumn{3}{c}{Quadtree} & & \\multicolumn{3}{c}{OHG-1}  & & \\multicolumn{4}{c}{OHG-2}  \\\\\n"
    ret += "  \\cline{2-2} \\cline{4-6} \\cline{8-10} \\cline{12-14}  \\cline{16-19} \\\\[-2ex] \\toprule\n"
    ret += "& $\\Theta$ && $\\Theta$ & $\\delta$ & $t$ && $\\Theta$ & $\\delta$ & $t$  && $\\Theta$ & $\\delta$ & $t$ && $\\Theta$ & $\\delta$ & $t$ &\\\\\\midrule\n"

    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))

    avg_chull = 0
    avg_quad = 0
    avg_hanan = 0
    avg_hanan2 = 0

    avg_t_chull = 0
    avg_t_quad = 0
    avg_t_hanan = 0
    avg_t_hanan2 = 0

    chull_c = 0
    quad_c = 0
    hanan_c = 0
    hanan2_c = 0

    for dataset_id in sort:
        r = results[dataset_id]

        score_full = get(results[dataset_id],["heur", "octilinear", "100", "deg2", "scores", "total-score"])

        time_full = get(results[dataset_id], ["heur", "octilinear", "100", "deg2", "time-ms"])

        topo_vios = get(results[dataset_id], ["heur", "octilinear", "100","deg2", "scores", "topo-violations"])

        topo_vios_chull = get(results[dataset_id], ["heur", "chulloctilinear", "100","deg2", "scores", "topo-violations"])
        topo_vios_quad = get(results[dataset_id], ["heur", "quadtree", "100","deg2", "scores", "topo-violations"])
        topo_vios_hanan = get(results[dataset_id], ["heur", "octihanan", "100","deg2", "scores", "topo-violations"])
        topo_vios_hanan2 = get(results[dataset_id], ["heur", "octihanan2", "100","deg2", "scores", "topo-violations"])

        avg_chull += 0 if topo_vios_chull != 0 else (get(results[dataset_id],["heur", "chulloctilinear", "100", "deg2", "scores", "total-score"]) - score_full) / score_full
        avg_quad += 0 if topo_vios_quad != 0 else (get(results[dataset_id],["heur", "quadtree", "100", "deg2", "scores", "total-score"]) - score_full) / score_full
        avg_hanan += 0 if topo_vios_hanan != 0 else (get(results[dataset_id],["heur", "octihanan", "100", "deg2", "scores", "total-score"]) - score_full) / score_full
        avg_hanan2 += 0 if topo_vios_hanan2 != 0 else (get(results[dataset_id],["heur", "octihanan2", "100", "deg2", "scores", "total-score"]) - score_full) / score_full

        chull_c += 0 if topo_vios_chull != 0 else 1
        quad_c += 0 if topo_vios_quad != 0 else 1
        hanan_c += 0 if topo_vios_hanan != 0 else 1
        hanan2_c += 0 if topo_vios_hanan2 != 0 else 1

        avg_t_chull += (time_full - get(results[dataset_id],["heur", "chulloctilinear", "100", "deg2", "time-ms"])) / time_full
        avg_t_quad += (time_full - get(results[dataset_id],["heur", "quadtree", "100", "deg2", "time-ms"])) / time_full
        avg_t_hanan += (time_full - get(results[dataset_id],["heur", "octihanan", "100", "deg2", "time-ms"])) / time_full
        avg_t_hanan2 += (time_full - get(results[dataset_id],["heur", "octihanan2", "100", "deg2", "time-ms"])) / time_full

        ret += "   %s  & %s && %s  & %s  & %s && %s & %s  & %s && %s & %s  & %s  && %s & %s  & %s \\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
            format_float(get(results[dataset_id], ["heur", "octilinear", "100", "deg2", "scores", "total-score"]), True) if topo_vios == 0 else "%d$w_\\infty$" % topo_vios,
            format_float(get(results[dataset_id], ["heur", "chulloctilinear", "100", "deg2", "scores", "total-score"]), True) if topo_vios_chull == 0 else "%d$w_\\infty$" % topo_vios_chull,
            format_float((get(results[dataset_id],["heur", "chulloctilinear", "100", "deg2", "scores", "total-score"]) - score_full ) / score_full, True, 2) if topo_vios_chull == 0 else "---",
            format_msecs(get(results[dataset_id], ["heur", "chulloctilinear", "100", "deg2", "time-ms"])),
            format_float(get(results[dataset_id], ["heur", "quadtree", "100", "deg2", "scores", "total-score"]), True) if topo_vios_quad == 0 else "%d$w_\\infty$" % topo_vios_quad,
            format_float((get(results[dataset_id],["heur", "quadtree", "100", "deg2", "scores", "total-score"]) - score_full) / score_full, True, 2) if topo_vios_quad == 0 else "---",
            format_msecs(get(results[dataset_id], ["heur", "quadtree", "100", "deg2", "time-ms"])),
            format_float(get(results[dataset_id], ["heur", "octihanan", "100", "deg2", "scores", "total-score"]), True) if topo_vios_hanan == 0 else "%d$w_\\infty$" % topo_vios_hanan,
            format_float((get(results[dataset_id],["heur", "octihanan", "100", "deg2", "scores", "total-score"]) - score_full) / score_full, True, 2) if topo_vios_hanan == 0 else "---",
            format_msecs(get(results[dataset_id], ["heur", "octihanan", "100", "deg2", "time-ms"])),
            format_float(get(results[dataset_id], ["heur", "octihanan2", "100", "deg2", "scores", "total-score"]), True) if topo_vios_hanan2 == 0 else "%d$w_\\infty$" % topo_vios_hanan2,
            format_float((get(results[dataset_id],["heur", "octihanan2", "100", "deg2", "scores", "total-score"]) - score_full) / score_full, True, 2) if topo_vios_hanan2 == 0 else "---",
            format_msecs(get(results[dataset_id], ["heur", "octihanan2", "100", "deg2", "time-ms"]))
        )

    ret += "\\midrule"

    ret += "   avg  & && & %s  & %s&& & %s  &%s && & %s  & %s && & %s  &%s \\\\\n" % (format_float(avg_chull / chull_c, True, 2), format_perc(-avg_t_chull / len(sort)), format_float(avg_quad / quad_c, True, 2), format_perc(-avg_t_quad / len(sort)), format_float(avg_hanan / hanan_c, True, 2), format_perc(-avg_t_hanan / len(sort)), format_float(avg_hanan2 / hanan2_c, True, 2), format_perc(-avg_t_hanan2 / len(sort)))

    ret += "\\bottomrule"
    ret += "\\end{tabular*}}\n"
    ret += "\\end{table}\n"

    return ret


def tbl_time_comp_other_layouts(results):
    ret = "\\begin{table}\n"
    ret += "  \\centering\n"
    ret += "    \\caption[]{TODO \\label{TBL:solvetimes}}\n"
    ret += "    {\\renewcommand{\\baselinestretch}{1.13}\\normalsize\\setlength\\tabcolsep{3pt}\n"
    ret += "  \\begin{tabular*}{\\textwidth}{@{\\extracolsep{\\fill}} c r r r r r r r r r}\n"
    ret += "    \\toprule  & LP & A & $\\delta$ & A+D && LP & A & $\\delta$ & A+D \\\\\\midrule\n"

    sort = []
    for dataset_id in results:
        sort.append(dataset_id)

    sort = sorted(
        sort, key=lambda d: get(results[d],["heur", "octilinear", "100", "deg2", "input-graph-size", "edges"]))


    for dataset_id in sort:
        r = results[dataset_id]

        vio_hex_a = get(results[dataset_id], ["ilp", "hexalinear", "100", "deg2", "scores", "topo-violations"])
        vio_hex_ad = get(results[dataset_id], ["ilp", "hexalinear", "100", "deg2-dpen", "scores", "topo-violations"])
        vio_portho_a = get(results[dataset_id], ["ilp", "porthorad", "100", "deg2", "scores", "topo-violations"])
        vio_portho_ad = get(results[dataset_id], ["ilp", "porthorad", "100", "deg2-dpen", "scores", "topo-violations"])


        ret += "   %s  & %s  & %s & %s & %s  && %s & %s & %s & %s \\\\\n" % (DATASET_LABELS_SHORT[dataset_id],
                format_msecs(get(results[dataset_id], ["ilp", "hexalinear", "100", "deg2", "ilp", "solve-time"])),
                format_msecs(get(results[dataset_id], ["heur", "hexalinear", "100", "deg2", "time-ms"])),
                "---",
                format_msecs(get(results[dataset_id], ["heur", "hexalinear", "100", "deg2-dpen", "time-ms"])),
                format_msecs(get(results[dataset_id], ["ilp", "porthorad", "100", "deg2", "ilp", "solve-time"])),
                format_msecs(get(results[dataset_id], ["heur", "porthorad", "100", "deg2", "time-ms"])),
                "---",
                format_msecs(get(results[dataset_id], ["heur", "porthorad", "100", "deg2-dpen", "time-ms"]))
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

    if sys.argv[1] == "sparse-ilp-comp":
        print(tbl_sparse_ilp_comp(results))

    if sys.argv[1] == "sparse-heur-comp":
        print(tbl_sparse_heur_comp(results))

    if sys.argv[1] == "time-comp-other-layouts":
        print(tbl_time_comp_other_layouts(results))

if __name__ == "__main__":
    main()
