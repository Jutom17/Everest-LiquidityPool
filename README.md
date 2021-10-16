# Liquidity Pool & Flash Loan

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)


## How the flash loan fees are distributed to the liquidity providers?

The fee is 0.01%, divided in:
- 80% to liquidity providers.
- 20% to the protocol.

- You get eTokens in exchange for your liquidity. 
- The amount of tokens you get is proportional to the share of your liquidity in 
the pool. 
- Fees are distributed proportionally to the amount of tokens you hold.
- eTokens can be exchanged back for liquidity + accumulated fees.


eTokens don't have supply limit, new tokens are minted when new liquidity is added.
Inflation doens't reduce value of eTokens because they're always backed by some
amount of liquidity that doesn't depend on the number of issued tokens.

