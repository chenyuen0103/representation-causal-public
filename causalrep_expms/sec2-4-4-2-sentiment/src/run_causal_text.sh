#!/bin/bash
#

TIMESTAMP=$(date +%Y%m%d%H%M%S%N)

PYCODE_SWEEP="causaltext"
DATASET_SWEEP="toxic_comments"
HDIM_SWEEP="1024"
LR_SWEEP="1e-2 1e-1"
L2REG_SWEEP="1e-1 1e-2 1e0"
MODE_SWEEP="linear"
ZDIM_SWEEP="5 10 100 500 1000"
NUMFEA_SWEEP="20 50 100 500"

CODE_SUFFIX=".py"
OUT_SUFFIX=".out"
PRT_SUFFIX=".txt"

RUN_SCRIPT="run_causal_text_base.sh"

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

                                # Count existing files for this parameter combination
                                PATTERN=${PYCODE_SWEEPi}_data${DATASETi}_HDIM${HDIMi}_MODE${MODEi}_lr${LRi}_L2REG${L2REGi}_ZDIM${ZDIMi}_NUMFEA${NUMFEAi}_*.out
                                COUNT=$(ls ${PATTERN} 2>/dev/null | wc -l)

                                # Run up to 3 trials
                                if [ $COUNT -lt 3 ]; then
                                    for ((trial=$COUNT+1; trial<=3; trial++)); do
                                        export OUTNAME=${PYCODE_SWEEPi}_data${DATASETi}_HDIM${HDIMi}_MODE${MODEi}_lr${LRi}_L2REG${L2REGi}_ZDIM${ZDIMi}_NUMFEA${NUMFEAi}_${TIMESTAMP}_trial${trial}${OUT_SUFFIX}
                                        export PRTOUT=${PYCODE_SWEEPi}_data${DATASETi}_HDIM${HDIMi}_MODE${MODEi}_lr${LRi}_L2REG${L2REGi}_ZDIM${ZDIMi}_NUMFEA${NUMFEAi}_${TIMESTAMP}_trial${trial}${PRT_SUFFIX}

                                        echo "Running trial ${trial} for ${OUTNAME}"
                                        bash ${RUN_SCRIPT} > ${OUTNAME} 2>&1
                                    done
                                else
                                    echo "Skipping ${PYCODE_SWEEPi}_data${DATASETi}_HDIM${HDIMi}_MODE${MODEi}_lr${LRi}_L2REG${L2REGi}_ZDIM${ZDIMi}_NUMFEA${NUMFEAi} as 3 trials already exist."
                                fi
                            done
                        done
                    done
                done
            done
        done
    done
done
