require("opt_precision")

if OPT_DOUBLE_PRECISION then
    OPT_FLOAT2 = double2
    OPT_FLOAT3 = double3
	OPT_FLOAT4 = double4
else
    OPT_FLOAT2 = float2
    OPT_FLOAT3 = float3
	OPT_FLOAT4 = float4
end

local N,U = opt.Dim("N",0), opt.Dim("U",1)
local funcParams =   Unknown("funcParams", OPT_FLOAT4, {U}, 0) -- a,b,c,d
local data =         Image("data", OPT_FLOAT2, {N}, 1) -- a,b

local G = Graph("G", 2,
                "d", {N}, 3, 
				"abcd", {U}, 5)

UsePreconditioner(true)

local d = data(G.d)
local abcd = funcParams(G.abcd)
local x_i = d(0)
local y_i = d(1)
local a = abcd(0)
local b = abcd(1)
local c = abcd(2)
local d = abcd(3)


Energy(y_i - a * ( x_i * x_i + x_i * b) / (x_i * x_i + x_i * c + d) )
