
using DataFrames, GLM, Gadfly

d = readtable("data4a.csv")

d[:yn] = map(x -> d[:y][x] / d[:N][x], 1:nrow(d))

# categorise (convert to PooledDataArray)
#d[:ff] = convert(PooledDataArray, d[:f])
d[:ff] = pool(d[:f])

res = glm(yn~x + ff, d, Binomial())

println(res)

xx = [minimum(d[:x]):0.1:maximum(d[:x])]
ft = PooledDataArray(rep([utf8("T")], length(xx)), copy(d[:ff].pool))
fc = PooledDataArray(rep([utf8("C")], length(xx)), copy(d[:ff].pool))

rt = predict(res, DataFrame(n = rep([1], length(xx)), x = xx, ff = ft.refs - 1))
rc = predict(res, DataFrame(n = rep([1], length(xx)), x = xx, ff = fc.refs - 1))

p = plot(
	layer(d, x = "x", y = "y", color = "f", Geom.point),
	layer(x = xx, y = maximum(d[:N]) * rt, Geom.line, Theme(default_color = color("red"))),
	layer(x = xx, y = maximum(d[:N]) * rc, Geom.line, Theme(default_color = color("green")))
)

draw(PNG("logisticGlm2.png", 500px, 400px), p)
