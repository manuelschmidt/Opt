require("opt_precision")

if OPT_DOUBLE_PRECISION then
    OPT_FLOAT2 = double2
    OPT_FLOAT3 = double3
else
    OPT_FLOAT2 = float2
    OPT_FLOAT3 = float3
end

local N,U = opt.Dim("N",0), opt.Dim("U",1)
local funcParams =   Unknown("funcParams", OPT_FLOAT3, {U}, 0) -- a,b,c
local data =         Image("data", OPT_FLOAT2, {N}, 1) -- a,b

local G = Graph("G", 2,
                "d", {N}, 3, 
				"abc", {U}, 5)

UsePreconditioner(true)

local d = data(G.d)
local abc = funcParams(G.abc)
local x_i = d(0)
local y_i = d(1)
local a = abc(0)
local b = abc(1)
local c = abc(2)
--local d = abc(3)

Energy(y_i - a / (1.0 + ad.exp(b - c * x_i)))
