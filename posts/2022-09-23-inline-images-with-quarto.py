#!/usr/bin/env python
# coding: utf-8
---
title: "inline images from jupyter with quarto"
description: "why it works with jupyter labs but not completely with jupyter notebook"
date: "9/23/2022"
categories:
  - nbdev
  - quarto
image: images/icons/jupyter.png  
---
# # using jupyter lab

# Here is the 1st image inline
# 
# ![image.png](attachment:71a4fc95-5776-4180-ae3a-b815bbf1b7a0.png)

# this cell code is
# 
# ```markdown
# ![image.png](attachment:71a4fc95-5776-4180-ae3a-b815bbf1b7a0.png)
# ```

# and here the second one
# 
# ![image.png](attachment:74e0d8d8-ad0f-4eca-b52b-167ac518d0e9.png)

# this cell code is
# 
# ```markdown
# ![image.png](attachment:74e0d8d8-ad0f-4eca-b52b-167ac518d0e9.png)
# ```

# if we see a 2 on the first image, we have a problem

# # using jupyter notebook 

# 1st image
# 
# ![image.png](attachment:image.png)

# 2nd image
# 
# ![image.png](attachment:image.png)

# if we see a 2 on the first image, we have a problem

# # analysis

# when using jupyter lab, cell code for images are like that
# 
# 
# ```markdown
# ![image.png](attachment:71a4fc95-5776-4180-ae3a-b815bbf1b7a0.png)
# ```
# 
# and with jupyter notebook or vscode, it is like that
# 
# ```markdown
# ![image.png](attachment:image.png)
# ```

# There is an enhancement request at vscode to support it
# 
# https://github.com/microsoft/vscode/issues/151408

# # workaround
# 
# use jupyter lab to blog

# In[ ]:




