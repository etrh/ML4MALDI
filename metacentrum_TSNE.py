#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import r2_score,mean_squared_error
from sklearn import metrics
from sklearn import preprocessing
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import StandardScaler
import seaborn as sns
import matplotlib.pyplot as plt
import dill

dill.load_session("tsne.db")


# In[ ]:


from sklearn.manifold import TSNE
import seaborn as sns

def run_tsne(X, y, Perplexity, Iterations, noprogresstolerance):
    tsneModel = TSNE(perplexity=Perplexity, n_iter=Iterations, n_iter_without_progress=noprogresstolerance, n_jobs=100)
    X_embedded = tsneModel.fit_transform(X)
    return sns.scatterplot(X_embedded[:,0], X_embedded[:,1], hue=y.ravel(), legend='full');


# In[ ]:


TSNEres = run_tsne(X=X, y=ywardD2, Perplexity=100, Iterations=6500, noprogresstolerance=2500)


# In[ ]:


dill.dump_session("tsne_done.env")

