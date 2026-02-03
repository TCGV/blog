---
layout: post
title: "Revisiting ChatGPT’s financial advice, 15 months later"
date: 2026-02-03 10:00:00 -0300
tags: ai finance
---

In Oct/2024 I asked ChatGPT for a portfolio to endure a messy world (original post [here](https://thomasvilhena.com/2024/10/financial-advice-from-chatgpt)). At that time I expected the Israel–Palestine conflict (on top of Russia–Ukraine) to be the main driver of financial uncertainty in the coming months.

Fifteen months later, the conflicts are still there, but the volatility came from a different menu: U.S. surprises, Trump’s tariff war, a U.S. strike on an Iranian nuclear facility, and most recently Maduro’s capture.

This post is my promised check-in: what would have happened if I'd followed ChatGPT's financial advice? I re-ran the original constraints using a 2024 model snapshot, translated the output into a real ETF portfolio, and measured the results.

The portfolio setup
======

The original post suggested a broad allocation. To make it testable, I re-ran a prompt in the old GPT-4o model (via OpenAI's API, specifically `gpt-4o-2024-08-06` to avoid lookahead bias) to generate a concrete, investable portfolio, using the exact constraints from that post.

<div class="chat-message" markdown="1"><span class="badge">prompt</span>

Construct a portfolio of stock indices, US bonds, corporate bond indices, and commodities, adhering to the following percentages:

50% Equities: Diversify across geographies and sectors (some growth-oriented, some defensive).

30% Bonds: Split between safe-haven government bonds and investment-grade corporate bonds.

20% Commodities & Alternative Investments: This portion can include gold, oil, and possibly some real estate or infrastructure investments that are less correlated with traditional assets.

Suggest only assets accessible to an individual investor via a US investment account.

</div>

Here's the generated response:

<div class="chat-message" markdown="1"><span class="badge">response</span>

Creating a diversified portfolio as per your specifications involves selecting specific ETFs and index funds that are accessible to retail investors. Here's a suggested portfolio:

### 50% Equities

**US Equities (25%)**
- **SPDR S&P 500 ETF Trust (SPY)**: Covers large-cap U.S. equities.

**International Equities (15%)**
- **iShares MSCI ACWI ex U.S. ETF (ACWX)**: Provides exposure to large and mid-cap stocks outside the U.S.

**Emerging Markets (10%)**
- **Vanguard FTSE Emerging Markets ETF (VWO)**: Targets growth-potential markets.

### 30% Bonds

**US Government Bonds (15%)**
- **iShares 7-10 Year Treasury Bond ETF (IEF)**: Focuses on U.S. Treasury bonds, providing a safe-haven investment.

**Corporate Bonds (15%)**
- **iShares iBoxx $ Investment Grade Corporate Bond ETF (LQD)**: Offers exposure to investment-grade U.S. corporate bonds.

### 20% Commodities & Alternative Investments

**Gold (10%)**
- **SPDR Gold Trust (GLD)**: Direct exposure to gold prices.

**Oil (5%)**
- **United States Oil Fund (USO)**: Tracks the daily price movements of West Texas Intermediate (WTI) light, sweet crude oil.

**Real Estate & Infrastructure (5%)**
- **Vanguard Real Estate ETF (VNQ)**: Provides exposure to U.S. real estate investment trusts (REITs).

### Considerations

- **Diversification**: The selection covers multiple geographies, sectors, and asset classes, reducing risk through diversification.
- **Accessibility**: All assets are available through major U.S. brokerages.
- **Liquidity**: ETFs and index funds offer liquidity, making it easier to enter and exit positions.
- **Risk Tolerance**: Adjust weights as needed based on individual risk tolerance and investment horizon.

Before investing, consider consulting with a financial advisor to tailor the portfolio to your personal financial situation and goals.

</div>

This gave me a realistic, investable snapshot of "what ChatGPT would have done" at the time.

The results (Oct 4, 2024 → Jan 27, 2026)
======

A couple of days ago I pulled the adjusted prices (dividends, splits, capital gains) from Yahoo Finance (e.g., [GLD history](https://finance.yahoo.com/quote/GLD/history/?period1=1728000000&period2=1728086400)) and calculated the ROI for each sleeve.

{:.basic-table}
| Asset | Weight | 2024-10-04 | 2026-01-27 | ROI |
| --- | --- | --- | --- | --- |
| SPDR S&P 500 ETF Trust (SPY) | 25% | 564.43 | 695.49 | 23.22% |
| iShares MSCI ACWI ex U.S. ETF (ACWX) | 15% | 54.59 | 71.97 | 31.84% |
| Vanguard FTSE Emerging Markets ETF (VWO) | 10% | 46.56 | 57.64 | 23.80% |
| iShares 7-10 Year Treasury Bond ETF (IEF) | 15% | 92.01 | 95.98 | 4.31% |
| iShares iBoxx $ Investment Grade Corporate Bond ETF (LQD) | 15% | 105.48 | 110.81 | 5.05% |
| SPDR Gold Trust (GLD) | 10% | 245.00 | 476.10 | 94.33% |
| United States Oil Fund (USO) | 5% | 76.35 | 75.66 | -0.90% |
| Vanguard Real Estate ETF (VNQ) | 5% | 90.63 | 90.39 | -0.26% |

**Portfolio result:** +23.74% over 14 months. Not bad.

Closing thoughts
======

Net result: the portfolio held up. Most of it came from a surprisingly good gold run, with stocks doing their job and everything else mostly hovering. That's encouraging, since diversification did its job, and also a warning, because one lucky ingredient can dominate the outcome.

So: would you trust an AI to build your portfolio, or are you already using it (even if just as a second opinion)?