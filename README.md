# Recipes for State-Space Models in R

> OBSOLETE - Materials moved to the StateSpaceRecipes repository

State-space models are useful for modeling time series data,
and R contains several excellent packages for creating the models.
Unfortunately, using these packages involves many little details,
and I can never remember them.
So I put together some recipes to let me quickly build state-space models.

I describe the recipes on my website.

> http://www.quantdevel.com/public/StateSpaceModels/

This repository contains R code for the recipes.
These are the main recipes, most likely to be useful for day-to-day work:

* localLevel.R - Local level model
* localLinearTrend.R - Local linear trend model
* regressionFixedCoeffs.R - Regression model with fixed coefficients
* regressionVaryingCoeffs.R - Regression model with time-varying coefficients

These recipes may come in handy in special circumstances:

* randomWalk.R - Random walk model, StructTS implementation
* randomWalk-dlm.R - Random walk model, dlm implemenation
* localLevel-dlm.R - Local level model, dlm implemenatation
* localLinearTrend-dlm.R - Local linear trend model, dlm implementation
