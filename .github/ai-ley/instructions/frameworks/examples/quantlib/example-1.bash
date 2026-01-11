# Python bindings installation
pip install QuantLib

# Alternative conda installation
conda install -c conda-forge quantlib

# Development dependencies
pip install numpy pandas matplotlib jupyter

# Verify installation
python -c "import QuantLib as ql; print(ql.__version__)"