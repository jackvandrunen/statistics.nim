import ../distributions
import ../roots
import math

type
  TBinomial* = object
    n*: int
    p*: float
    q: float

proc Binomial*(n: int, p: float): TBinomial =
  TBinomial(n: n, p: p, q: 1.0 - p)

proc pmf*(d: TBinomial, x: int): float =
  if x >= 0:
    result = float(binom(d.n, x)) * pow(d.p, float(x)) * pow(d.q, float(d.n - x))

proc cdf*(d: TBinomial, x: int): float =
  for i in 0..x:
    result += float(binom(d.n, i)) * pow(d.p, float(i)) * pow(d.q, float(d.n - i))

proc quantile*(d: TBinomial, q: float): int =
  checkNormal(q)
  discreteInf(proc(x: int): float = d.cdf(x), q, 0)

converter toDistribution*(d: TBinomial): IDistribution[int] =
  (
    pdf: proc(x: int): float = pmf(d, x),
    cdf: proc(x: int): float = cdf(d, x),
    quantile: proc(q: float): int = quantile(d, q)
  )