---
layout: post
title: "Building a decentralized options exchange on ethereum"
date: 2021-02-18 01:10:00 -0300
tags: finance system-design
---

Decentralized finance (a.k.a. DeFi) is a relatively recent and fast growing field in the crypto space that is providing innovative implementations for financial instruments that rely on "smart contracts" (actual code files) instead of being subject to control by central financial intermediaries such as brokerages, exchanges, or banks.

I first came across DeFi about six months ago while browsing a hacker news thread on the subject, and became especially interested on the topic. Not much later major financial news portals reported that DeFi had already grown tenfold during the course of 2020, surpassing US$ 11 billion in deposited value with still a few months left to year end<sup>1,2</sup>, nothing less than staggering.

This context motivated me to invest my free time for studying this field more deeply, and since I learn better when I get my hands dirty I ended up developing a personal project of a **decentralized options exchange** on ethereum which I describe briefly in this post. Also, feel free to browse it's source code on GitHub, which includes a short technical documentation: [DeFiOptions](https://github.com/TCGV/DeFiOptions).

I will start with a general overview of the project, and then get into more details on key DeFi concepts. So don't go away yet if you feel overwhelmed. However, if you're not familiar with traditional options and how they are traded in stock exchanges, I suggest you take a look [here](https://en.wikipedia.org/wiki/Option_(finance)) before proceeding.

Overview
============

So my experimental DeFi options exchange was implemented as a collection of smart contracts written in the [solidity](https://en.wikipedia.org/wiki/Solidity) programming language. They enable trading of long and short positions for cash settable call and put european style options. The diagram below gives a glimpse on how traders interact with the exchange, and how components interact with one another.

<p align="center">
  <img style="max-width: 100%; max-height: 360px; margin: 10px 0" src="{{ site.baseurl }}/images/p25/diagram.png" alt="regular-graphs"/>
  <br><label style="font-size: 12px;">Figure 1. Options Exchange Diagram</label>
</p>

The exchange accepts stablecoin deposits as collateral for writing tokenized (ERC20) options, and a dynamic approach was implemented for ensuring collateral, making use of favorable writer's open option positions for decreasing total required balance provided as collateral.

Decentralized price feeds provide the exchange on-chain underlying price and volatility updates, which is crucial for properly calculating options intrinsic values, collateral requirements, and performing settlements.

Upon maturity each option contract is liquidated, cash settled by the credit provider contract and destroyed to prevent anyone from trading an expired asset. In case any option writer happens to be short on funds during settlement the credit provider will register a debt and cover payment obligations, essentially performing a lending operation.

Registered debt will accrue interest until it's repaid by the borrower. Payment occurs either automatically when any of the borrower's open option positions matures and is cash settled (pending debt will be discounted from profits) or manually if the borrower makes a new stablecoin deposit.

Exchange's balances not allocated as collateral can be withdrawn by respective owners in the form of stablecoins. If there aren't enough stablecoins available the solicitant will receive ERC20 credit tokens issued by the credit provider.

Holders of credit tokens can request to withdraw (and burn) their balance for stablecoins as long as there are sufficient funds available in the exchange to process the operation, otherwise the withdraw request will be FIFO-queued while the exchange gathers funds, accruing interest until it's finally processed to compensate for the delay.

Phew, that's it! While implementing the options exchange I came across several challenges, tried different approaches, reverted back and tried again until coming up with this solution. There's still work to be done (see "next steps" section), but I'm confident this foundation is solid enough to support further developments.

DeFi concepts
============

Now, let's look at some key concepts that form the basis of DeFi and play an important role in this project.

<h2>Smart contracts</h2>

If you're new to ethereum development you must know that smart contracts constitute the source code of decentralized applications (dapp). It's solidity (programming language) code, simply put. As I've pointed out above feel free to browse the options exchange smart contracts source code in the [project's GitHub repository](https://github.com/TCGV/DeFiOptions) at any time.

A smart contract defines functions with varying degrees of visibility that perform calculations, modify blockchain state and emit logs. <u>External and public functions are the API of a dapp</u> and can be called by any participant of the ethereum network. Internal and private functions on the other hand can only be called by the smart contract itself or its derivations in the case of the former.

Dapps live in the blockchain, i.e., their source code is stored in its blocks and ran upon demand, somewhat similar to the serverless computing model. Nonetheless the ethereum network guaranties atomicity, meaning that at any given moment only a single function is being executed as if it had the entire blockchain available for itself alone.

When smart contract functions are executed they potentially alter state. If so changes are definitive, persisted into the blockchain and available to be audited by any node in the network. Without getting into too much detail this model of execution is what gives ethereum its decentralized quality, anyone can execute code and anyone can audit executed code.

<h2>Tokenization</h2>

Tokenization is the process of converting physical and non-physical assets into digital tokens on the blockchain. Typically it's done by implementing the [ERC20 interface](https://eips.ethereum.org/EIPS/eip-20) which is nothing more than a definition of functions and events that once implemented allow any network participant to interact with such token for querying total token supply, querying an account's token balance, transfering tokens between accounts, and so forth:

```sol
interface ERC20 {

	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint256 _value
	);

	function totalSupply()
		public
		view
		returns (uint256);

	function balanceOf(
		address _owner
	)
		public
		view
		returns (uint256 balance);

	function transfer(
		address _to,
		uint256 _value
	)
		public
		returns (bool success);

	function transferFrom(
		address _from,
		address _to,
		uint256 _value
	)
		public
		returns (bool success);

	function approve(
		address _spender,
		uint256 _value
	)
		public
		returns (bool success);

	function allowance(
		address _owner,
		address _spender
	)
		public
		view
		returns (uint256 remaining);
}
```

By following the ERC20 standard newly created tokens can take advantage of numerous DeFi primitives already available in the blockchain. With that in mind I've implemented the options exchange adopting tokenized options, allowing option writers to easily manage them, for instance to transfer them to a third-party willing to purchase them.

<h2>Stablecoins</h2>

Stablecoins are cryptocurrencies designed to minimize the volatility of the price of the stablecoin, relative to some "stable" asset or basket of assets. A stablecoin can be pegged to a cryptocurrency, fiat money, or to exchange-traded commodities.

This project adopts stablecoins pegged to the US dollar. Traders can deposit any of the accepted stablecoins as balance for writing options. It's worth noting that these stablecoins are also ERC20 compliant, as to reinforce the importance of this standard. For reference, the table below depicts the market cap for the five biggest stablecoins at this time:

{:.centered .basic-table}
| Name                     | Code    | Market Cap |
| ------------------------ | ------- | -----------|
| **Theter**               | USDT    | $ 30.76B   |
| **USD Coin**             | USDC    | $ 7.28B	  |
| **Multi-Collateral Dai** | DAI     | $ 2.07B	  |
| **Binance USD**          | BUSD    | $ 1.83B	  |
| **Paxos Standard**       | PAX     | $ 681.87M  |

I've decided to adopt stablecoins instead of other cryptocurrencies (such as ether itself) in the hopes of making the options exchange more palpable and appealing to traders that may not be insterested in being exposed to non stable cryptocurrencies while trading options.

<h2>Collateralization</h2>

Collateralization is the use of a valuable asset to secure a liability. It is a heavily adopted concept in the DeFi space.

In this project every option is backed by a stablecoin deposit provided as collateral, and if an option writer defaults on his liability, the option holder may seize the asset to offset the loss. Collateralization of assets gives holders a sufficient level of reassurance against default risk.

You can get more details on the exchange's collateralization requirements in the [collateral allocation section](https://github.com/TCGV/DeFiOptions#collateral-allocation) of the repository documentation. An ad-hoc formula is being used to achieve improved capital efficiency.

<h2>Decentralized price feeds</h2>

One of the drawbacks of dapps is that they are isolated from the real-world and are only able to read data that is already persisted in the blockchain. Relying on off-chain data would break the chain of trust, since it would be impossible for other network participants to audit such data to make sure it wasn't forged.

Fortunately there are decentralized price feeds available on ethereum that employ on-chain consensus protocols for providing trustworthy price readings.

<p align="center">
  <img style="max-width: 100%; max-height: 360px; margin: 10px 0" src="{{ site.baseurl }}/images/p25/consensus.PNG" alt="regular-graphs"/>
  <br><label style="font-size: 12px;">Figure 2. Example: Chainlink ETH / USD aggregation</label>
</p>

The options exchange takes advantage of these decentralized price feeds for fetching underlying prices updates for calculating options intrinsic values and collateral requirements.

<h2>Liquidity pools</h2>

A liquidity pool is a collection of funds locked in a smart contract that is used to facilitate decentralized trading.

The options exchange itself is meaningless unless there's enough liquidity to make options trading feasible. For instance, why would a trader write options if there's no one to buy them? and why would another trader buy options if his/hers strategy is dependant on selling these options on a short notice but there's a chance of not finding someone to sell them to? That's why in the absence of organic liquidity there's a need to deploy a liquidity pool.

A liquidity pool should be designed to slightly favor its providers, as to incentivize traders to allocate capital into the pool for increasing the supply and circulation of options in the market.

Particularly in the case of options trading the liquidity pool smart contract is required to implement a robust option pricing model in order to perform successfully and generate profits for its providers.

As of the time of this writing a linear model liquidity pool is being implemented for the options exchange.

<h2>Governance</h2>

 Last but not least, governance defines a framework of on-chain rules and procedures that regulates the operation and evolution of a DeFi application. It's through the governance framework that decisions such as modifying protocol parameters (ex: fees, interest rates, etc), issuing tokens, distributing profits and modifying protocol behaviors/functionality gets made.
 
 Governance functionality is also defined in smart contracts, as every other aspect of dapps, and there are at least three levels of control according to who holds power to make decisions and take action:

 * Dictatorship
 * Council
 * Democracy

 Usually a new protocol starts as a dictatorship of its main developer(s), then shifts to a council of early adopters and eventually reaches a democracy of anyone interested in participating and willing to invest in the protocol.

The options exchange project's governance functionality is still incipient. Upon deployment it will be a dictatorship with a plan to distribute governance tokens to early adopters to shift towards a council as quickly as possible.

Next steps
============

This project is available on kovan testnet for evaluation (browse the [documentation](https://github.com/TCGV/DeFiOptions) for more info on how to interact with it), but there are a few major technical challenges that still need to get dealt with for this project to be ready for deployment to mainnet:

* Development of a dapp front-end application to make the exchange accessible to non-developers (collaborator commited)
* Design and implementation of a liquidity pool, which will involve knowledge in finance and option pricing models (in progress)
* Allow deposit/withdraw of underlying assets (ex: ETH, BTC) so they can be provided as collateral for writing options against them
* Improvement of the incipient governance functionality

Closing thoughts
============

DeFi is a very innovative field. What I find most appealing is that some popular derivative protocols are yet inefficient in some ways, which means there is a lot of room for new solutions to come along.

I believe the advent of stablecoins and ingenious DeFi protocols are laying the foundations upon which more accessible and efficient solutions will be built, and its amazing that anyone with a software development and financial background can take part in this transformation.

My options exchange hobby project has been an edifying adventure, helping me get familiar with the solidity programming model and the overall DeFi ecosystem. There's still a lot to learn, and I believe the best way will continue to be getting my hands dirty and keep improving this project, stay tuned.

---

<b>Sources</b>

[1] ["Why 'DeFi' Utopia Would Be Finance Without Financiers: QuickTake"](https://www.bloomberg.com/news/articles/2020-08-26/why-defi-utopia-would-be-finance-without-financiers-quicktake). Bloomberg. 2020-08-26. Retrieved 2020-10-06.

[2] Ehrlich, Steven. ["Leading 'Privacy Coin' Zcash Poised For Growth Following Placement On Ethereum"](https://www.forbes.com/sites/stevenehrlich/2020/10/29/leading-privacy-coin-zcash-poised-for-growth-following-placement-on-ethereum). Forbes.

