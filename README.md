
# Install Julia

```
asdf plugin-add julia
asdf install julia 1.5.2
```

## Install Pluto

Run Julia and add the package:

```
julia> ]
(v1.5) pkg> add Pluto
```

Using the package manager for the first time can take up to 15 minutes - hang in there!

To run the notebook server:

```
julia> import Pluto
julia> Pluto.run()
```

## Open the notebook

This repo has a notebook `./julianotebook.jl` that you should be able to open.

When you open it, it should take 5 mins to install all the dependencies.
