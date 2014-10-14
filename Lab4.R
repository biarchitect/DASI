load(url("http://bit.ly/dasi_nc"))
source("http://bit.ly/dasi_inference")
load(url("http://bit.ly/dasi_gss_ws_cl"))

#Lab5
#
load(url("http://www.openintro.org/stat/data/atheism.RData"))
us12 = subset(atheism, atheism$nationality == "United States" & atheism$year == "2012"
inference(us12$response, est = "proportion", type = "ci", method = "theoretical", success = "atheist")
n <- 1000;p <- seq(0, 1, 0.01);me <- 2 * sqrt(p * (1 - p)/n);plot(me ~ p)
