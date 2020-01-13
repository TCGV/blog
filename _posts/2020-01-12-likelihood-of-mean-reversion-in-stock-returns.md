---
layout: post
title: "Likelihood of mean-reversion in stock returns"
date: 2020-01-12 23:15:00 -0300
tags: statistical-computing finance
---

The standard rule for calculating a stock returns monthly volatility is to multiply the daily volatility by the square root of the number of business days in that month, for instance:

<p align="center">
  <img style="max-height: 40px; max-width: 100%; margin: 10px" src="{{ site.baseurl }}/images/p13/monthly_vol.PNG" alt="Monlthly volatility"/>
  <br>
</p>

This rule is derived from an independent log-normal daily returns model. However, if the stochastic process is considered under the influence of mean reversion then this rule is likely to give us exaggerated volatilities.

Most papers on the subject tend to analyze the effects of mean reversion in larger periods of time (years), but I was curious on whether or not it's also important to take it into account for shorter, intra-month, trading periods.

In this post I evaluate if an autoregressive Gaussian model capable of incorporating a mean reversion effect better describes the behavior of observed stock returns, when compared to a non autogressive control model.

The code I share in this article is written in the R programming language, using the following packages: `plotly`, `ggplot2`, `sfsmisc`.

Data Set
============

Just like int the previous article, I picked five years worth of [PETR4](https://en.wikipedia.org/wiki/Petrobras) historical log returns to work on, which is the most actively traded stock in [B3](https://en.wikipedia.org/wiki/B3_(stock_exchange)), the largest stock exchange in Brazil. You can find the source data in the links below:

* [PETR4 2015 returns]({{ site.baseurl }}/resources/p13/PETR4_2015.txt)
* [PETR4 2016 returns]({{ site.baseurl }}/resources/p13/PETR4_2016.txt)
* [PETR4 2017 returns]({{ site.baseurl }}/resources/p13/PETR4_2017.txt)
* [PETR4 2018 returns]({{ site.baseurl }}/resources/p13/PETR4_2018.txt)
* [PETR4 2019 returns]({{ site.baseurl }}/resources/p13/PETR4_2019.txt)

Mean Reversion Model
============

To take the daily stock returns mean into account I will be using an [autoregressive model](https://en.wikipedia.org/wiki/Autoregressive_model), which specifies that the output variable depends linearly on its own previous values and on a stochastic term:

<p align="center">
  <img style="max-height: 120px; max-width: 100%; margin: 10px" src="{{ site.baseurl }}/images/p13/mean_model.PNG" alt="Mean model"/>
  <br>
</p>

This model has three fitting parameters:
* <b>k</b> → The stock returns moving average (μ<sub>N</sub>) multiplier
* <b>σ</b> → The Gaussian distribution standard deviation
* <b>N</b> → The moving average period, in days

Let's take a moment to analyze it. If <b>k</b> is zero, than it becomes a simple non autoregressive driftless Gaussian model, just like the one I used in [my previous post]({{ site.baseurl }}/2019/12/stock-option-pricing-inference). If <b>k</b> is negative, than it becomes a mean reverting model, since future outcomes will be negatively correlated to past outcomes. Finally, if <b>k</b> is positive then it becomes a trend enforcement process, i.e., boosting any upward or downward trend observed in the process.

Model Fitting
============

Since my last post I have sharpened my R skills a bit 🤓, and learned how to use optimization functions for fitting parameters more efficiently (instead of using a brute-force approach). First let me define the autoregressive model likelihood function that will be minimized:

```r

# calculates likelihood for the autoregressive model
# k: model parameters (length == 2)
# n: moving average period
# x: stock returns samples
likelihood <- function(k, n, x) {
  lke <- 0
  offset <- 21
  for(i in offset:length(x)) {
    m <- if (n == 0) 0 else mean(x[(i - n):(i - 1)])
    p <- dnorm(x[i], sd=k[1], mean=(k[2] * m))
    lke <- lke + log(p)
  }
  return (-lke)
}

```

Now let's read the data set and optimize our model's <b>k</b> and <b>σ</b> parameters for varying <b>N</b> period lengths, starting at zero (non autoregressive control case) up to a twenty days moving average period:

```r

x <- read.table("PETR4_2019.txt")[["V1"]]

max_period <- 20

res <- lapply(0:max_period, function(n) {
  return (optim(c(0.01, 0.00), function(k) likelihood(k, n, x)))
})

```

The resulting `res` list will hold, for each moving average period analyzed, all optimized model parameters and  its corresponding likelihood. Let's check the results, below is the plot for all fitted <b>k</b> parameters:

```r

df_factor <- data.frame(
  x = seq(0, max_period), y = sapply(res, function(e) (e[[1]][2]))
)

p <- ggplot() +
  ggtitle("Mean Multiplier Analysis") +
  xlab("Period length") +
  ylab("Multiplier") + 
  geom_line(data = df_factor, aes(x=x, y=y), color='red')
ggplotly(p)

```

<p align="center">
  <img style="max-height: 400px; max-width: 100%; margin: 10px" src="{{ site.baseurl }}/images/p13/k_analysis.png" alt="k analysis"/>
  <br>
</p>

With the expected exception of the control case (<b>N</b>=0), fitted values for the <b>k</b> model parameter resulted negative for all analyzed periods, possibly indicating the presence of a mean reversion effect. However, before jumping into any conclusion we need to take a look at the log-likelihood ratio between the different periods and the control case.

Below is the code for plotting the likelihood of each analyzed period length, which will help us find the most likely value for the <b>N</b> parameter:

```r

df_lke <- data.frame(
  x = seq(0, max_period), y = sapply(res, function(e) (res[[1]][[2]]-e[[2]]))
)

p <- ggplot() +
  ggtitle("Period Analysis") +
  xlab("Period length") +
  ylab("Log-likelihood ratio") + 
  geom_line(data = df_lke, aes(x=x, y=y), color='red')
ggplotly(p)

```

<p align="center">
  <img style="max-height: 400px; max-width: 100%; margin: 10px" src="{{ site.baseurl }}/images/p13/period_analysis.png" alt="period analysis"/>
  <br>
</p>

So the best performing model was found to have the following set of parameters:
* <b>k</b> → -0.518
* <b>σ</b> → 0.0182
* <b>N</b> → 7 days
* <b>Log-likelihood ratio</b> → 3.051

Which raises the question:

> Is this result statistically significant to confirm the presence of mean reversion in the analyzed data?

Well, we will find that out in the next section.

Probability Value
============

In statistical hypothesis testing, the probability value or [p-value](https://en.wikipedia.org/wiki/P-value) is the probability of obtaining test results at least as extreme as the results actually observed during the test, assuming, in our case, that there is no autoregressive effect in place. If the p-value is low enough, we can determine, with resonable confidence, that the non autoregressive model hypothesis, as it stands, is false.

In order to calculate the p-value initially we need to estimate the observed log-likelihood ratio probability distribution under the hypothesis that our process follows a non autoregressive Gaussian model (control process). So let's replicate the analysis above under this assumption:

```r

iterations <- 1000   # number of analysis per period
max_period <- 20     # same number of periods as before
num_samples <- 247   # replicating observed data length (1 year)
wiener_std <- 0.018  # Control model standard deviation

res <- lapply(1:iterations, function(z) {
  
  # generates independent normally distributed samples
  x <- rnorm(num_samples, 0, wiener_std)
  
  y <- lapply(0:max_period, function(n) {
    return (optim(c(0.01, 0.00), function(k) likelihood(k, n, x)))
  })
  
  return (sapply(y, function(e) (-e[[2]])))
})

```

Beware that this code may take 30 minutes to complete running, or more, dependeding on your notebook configuration. It generates 1000 log-likelihood ratio samples for each period length. The box plot below gives us a qualitative understanding of this output:

```r

df <- lapply(0:max_period, function(k) {
  vec <- t(sapply(1:length(res), function(l){
    return (c(k, res[[l]][k + 1] - res[[l]][1]))
  }))
  return (data.frame(
    period = vec[,1],
    ratio = vec[,2]
  ))
})

df <- do.call(rbind, df)
df$period <- as.factor(df$period)

ggplot(df, aes(x=period, y=ratio)) +
  ggtitle("Control process analysis") +
  xlab("Period length") +
  ylab("Log-likelihood ratio") + 
  geom_boxplot()

```

<p align="center">
  <img style="max-height: 400px; max-width: 100%; margin: 10px" src="{{ site.baseurl }}/images/p13/control_process_likelihood.png" alt="control process likelihood"/>
  <br>
</p>

Interestingly enough, it seems that there isn't much difference in the log-likelihood ratio probability distribution among the various period lengths analyzed. A margin of error of 3% (95% confidence interval) is expected since 1000 samples were used.

Moving forward, I defined a function that calculates the p-value from this resulting `res` list:

```r

# caluates p-value
# res: pre-processed log-likelihood ratios
# n: moving average period
# lke: log-likelihood ratio whose p-value should be obtained

p_value <- function (res, n, lke){
  vec <- sapply(1:length(res), function(l){
       return (res[[l]][n + 1] - res[[l]][1])
  })
  d_lke <- density(vec)
  i <- findInterval(lke, d_lke[["x"]])
  l <- length(d_lke[["x"]])
  return (integrate.xy(d_lke[["x"]][i:l], d_lke[["y"]][i:l]))
}

```

Thus, calling this function like so `p_value(res, 7, 3.051)` yields a p-value of 1.665%. Considering the margin of error the p-value is slightly below a typical 5% threshold, which would allow us to assert, with statistical significance, that the best fitted parameter set rejects the non autoregressive model as it stands.

Nevertheless, the best fitted parameters for all other period lengths fail to pass this significance test when the margin of error is taken into account. This is, at a minimum, intuitively odd, as how can a seven days period pass the significance test and a six (or eight) days period don't, was it a fluke?

To clear this doubt I ran the analysis again for the remaining data sets, unfortunately with weaker results, as none of the moving average periods analyzed passed the significance test, which I discuss in the conclusion below.

Conclusion
============

I ran this analysis for the previous years as well (2015, 2016, 2017 and 2018) and found the outcome to be inconclusive, with even higher p-values. At first the results looked promising, but as I dug deeper they proved weak to support the presence of mean-reversion in intra-month daily log returns for this particular stock, and this particular model.

Since this simple model failed to capture possible effects of mean-reversion the next step that comes to mind is to search and try out different, more elaborate, autoregressive models, instead of ruling mean-reversion out in the first place.

I hope you enjoyed this post. If you have any comment or find any issue with my approach please let me know.