import importlib
python_salpa = importlib.import_module('.', 'python-salpa')
import numpy as np

data = np.array(data)
tau = int(tau)
data = python_salpa.salpa(data, tau, thresh=thresh)