### A Pluto.jl notebook ###
# v0.12.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 9d277ee0-1160-11eb-2425-83fa14b294d8
begin
	import Pkg
	using Colors
	Pkg.add("ColorVectorSpace")
	using ColorVectorSpace
	Pkg.add("PlutoUI")
	using PlutoUI
end

# ╔═╡ fb433ce8-1166-11eb-18a5-7b78ba9f3aa4
begin
	Pkg.add(["Images", "ImageIO", "ImageMagick"])
	using Images
end

# ╔═╡ afd0822e-10ae-11eb-02dd-5bd210db8c55
md" # The Julia Programming Language"

# ╔═╡ 16841620-10af-11eb-10f6-17396ac0aa8e
md" ## History?"

# ╔═╡ 2977b552-10af-11eb-2375-9fe1ad294929
md"
* Started: _2008_
* First Release: _2012_ [https://julialang.org/blog/2012/02/why-we-created-julia/](https://julialang.org/blog/2012/02/why-we-created-julia/)
* version 1.0: _2018_ [https://julialang.org/blog/2018/08/one-point-zero/](https://julialang.org/blog/2018/08/one-point-zero/)
"

# ╔═╡ 925536b2-10af-11eb-18d3-25fa2f7b6ee3
md"
## Goals

In the 2012 introduction blog post, they start by mentioning languages:

* Matlab 
* Lisp
* Python
* Ruby 
* Perl 
* Mathematica
* R
* C

> We want a language that's open source, with a liberal license. We want the speed of C with the dynamism of Ruby. We want a language that's homoiconic, with true macros like Lisp, but with obvious, familiar mathematical notation like Matlab. We want something as usable for general programming as Python, as easy for statistics as R, as natural for string processing as Perl, as powerful for linear algebra as Matlab, as good at gluing programs together as the shell. Something that is dirt simple to learn, yet keeps the most serious hackers happy. We want it interactive and we want it compiled.
"

# ╔═╡ 93eecdf8-10af-11eb-2316-41713c47ef8e
md"
_Later... Talking about distribution_

>  We want to write `A*B` and launch a thousand computations on a thousand machines, calculating a vast matrix product together.
"

# ╔═╡ 43eba682-10af-11eb-17c2-b9380693f125
md"
## Just In Time compilation

* It gets the performance of a compiled langague
* It gets the dynamicism of a scripted language
* It gets a REPL
* _In the REPL_ you pay a cost for compilation
"

# ╔═╡ b88c1bee-1153-11eb-06ed-f383d9e7125a
md"
## The REPL

* since 0.2

### REPL has modes

* julia mode
* help mode
* pkg mode
* shell mode
* search mode
"

# ╔═╡ 9d4e8622-1154-11eb-283e-a73b653e9d1f
md"
## MACROS

* @time - times the function call
* @code_native - prints assembly for the function call
"

# ╔═╡ e1d62d86-1156-11eb-3ffd-618e70f8a172
md"
## Square Root example
"

# ╔═╡ 00a5cf4e-1157-11eb-3768-85ed6b4ef1c4
function Babylonian(x; N=10)
	t = (1+x) / 2
	for i=2:N; t=(t + x/t)/2 end
	t
end

# ╔═╡ 7565b0a6-1157-11eb-016e-85230f08f856
(Babylonian(999), √999)

# ╔═╡ fdff8830-1157-11eb-1ba7-377bd413e129
md"
## Use Cases + Performance

* Federal Reserve Bank - Economic Modeling
* Celeste Project - Using Sky Survey images to catalog every object in the sky. Petascale.
* Climate Modeling Alliance - Earth scale climate modelling
"

# ╔═╡ 56b72642-115b-11eb-101c-a17980bbe9a3
md"
### A different performance story

* As web developers the performance story is about better throughput and response times. 5ms - 500ms - 5s
* Julia's performance story talks about 5h - 5d - 5M
* These are the _same_.  Just instructions to a processor and ability to parallize.
"

# ╔═╡ 12f489ec-14c7-11eb-2ab0-9341d3cf110e
md"### Micro Benchmarks"

# ╔═╡ 08d2039c-14c7-11eb-13f5-c9bab870758c
Resource("https://julialang.org/assets/benchmarks/benchmarks.svg")

# ╔═╡ d3bca9e8-115c-11eb-3b29-c5d23bcdc771
md"
# Matrix processing

* Julia has language features that are targeting math users.  Matrices.

"

# ╔═╡ 4ac107aa-115d-11eb-27d0-ff3aa05bde2e
[ 1, 2, 3]

# ╔═╡ 5171f726-115d-11eb-2dc3-1d92ad1d7772
[1 2 3]

# ╔═╡ 54984c8e-115d-11eb-020a-2dc7543a6f2c
[1 2; 3 4]

# ╔═╡ 6db9a8e0-115d-11eb-0706-61e32fcf1d5f
fiveby = ones(5,5)

# ╔═╡ 4854ba06-115e-11eb-1f77-db29b218b4d5
function avg(a)
  reduce(+, a) / length(a)
end

# ╔═╡ 5d1b07ac-115d-11eb-33a3-353aafea44a1
avg(fiveby)

# ╔═╡ 5cd83f3c-115e-11eb-1602-ddbc9f892f48
v = view(fiveby, :, 3)

# ╔═╡ 6604fb74-115e-11eb-16bf-69e4c003ce98
v .+= 3

# ╔═╡ 6a2bc78c-115e-11eb-094c-ed7d12be3d1f
fiveby

# ╔═╡ 6dcce5ce-115e-11eb-034a-cfa0c07903e6
avg(fiveby)

# ╔═╡ 8536eea6-115e-11eb-061e-d7966498efe2
function avgOverMatrix(a, area=1)
	origin = CartesianIndex((1, 1))
	maxBoundary = CartesianIndex(size(a))
	newM = copy(a)
	for I in CartesianIndices(a)
		X = CartesianIndex(Tuple(I) .+ -area)
		Y = CartesianIndex(Tuple(I) .+ area)
		v = view(a, (max(origin, X):(min(maxBoundary, Y))))
		newM[I] = avg(v)
	end
	return newM
end

# ╔═╡ 8baa9d76-115f-11eb-16c1-ab1a1a658d78
avg(v)

# ╔═╡ d432f3fc-115f-11eb-2ae8-d523034e8802
reduce(+, v)

# ╔═╡ d918501a-115f-11eb-245e-af9316136256
reduce(+, fiveby)

# ╔═╡ e5b65114-115f-11eb-0244-3df5d96f4c28
fiveby

# ╔═╡ 0f130c5a-1160-11eb-1065-2f86a7be4da4
avgOverMatrix(fiveby)

# ╔═╡ 3fadbc50-1160-11eb-185e-432ee2e63a8b
fiveby

# ╔═╡ c57a1318-14c7-11eb-341a-4b20abfb9938
md"## Colors"

# ╔═╡ a7957d80-1160-11eb-1fa9-135c37d417c2
red = RGB(200.0, 0.0, 0.0)

# ╔═╡ c3d87d3c-1160-11eb-2ca2-719a6b4b76a2
blue = RGB(0.0, 0.0, 200.0)

# ╔═╡ b850efb2-1160-11eb-3828-ad1ea4ac9e1a
purple = red + blue

# ╔═╡ 28a65254-1161-11eb-3e9c-639ff4f2ca04
"$(purple)"

# ╔═╡ ee8caeaa-1169-11eb-3843-05d310dd6e08
md"
# Image Manipulation
"

# ╔═╡ 4b094364-1165-11eb-3061-a74556d153a5
hr_url = "https://cdn.hashrocket.com/assets/img_hashrocket_team-cb4dd18169ae46230a36a6b1d9113760eb49a448b2297c122d980f986133ffdc.jpg"

# ╔═╡ 0c2d239c-1168-11eb-0953-4d54158aebea
hr_img = download(hr_url, "hashrocket.jpg")

# ╔═╡ 0bdd21de-1169-11eb-3617-ffee3dba45e3
image = load("hashrocket.jpg")

# ╔═╡ 2231cc68-116a-11eb-166c-fbab9f7ed1cd
typeof(image)

# ╔═╡ 25007e76-116a-11eb-26f0-c5acf723b970
reverse(image, dims=2)

# ╔═╡ 37bb220a-116a-11eb-2407-2beeb1eb7153
size(image)

# ╔═╡ 69416d0c-116a-11eb-112a-c11cf6a4eccc
Q = (div.(size(image) , 2))

# ╔═╡ 33ae85f0-116a-11eb-3ca9-5b4a1c21b10e
topQuarter = Array(view(image, 1:Q[1], 1:Q[2]))

# ╔═╡ 823514e8-116b-11eb-2f3f-559e2106eb98
[reverse(topQuarter, dims=1) reverse(topQuarter, dims=2)]

# ╔═╡ 99bfb8e8-116b-11eb-03b2-dbc58aa96b78
[
 topQuarter                   reverse(topQuarter, dims=2)
 reverse(topQuarter, dims=1)  reverse(reverse(topQuarter, dims=1), dims=2)
]

# ╔═╡ ccfe04a0-115f-11eb-3403-038fe613c5bc
size(topQuarter)

# ╔═╡ 4c31ac00-116e-11eb-15a8-a99f2c3f9c29
@bind x PlutoUI.Slider(100:1000)

# ╔═╡ bc9221c8-14c8-11eb-22c2-095af6776eda
x


# ╔═╡ e473e270-116d-11eb-3736-6f08b0d60193
jonjackson = Array(view(topQuarter, x:x+200, x:x+200))	

# ╔═╡ a6838930-1173-11eb-254d-2959e482e52a
rgbjackson = convert(Array{RGB{Float32}}, jonjackson);

# ╔═╡ 7f292128-1174-11eb-253b-b90fc06da439
@bind area PlutoUI.Slider(1:10)

# ╔═╡ e47ab0ba-1173-11eb-36be-1fb517e82120
[avgOverMatrix(rgbjackson, area) rgbjackson]

# ╔═╡ 27fa87c6-14ca-11eb-35eb-833749b5be8a
md"# Conclusion"

# ╔═╡ 37fb956e-14ca-11eb-03bd-35558c69cb7d
md"Julia might not be the right choice for webapps, but neither was Ruby until Rails came along.  It is, however, a tool to help us keep pushing forwards the boundaries of human knowledge, and that is pretty cool."

# ╔═╡ f478b37a-116b-11eb-3f60-9f724fd4facc


# ╔═╡ Cell order:
# ╟─afd0822e-10ae-11eb-02dd-5bd210db8c55
# ╟─16841620-10af-11eb-10f6-17396ac0aa8e
# ╟─2977b552-10af-11eb-2375-9fe1ad294929
# ╟─925536b2-10af-11eb-18d3-25fa2f7b6ee3
# ╟─93eecdf8-10af-11eb-2316-41713c47ef8e
# ╟─43eba682-10af-11eb-17c2-b9380693f125
# ╟─b88c1bee-1153-11eb-06ed-f383d9e7125a
# ╟─9d4e8622-1154-11eb-283e-a73b653e9d1f
# ╟─e1d62d86-1156-11eb-3ffd-618e70f8a172
# ╠═00a5cf4e-1157-11eb-3768-85ed6b4ef1c4
# ╠═7565b0a6-1157-11eb-016e-85230f08f856
# ╟─fdff8830-1157-11eb-1ba7-377bd413e129
# ╠═56b72642-115b-11eb-101c-a17980bbe9a3
# ╠═12f489ec-14c7-11eb-2ab0-9341d3cf110e
# ╠═08d2039c-14c7-11eb-13f5-c9bab870758c
# ╟─d3bca9e8-115c-11eb-3b29-c5d23bcdc771
# ╠═4ac107aa-115d-11eb-27d0-ff3aa05bde2e
# ╠═5171f726-115d-11eb-2dc3-1d92ad1d7772
# ╠═54984c8e-115d-11eb-020a-2dc7543a6f2c
# ╠═6db9a8e0-115d-11eb-0706-61e32fcf1d5f
# ╠═4854ba06-115e-11eb-1f77-db29b218b4d5
# ╠═5d1b07ac-115d-11eb-33a3-353aafea44a1
# ╠═5cd83f3c-115e-11eb-1602-ddbc9f892f48
# ╠═6604fb74-115e-11eb-16bf-69e4c003ce98
# ╠═6a2bc78c-115e-11eb-094c-ed7d12be3d1f
# ╠═6dcce5ce-115e-11eb-034a-cfa0c07903e6
# ╠═8536eea6-115e-11eb-061e-d7966498efe2
# ╠═8baa9d76-115f-11eb-16c1-ab1a1a658d78
# ╠═d432f3fc-115f-11eb-2ae8-d523034e8802
# ╠═d918501a-115f-11eb-245e-af9316136256
# ╠═e5b65114-115f-11eb-0244-3df5d96f4c28
# ╠═0f130c5a-1160-11eb-1065-2f86a7be4da4
# ╠═3fadbc50-1160-11eb-185e-432ee2e63a8b
# ╟─c57a1318-14c7-11eb-341a-4b20abfb9938
# ╠═9d277ee0-1160-11eb-2425-83fa14b294d8
# ╠═a7957d80-1160-11eb-1fa9-135c37d417c2
# ╠═c3d87d3c-1160-11eb-2ca2-719a6b4b76a2
# ╠═b850efb2-1160-11eb-3828-ad1ea4ac9e1a
# ╠═28a65254-1161-11eb-3e9c-639ff4f2ca04
# ╟─ee8caeaa-1169-11eb-3843-05d310dd6e08
# ╠═fb433ce8-1166-11eb-18a5-7b78ba9f3aa4
# ╟─4b094364-1165-11eb-3061-a74556d153a5
# ╟─0c2d239c-1168-11eb-0953-4d54158aebea
# ╠═0bdd21de-1169-11eb-3617-ffee3dba45e3
# ╠═2231cc68-116a-11eb-166c-fbab9f7ed1cd
# ╠═25007e76-116a-11eb-26f0-c5acf723b970
# ╠═37bb220a-116a-11eb-2407-2beeb1eb7153
# ╠═69416d0c-116a-11eb-112a-c11cf6a4eccc
# ╠═33ae85f0-116a-11eb-3ca9-5b4a1c21b10e
# ╠═823514e8-116b-11eb-2f3f-559e2106eb98
# ╠═99bfb8e8-116b-11eb-03b2-dbc58aa96b78
# ╠═ccfe04a0-115f-11eb-3403-038fe613c5bc
# ╠═4c31ac00-116e-11eb-15a8-a99f2c3f9c29
# ╟─bc9221c8-14c8-11eb-22c2-095af6776eda
# ╠═e473e270-116d-11eb-3736-6f08b0d60193
# ╠═a6838930-1173-11eb-254d-2959e482e52a
# ╠═7f292128-1174-11eb-253b-b90fc06da439
# ╠═e47ab0ba-1173-11eb-36be-1fb517e82120
# ╟─27fa87c6-14ca-11eb-35eb-833749b5be8a
# ╟─37fb956e-14ca-11eb-03bd-35558c69cb7d
# ╟─f478b37a-116b-11eb-3f60-9f724fd4facc
