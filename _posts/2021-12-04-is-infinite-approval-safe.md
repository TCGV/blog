---
layout: post
title: "Is infinite token approval safe?"
date: 2021-12-04 09:00:00 -0300
tags: crypto finance security
---

Is has become common  practice for DeFi protocols to use infinite token allowance approval to improve end users experience. From the user's perspective it's indeed very convenient and even appealing, once they grant a dapp (decentralized app) infinite allowance they will be able to interact with such dapp mostly using single transactions instead of having to perform a token spending approval transaction prior to every interaction with the dapp.

A few months ago I questioned a similar approach used by the [DAI stablecoin](https://makerdao.com/en/) while researching the [EIP-2612 proposal](https://eips.ethereum.org/EIPS/eip-2612) which I replicate below:

> <b>Is DAI-style permit safe to use?</b>
>
> Differently from the EIP-2612 which defines a "value" for the allowance DAI's approach appears to approve an unlimited allowance for the spender address.
>
>
> Is it safe to permit a protocol to spend DAI on my behalf?
>
>
> If not, to which use cases is DAI-style permit targeted to?

([link to the full question](https://ethereum.stackexchange.com/questions/99019/is-dai-style-permit-safe-to-use))

Eventhough I didn't get a full answer to my question at the time, one user provided some insights in a comment:

> It depends on the protocol. If the protocol is only a smart contract and you see the source code and trust that the contract is bug-free and will only transfer the token based on defined logic and transparent actions/conditions then no harm in doing it (but you can see there is too many "AND"s). – Majd TL

So I concluded that there are too many "ANDs" for trusting a protocol with unlimited token allowance approval. It's more flexible, sure, but more riskier than using limited approval if any bug is found in the protocol. Nonetheless, nobody seemed to care, most protocols were doing it by default, without notice.

As a skeptical person myself I carried on never granting infinite allowance approval to dapps I use, and adopting a few strategies which I'll comment later on in situations I needed more flexibility.

But then, after a few months, something happened that made me remind of this matter, the Badger DAO Protocol exploit...

US$ 120 million stolen
============

[As reported by rekt](https://rekt.news/badger-rekt/), the Badger DAO Protocol exploit took place past December 2nd and the staggering amount of US$ 120 million were stolen from it.

How did this happen? Different from previous DeFi attacks we've seen in the past that took advantage of smart contract bugs and sophisticated strategies for manipulating protocols internal parameters this one was simple enough that even those unfamiliar with DeFi can follow easily:

> A front-end attack. An unknown party inserted additional approvals to send users' tokens to their own address. Starting from 00:00:23 UTC on 2.12.2021, the attacker used this stolen trust to fill their own wallet.

Simple as that. For several days Badger users were accessing the hacked UI and inadvertently approving mostly unlimited allowance to the attacker's address. The attacker waited for the right time to make his/her move, silently watching hundreds of users approving his/her address. And then, the attacker decided the reward was large enough, made his move and stole 120 million dollars.

Rumours that the project’s Cloudflare account was compromised have been circulating. Still, it a flagrant wake up call, to remind us that even if the protocol smart contracts are audited, battle tested and considered reasonably safe, if you're interacting with that protocol through a dapp you can still fall for a hack if the front-end has been compromised.

Strategies for protecting yourself
============

There are three main strategies to protect your assets in situations like this when interacting with dapps that don't support [EIP-2612](https://eips.ethereum.org/EIPS/eip-2612), which I detail below:

<b>1) Always use limited approval</b>: This is the trivial strategy, never grant unlimited allowance, always use two transactions, the first one for approving the protocol a limited allowance and the second one for interacting with the protocol. Some dapps allow you to disable the default setting of unlimited allowance in their UI. For the ones that don't you can edit the allowance approval value in your wallet (ex: MetaMask) before sending the transaction through.

<b>2) Use a hot wallet</b>: Another common strategy, in case you really need to allow unlimited allowance (for instance to reduce costs with transactions fees) you should use a hot wallet, i.e., a separate address that you will fund on demand. All funds held by this address will be subject to higher risk, but it will contain a smaller portion of your holdings, so it's a limited risk. By the way, avoid using the same hot wallet for multiple dapps, otherwise you'll be increasing your risk profile.

<b>3) Deploy a proxy contract:</b> This is a more sophisticated strategy which requires you to code a smart contract that will interact with a protocol on your behalf, even bypassing the front-end altogether. I've been using this approach to interact with DEXes. I have a non upgradable proxy smart contract in place to which I send transactions for swapping tokens. I grant this proxy unlimited allowance for a hot wallet of mine. When I send a swap transaction to the proxy it will first approve a limited allowance in the destination DEX, then perform the swap transaction, and finally transfer the tokens back to my hot wallet. This way I get the best of both worlds, I'm using single transactions for interacting with dapps, and my hot wallet is shielded from "allowance exploits". But de advised that writing smart contracts is inherently risky, so this strategy doesn't come easy as well.

An idea for improving front-end security
============

Before closing I would like to discuss an idea for improving front-end dapps security. These apps are insecure because, unlike (most) smart contracts and blockchain transactions, hosting is centralized. A few admins have control of the front-end app. If one of the admin accounts is hacked the front-end app could be tempered with without anyone noticing. 

So we need to make sure we are interacting with a untampered front-end in the first place. And the solution to this has been around for a long time: signed apps. If we define a method for bundling front-end apps for having a DAO controlled address to sign this bundle we can greatly reduce the front-end attack surface. All users would then access this fronted app and have their wallets checking the app signature. If the calculated signature for the received front-end bundle doesn't match the DAO's controlled signing address a warning message would be shown and the user would be advised to not interact with the app.

There's one catch though, for this idea to work we would need to manually register/bookmark all DAO's signing addresses that we trust. Let's just hope we don't get it from a hacked front-end then 😅
