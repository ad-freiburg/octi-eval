FROM ubuntu:20.04
ARG GRB_VERSION=9.1.2
ARG GRB_SHORT_VERSION=9.1

WORKDIR /opt

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --no-install-recommends -y\
       ca-certificates  \
	   libglpk-dev \
	   glpk-utils \
	   coinor-libcbc-dev \
	   coinor-cbc \
       wget \
       make \
       cmake \
	   texlive-base \
	   texlive-science \
	   texlive-latex-extra \
	   texlive-latex-base \
       libboost-all-dev \
	   g++ \
       git \
    && update-ca-certificates \
    && wget -q https://packages.gurobi.com/${GRB_SHORT_VERSION}/gurobi${GRB_VERSION}_linux64.tar.gz \
    && tar -xf gurobi${GRB_VERSION}_linux64.tar.gz  \
    && rm -f gurobi${GRB_VERSION}_linux64.tar.gz \
    && mv -f gurobi* gurobi \
    && rm -rf gurobi/linux64/docs

ENV GUROBI_HOME /opt/gurobi/linux64
ENV PATH $PATH:$GUROBI_HOME/bin:/loom/build
ENV LD_LIBRARY_PATH $GUROBI_HOME/lib

ADD loom /loom

ENV GRB_LICENSE_FILE /output/gurobi.lic

RUN cd /loom && rm -rf build && mkdir build && cd build && cmake .. && make -j20 octi

RUN mkdir -p /output

COPY Makefile /
COPY Makefile-aux /
COPY README.md /
ADD script /script
ADD datasets /datasets

WORKDIR /

ENTRYPOINT ["make", "RESULTS_DIR=/output/results", "TABLES_DIR=/output/tables", "ILP_CACHE_DIR=/tmp"]
