TIMESTAMP=$(date +%Y%m%d%H%M%S%N)

# Set the specific values for each parameter
PYCODE_SWEEP="colored_mnist_supervised_expm"
SPURIOUSCORR=0.9
HDIM=256
LR=1e-1
L2REG=1
MODE="linear"
ZDIM=64
NUMFEA=20

CODE_SUFFIX=".py"
OUT_SUFFIX=".out"
PRT_SUFFIX=".txt"

RUN_SCRIPT="run_colored_mnist_base.sh"

export ZDIM=${ZDIM}
export L2REG=${L2REG}
export LR=${LR}
export MODE=${MODE}
export NUMFEA=${NUMFEA}
export SPURIOUSCORR=${SPURIOUSCORR}
export HDIM=${HDIM}
export FILENAME=${PYCODE_SWEEP}${CODE_SUFFIX}
export OUTNAME=${PYCODE_SWEEP}_corr${SPURIOUSCORR}_HDIM${HDIM}_MODE${MODE}_lr${LR}_L2REG${L2REG}_ZDIM${ZDIM}_NUMFEA${NUMFEA}_${TIMESTAMP}${OUT_SUFFIX}
export PRTOUT=${PYCODE_SWEEP}_corr${SPURIOUSCORR}_HDIM${HDIM}_MODE${MODE}_lr${LR}_L2REG${L2REG}_ZDIM${ZDIM}_NUMFEA${NUMFEA}_${TIMESTAMP}${PRT_SUFFIX}

echo "Running ${PYCODE_SWEEP} with the following parameters:"
echo "SPURIOUSCORR=${SPURIOUSCORR}, HDIM=${HDIM}, LR=${LR}, L2REG=${L2REG}, MODE=${MODE}, ZDIM=${ZDIM}, NUMFEA=${NUMFEA}"
python ${FILENAME} 2>&1 | tee ${OUTNAME}
