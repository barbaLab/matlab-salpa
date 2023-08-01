import importlib
python_salpa = importlib.import_module('.', 'python-salpa')
import numpy as np

data = np.array(data)
tau = int(tau)

kwargs = {}

rail1 = np.array(rail1)
rail2 = np.array(rail2)
thresh = np.array(thresh)
t_blankdepeg = np.array(t_blankdepeg)
t_ahead = np.array(t_ahead)
t_chi2 = np.array(t_chi2)
t_forcepeg = np.array(t_forcepeg)

if np.any(rail1):
    kwargs['rail1'] = rail1

if np.any(rail2):
    kwargs['rail2'] = rail2

if np.any(thresh):
    kwargs['thresh'] = thresh

if np.any(t_blankdepeg):
    kwargs['t_blankdepeg'] = int(t_blankdepeg)

if np.any(t_ahead):
    kwargs['t_ahead'] = int(t_ahead)

if np.any(t_chi2):
    kwargs['t_chi2'] = int(t_chi2)

if np.any(t_forcepeg):
    kwargs['t_forcepeg'] = int(t_forcepeg)

data = python_salpa.salpa(data, tau, **kwargs)