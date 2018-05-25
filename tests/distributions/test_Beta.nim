import ../../statistics/distributions
import ../../statistics/distributions/Beta
import ../ut_utils
import unittest

suite "statistics-Beta":
  let d = Beta(1.0, 2.0)
  let d2: IDistribution[float] = d

  test "pdf":
    check(approx(d.pdf(-1.0), 0.0))
    check(approx(d.pdf(0.0), 0.0))
    check(approx(d.pdf(0.1), 1.8))
    check(approx(d.pdf(0.5), 1.0))
    check(approx(d.pdf(0.9), 0.2))
  
  test "cdf":
    check(approx(d.cdf(-1.0), 0.0))
    check(approx(d.cdf(0.0), 0.0))
    check(approx(d.cdf(0.1), 0.19))
    check(approx(d.cdf(0.5), 0.75))
    check(approx(d.cdf(0.9), 0.99))

  test "quantile":
    expect(ValueError):
      discard d.quantile(-0.1)
    expect(ValueError):
      discard d.quantile(1.1)
    check(approx(d.quantile(0.19), 0.1))
    check(approx(d.quantile(0.75), 0.5))
    check(approx(d.quantile(0.99), 0.9))

  test "pdf-i":
    check(approx(d2.pdf(-1.0), 0.0))
    check(approx(d2.pdf(0.0), 0.0))
    check(approx(d2.pdf(0.1), 1.8))
    check(approx(d2.pdf(0.5), 1.0))
    check(approx(d2.pdf(0.9), 0.2))
  
  test "cdf-i":
    check(approx(d2.cdf(-1.0), 0.0))
    check(approx(d2.cdf(0.0), 0.0))
    check(approx(d2.cdf(0.1), 0.19))
    check(approx(d2.cdf(0.5), 0.75))
    check(approx(d2.cdf(0.9), 0.99))

  test "quantile-i":
    expect(ValueError):
      discard d2.quantile(-0.1)
    expect(ValueError):
      discard d2.quantile(1.1)
    check(approx(d2.quantile(0.19), 0.1))
    check(approx(d2.quantile(0.75), 0.5))
    check(approx(d2.quantile(0.99), 0.9))