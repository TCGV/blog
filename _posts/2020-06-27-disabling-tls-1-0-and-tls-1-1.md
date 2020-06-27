---
layout: post
title: "Disabling TLS 1.0 and TLS 1.1"
date: 2020-06-27 17:40:00 -0300
tags: security system-administration
---

Following recommendations from [RFC-7525](https://tools.ietf.org/html/rfc7525) this year all major browsers are disabling TLS versions 1.0 and 1.1. The table below presents approximate deadline for that to happen<sup>1,2,3,4</sup>:

{:.centered .basic-table}
| Browser Name     | Date                       |
|------------------|----------------------------|
| Google Chrome    | July 2020                  |
| Microsoft Edge   | July 2020<sup>†</sup>      |
| Microsoft IE11   | September 2020<sup>†</sup> |
| Mozilla Firefox  | March 2020<sup>‡</sup>     |
| Safari/Webkit    | March 2020<sup>§</sup>     |

<b>†</b> <i>In light of current global circumstances, this planned change has been postponed — originally scheduled for the first half of 2020.</i>

<b>‡</b> <i>Due to the pandemic, Mozilla reverted the disable of TLS 1.0 and TLS 1.1 for an undetermined amount of time to better enable access to critical government sites sharing Covid-19 information.<i>

<b>§</b> <i>Release date for Safari Technology Preview.</i>

So why is this happening? Well, these protocol versions were designed around two decades ago and they don't support a lot of the recent developments in cryptography. Below is a copy of the rationale included in RFC-7525:

* TLS 1.0 (published in 1999) does not support many modern, strong cipher suites.  In addition, TLS 1.0 lacks a per-record Initialization Vector (IV) for CBC-based cipher suites and does not warn against common padding errors.

* TLS 1.1 (published in 2006) is a security improvement over TLS 1.0 but still does not support certain stronger cipher suites.

In the next sections I provide more information on how this may affect your web applications, and how to handle this transition, based on my recent experience.

Security Scan
============

To be honest I only found out about browsers dropping support to TLS 1.0 and TLS 1.1 after running a [SSL Server Test](https://www.ssllabs.com/ssltest) against one of the web applications I manage and seeing a drop in its overall rating:

<p align="center">
  <img style="max-width: 100%; max-height: 250px; margin: 10px 0" src="{{ site.baseurl }}/images/p20/ssl_scan_B.PNG" alt="SSL Scan grade B"/>
</p>

Since this application is required by contract to achieve grade "A" in this particular test I started digging on this subject to understand the difficulty involved in complying with this requirement. Fortunately in my case it was a no brainer, as you'll see.

Evaluating Impact
============

My first action was to evaluate how many of my web application users would be impacted by this change. Given my application supported TLS 1.2, and fewer than 0.5% of users were making connections using older TLS versions, the impact was evaluated as minimum.

Overall, the following table shows for each browser the percentage of connections made to SSL/TLS servers in the world wide web using protocol TLS 1.0 and TLS 1.1 from an analysis conducted in late 2018 <sup>5</sup>:

{:.centered .basic-table}
| Browser/Client Name   | Percentage (%) – Both TLS 1.0 and 1.1 |
|-----------------------|---------------------------------------|
| Google Chrome         | 0.5%                                  |
| Microsoft IE and Edge | 0.72%                                 |
| Mozilla Firefox       | 1.2%                                  |
| Safari/Webkit         | 0.36%                                 |
| SSL Pulse Nov. 2018<sup>6</sup> | 5.84%                       |

These figures are from two years ago and by now we can expect them to be even lower, meaning it should be quite painless for web applications to make the transition.

Remote Connection
============

If you're solely using [SSH](https://en.wikipedia.org/wiki/Secure_Shell) to connect to remote Virtual Machines (VMs) you can skip this section. However, if like me you also manage some Windows Server VMs connecting to them using the [RDP protocol](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol), before disabling TLS 1.0 and 1.1 in these machines <u>make sure RDP is running on TLS 1.2 or above, otherwise you will lock yourself out of the VM</u>!

To be on the safe side besides confirming that the RDP Host in the server was configured to accept TLS 1.2 connections I also disabled older TLS versions in my notebook, connected to the remote machine and sniffed packets using [Wireshark](https://www.wireshark.org/):

<p align="center">
  <img style="max-width: 100%; max-height: 250px; margin: 10px 0" src="{{ site.baseurl }}/images/p20/wireshark_packets.png" alt="Wireshark sniffing"/>
</p>

This result gave me enough confidence to proceed, knowing that I was indeed connecting using TLS 1.2 and I'd not lose access to the remote server.

Disabling the Protocol
============

The exact steps you'll have to follow for disabling TLS 1.0 and TLS 1.1 in your web application will obviously depend on your technology stack. Below I provide references for the three most used web servers (Apache, IIS and Nginx):

* [How can I disable TLS 1.0 and 1.1 in apache?](https://serverfault.com/questions/848177/how-can-i-disable-tls-1-0-and-1-1-in-apache)
* [How to disable TLS 1.0 in Internet Information Services](https://support.microsoft.com/en-us/help/187498/how-to-disable-pct-1-0-ssl-2-0-ssl-3-0-or-tls-1-0-in-internet-informat)
* [Disable TLS 1.0 in NGINX](https://serverfault.com/questions/704376/disable-tls-1-0-in-nginx)

If you've followed the link with instructions for disabling the protocol in IIS you may have notice it's the least straightforward of them all! It requires a system wide configuration by modifying a few Registry Keys.

Since I had not one but multiple Windows Server instances to configure I decided to make my life easier and write a simple console app for querying the Windows Registry and making required changes. I made this tool available on GitHub in case you're interested: [TLSConfig](https://github.com/TCGV/TLSConfig).

<p align="center">
  <img style="max-width: 100%; max-height: 250px; margin: 10px 0" src="{{ site.baseurl }}/images/p20/tlsconfig.png" alt="TLSConfig"/>
</p>

As with all Windows Registry changes you will have to restart your VM for them to take effect 😒

<b>Important</b>: In case you follow the steps for disabling the protocol only to realise nothing happened, it could be that your application in sitting behind a load balancer or a proxy server which you will have to configure as well.

Results
============

After using the TLSConfig tool to disable TLS versions 1.0 and 1.1 in all of my application servers I ran the security scan again and... success!

<p align="center">
  <img style="max-width: 100%; max-height: 250px; margin: 10px 0" src="{{ site.baseurl }}/images/p20/ssl_scan_A.PNG" alt="SSL Scan grade A"/>
</p>

<i>DISCLAIMER: This blog post is intended to provide information and resources on this subject only. Most of the recommendations and suggestions here are based on my own experience and research. Follow them at your own will and responsibility, evaluate impact at all times before proceeding, test changes in a separate environment before applying them to production, schedule maintenance to low usage hours and be prepared for things to go wrong.</i>

---

<b>Sources</b>

[1] Google Developers. [Deprecations and removals in Chrome 84](https://developers.google.com/web/updates/2020/05/chrome-84-deps-rems#remove_tls_10_and_tls_11). Retrieved 2020-06-27.

[2] Windows Blogs. [Plan for change: TLS 1.0 and TLS 1.1 soon to be disabled by default](https://blogs.windows.com/msedgedev/2020/03/31/tls-1-0-tls-1-1-schedule-update-edge-ie11/). Retrieved 2020-06-27.

[3] Mozilla. [Firefox 74.0 Release Notes](https://www.mozilla.org/en-US/firefox/74.0/releasenotes/). Retrieved 2020-06-27.

[4] WebKit Blog. [Release Notes for Safari Technology Preview 98](https://webkit.org/blog/9689/release-notes-for-safari-technology-preview-98/). Retrieved 2020-06-27.

[5] Qualys Blog. [SSL Labs Grade Change for TLS 1.0 and TLS 1.1 Protocols](https://blog.qualys.com/ssllabs/2018/11/19/grade-change-for-tls-1-0-and-tls-1-1-protocols). Retrieved 2020-06-27.

[6] Qualys. [SSL Pulse](https://www.ssllabs.com/ssl-pulse/) is a continuous and global dashboard for monitoring the quality of SSL / TLS support over time across 150,000 SSL- and TLS-enabled websites, based on Alexa’s list of the most popular sites in the world.