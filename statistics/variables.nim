import ./distributions
import sequtils

proc random*[T](d: Distribution[T], oracle: proc(): float): T =
  d.quantile(oracle())

iterator draw*[T](d: Distribution[T], n: int, oracle: proc(): float): T =
  for i in 1..n:
    yield d.random(oracle)

proc sample*[T](d: Distribution[T], n: int, oracle: proc(): float): seq[T] =
  toSeq(d.draw(n, oracle))

when not defined(nimscript):
  import ./oracle

  proc random*[T](d: Distribution[T]): T =
    d.random(rand)

  iterator draw*[T](d: Distribution[T], n: int): T =
    for i in 1..n:
      yield d.random()

  proc sample*[T](d: Distribution[T], n: int): seq[T] =
    toSeq(d.draw(n))
