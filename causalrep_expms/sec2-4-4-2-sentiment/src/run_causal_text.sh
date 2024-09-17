#!/bin/bash
#

TIMESTAMP=$(date +%Y%m%d%H%M%S%N)

PYCODE_SWEEP="causaltext"
#DATASET_SWEEP="kindle imdb imdb_sents"
#DATASET_SWEEP="imdb imdb_sents"
DATASET_SWEEP="toxic_comments"
HDIM_SWEEP="1024"
LR_SWEEP="1e-2 1e-1"
#LR_SWEEP="1e-2"
L2REG_SWEEP="1e-1 1e-2 1e0"
#L2REG_SWEEP="1e-2"
MODE_SWEEP="linear"
ZDIM_SWEEP="5 10 100 500 1000"
NUMFEA_SWEEP="20 50 100 500"

#ZDIM_SWEEP="5"
#NUMFEA_SWEEP="20"

CODE_SUFFIX=".py"
OUT_SUFFIX=".out"
PRT_SUFFIX=".txt"

RUN_SCRIPT="run_causal_text_base.sh"

for i in {1..3}; do
    for ZDIMi in ${ZDIM_SWEEP}; do
        export ZDIM=${ZDIMi}
        for L2REGi in ${L2REG_SWEEP}; do
            export L2REG=${L2REGi}
            for LRi in ${LR_SWEEP}; do
                export LR=${LRi}
                for MODEi in ${MODE_SWEEP}; do
                    export MODE=${MODEi}
                    for NUMFEAi in ${NUMFEA_SWEEP}; do
                        export NUMFEA=${NUMFEAi}
                        for PYCODE_SWEEPi in ${PYCODE_SWEEP}; do
                            NAME=bash_${PYCODE_SWEEPi}
                            for DATASETi in ${DATASET_SWEEP}; do
                                export DATASET=${DATASETi}
                                for HDIMi in ${HDIM_SWEEP}; do
                                    export HDIM=${HDIMi}
                                    export FILENAME=${PYCODE_SWEEPi}${CODE_SUFFIX}
                                    export OUTNAME=${PYCODE_SWEEPi}_data${DATASETi}_HDIM${HDIMi}_MODE${MODEi}_lr${LRi}_L2REG${L2REGi}_ZDIM${ZDIMi}_NUMFEA${NUMFEAi}_${TIMESTAMP}${OUT_SUFFIX}
                                    export PRTOUT=${PYCODE_SWEEPi}_data${DATASETi}_HDIM${HDIMi}_MODE${MODEi}_lr${LRi}_L2REG${L2REGi}_ZDIM${ZDIMi}_NUMFEA${NUMFEAi}_${TIMESTAMP}${PRT_SUFFIX}

                                    # Check if the output file already exists
                                    EXISTING_FILE=${PYCODE_SWEEPi}_data${DATASETi}_HDIM${HDIMi}_MODE${MODEi}_lr${LRi}_L2REG${L2REGi}_ZDIM${ZDIMi}_NUMFEA${NUMFEAi}_*.out
                                    if ls ${EXISTING_FILE} 1> /dev/null 2>&1; then
                                        echo "Skipping ${OUTNAME} as it already exists."
                                    else
                                        echo ${NAME}
                                        bash ${RUN_SCRIPT} > ${OUTNAME} 2>&1
                                    fi
                                done
                            done
                        done
                    done
                done
            done
        done
    done
done
