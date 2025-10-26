using PyCall
matplotlib = pyimport("matplotlib")
println(matplotlib.rcsetup[:all_backends])