---
aliases:
- /conda/jupyter/2021/09/28/Fix-pythoncom37.dll-Jupyter-Notebook
categories:
- jupyter
- conda
date: '2021-09-28'
description: the procedure entry point ... could not be located in the dynamic library
  <my_env>/pythoncom37.dll
image: https://jupyter.readthedocs.io/en/latest/_static/jupyter.svg
layout: post
title: Fix pythoncom37.dll popup when launching Jupyter Notebook
toc: true

---

when having this popup

![https://i.stack.imgur.com/2tQoH.png](https://i.stack.imgur.com/2tQoH.png)



in my case it refers to `stablebaselines3` conda environment.



I just rename `pythoncom37.dll`to `pythoncom37.dll.old` in <home_user>\AppData\Local\Continuum\anaconda3\envs\stablebaselines3\Library\bin

