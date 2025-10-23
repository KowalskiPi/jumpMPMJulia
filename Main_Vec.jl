using Printf # this is to use package Printf
println("Creating arrays...")
array1 = Array{Float64}(undef,10,1000000) # this array is not initialized
array2 = Array{Float64}(undef,10,1000000)
array3 = Array{Float64}(undef,10,1000000)
# Arrays index starts from 1
for i = 1:1:size(array1,1)
    for j = 1:1:size(array1,2)
        array1[i,j] = 1.0*i
        array2[i,j] = -1.0*i
        array3[i,j] = 0
    end
end
println("...done\n")

iterations = 100

function sum1(r, x1, x2 ) # vectorized version
    #function sum1(r::Array{Float64}, x1, x2 ) # with type declaration
    for count=1:iterations
        r = x1 + x2
    end
end

function sum2(r, x1, x2) # loop version i-j
    ni = size(x1,1)
    nj = size(x2,2)
    for count=1:iterations
        for i = 1:ni
            for j = 1:nj
                r[i,j] = x1[i,j] + x2[i,j]
            end
        end
    end
end

function sum3(r, x1, x2) # loop version j-i
    ni = size(x1,1)
    nj = size(x2,2)
    for count=1:iterations
        for j = 1:nj
            for i = 1:ni
                r[i,j] = x1[i,j] + x2[i,j]
            end
        end
    end
end

@time sum1(array3, array1, array2)
@time sum2(array3, array1, array2)
@time sum3(array3, array1, array2)