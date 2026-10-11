local Base64 = require(script.Base64)
local band = bit32.band
local bor = bit32.bor
local bxor = bit32.bxor
local lshift = bit32.lshift
local rshift = bit32.rshift
local lrotate = bit32.lrotate
local rrotate = bit32.rrotate
local v = {}
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = {}
local v7 = {}
local v8 = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	28,
	25,
	26,
	27,
	0,
	0,
	10,
	9,
	11,
	12,
	0,
	15,
	16,
	17,
	18,
	0,
	20,
	22,
	23,
	21
}
local v9 = {}

local function sha256_feed_64(joined, value, p, p2)
	local v10 = v9
	local v11 = v2
	local v12 = joined[1]
	local v13 = joined[2]
	local v14 = joined[3]
	local v15 = joined[4]
	local v16 = joined[5]
	local v17 = joined[6]
	local v18 = joined[7]
	local v19 = joined[8]

	for i = p, p + p2 - 1, 64 do
		local v20 = i

		for j = 1, 16 do
			v20 += 4
			local v21, v22, v23, v24 = string.byte(value, v20 - 3, v20)
			v10[j] = ((v21 * 256 + v22) * 256 + v23) * 256 + v24
		end

		for j = 17, 64 do
			local v21 = v10[j - 15]
			local v22 = v10[j - 2]
			v10[j] = bxor(rrotate(v21, 7), lrotate(v21, 14), (rshift(v21, 3))) + bxor(lrotate(v22, 15), lrotate(v22, 13), (rshift(v22, 10))) + v10[j - 7] + v10[j - 16]
		end

		local v21 = v12
		local v22 = v13
		local v23 = v14
		local v24 = v15
		local v25 = v19
		local v26 = v18
		local v27 = v17
		local v28 = v16

		for j = 1, 64 do
			local v29 = bxor(rrotate(v28, 6), rrotate(v28, 11), (lrotate(v28, 7))) + band(v28, v27) + band(-1 - v28, v26) + v25 + v11[j] + v10[j]
			local v30 = v29 + v24
			local v31 = v29 + band(v23, v22) + band(v21, (bxor(v23, v22))) + bxor(rrotate(v21, 2), rrotate(v21, 13), (lrotate(v21, 10)))
			v24 = v23
			v23 = v22
			v22 = v21
			v21 = v31
			v25 = v26
			v26 = v27
			v27 = v28
			v28 = v30
		end

		v12 = (v21 + v12) % 4294967296
		v13 = (v22 + v13) % 4294967296
		v14 = (v23 + v14) % 4294967296
		v15 = (v24 + v15) % 4294967296
		v16 = (v28 + v16) % 4294967296
		v17 = (v27 + v17) % 4294967296
		v18 = (v26 + v18) % 4294967296
		v19 = (v25 + v19) % 4294967296
	end

	joined[1] = v12
	joined[2] = v13
	joined[3] = v14
	joined[4] = v15
	joined[5] = v16
	joined[6] = v17
	joined[7] = v18
	joined[8] = v19
end

local function sha512_feed_128(list, list2, value, p, p2)
	local v10 = v9
	local v11 = v
	local v12 = v2
	local v13 = list[1]
	local v14 = list[2]
	local v15 = list[3]
	local v16 = list[4]
	local v17 = list[5]
	local v18 = list[6]
	local v19 = list[7]
	local v20 = list[8]
	local v21 = list2[1]
	local v22 = list2[2]
	local v23 = list2[3]
	local v24 = list2[4]
	local v25 = list2[5]
	local v26 = list2[6]
	local v27 = list2[7]
	local v28 = list2[8]

	for i = p, p + p2 - 1, 128 do
		local v29 = i

		for j = 1, 32 do
			v29 += 4
			local v30, v31, v32, v33 = string.byte(value, v29 - 3, v29)
			v10[j] = ((v30 * 256 + v31) * 256 + v32) * 256 + v33
		end

		for j = 34, 160, 2 do
			local v30 = v10[j - 30]
			local v31 = v10[j - 31]
			local v32 = v10[j - 4]
			local v33 = v10[j - 5]
			local v41 = bxor(
				rshift(v30, 1) + lshift(v31, 31),
				rshift(v30, 8) + lshift(v31, 24),
				rshift(v30, 7) + lshift(v31, 25)
			) % 4294967296 + bxor(
				rshift(v32, 19) + lshift(v33, 13),
				lshift(v32, 3) + rshift(v33, 29),
				rshift(v32, 6) + lshift(v33, 26)
			) % 4294967296 + v10[j - 14] + v10[j - 32]
			local v42 = v41 % 4294967296
			local v43 = j - 1
			v10[v43] = bxor(rshift(v31, 1) + lshift(v30, 31), rshift(v31, 8) + lshift(v30, 24), (rshift(v31, 7))) + bxor(
				rshift(v33, 19) + lshift(v32, 13),
				lshift(v33, 3) + rshift(v32, 29),
				(rshift(v33, 6))
			) + v10[j - 15] + v10[j - 33] + (v41 - v42) / 4294967296
			v10[j] = v42
		end

		local v30 = v21
		local v31 = v13
		local v32 = v22
		local v33 = v14
		local v34 = v23
		local v35 = v15
		local v36 = v24
		local v37 = v16
		local v38 = v28
		local v39 = v27
		local v40 = v26
		local v41 = v20
		local v42 = v19
		local v43 = v18
		local v44 = v25
		local v45 = v17

		for j = 1, 80 do
			local v46 = j * 2
			local v53 = bxor(
				rshift(v45, 14) + lshift(v44, 18),
				rshift(v45, 18) + lshift(v44, 14),
				lshift(v45, 23) + rshift(v44, 9)
			) % 4294967296 + (band(v45, v43) + band(-1 - v45, v42)) % 4294967296 + v41 + v11[j] + v10[v46]
			local v54 = v53 % 4294967296
			local v60 = bxor(
				rshift(v44, 14) + lshift(v45, 18),
				rshift(v44, 18) + lshift(v45, 14),
				lshift(v44, 23) + rshift(v45, 9)
			) + band(v44, v40) + band(-1 - v44, v39) + v38 + v12[j] + v10[v46 - 1] + (v53 - v54) / 4294967296
			local v61 = v54 + v37
			local v62 = v61 % 4294967296
			local v63 = v60 + v36 + (v61 - v62) / 4294967296
			local v70 = v54 + (band(v35, v33) + band(v31, (bxor(v35, v33)))) % 4294967296 + bxor(
				rshift(v31, 28) + lshift(v30, 4),
				lshift(v31, 30) + rshift(v30, 2),
				lshift(v31, 25) + rshift(v30, 7)
			) % 4294967296
			local v71 = v70 % 4294967296
			local v78 = v60 + (band(v34, v32) + band(v30, (bxor(v34, v32)))) + bxor(
				rshift(v30, 28) + lshift(v31, 4),
				lshift(v30, 30) + rshift(v31, 2),
				lshift(v30, 25) + rshift(v31, 7)
			) + (v70 - v71) / 4294967296
			v36 = v34
			v34 = v32
			v32 = v30
			v30 = v78
			v37 = v35
			v35 = v33
			v33 = v31
			v31 = v71
			v38 = v39
			v39 = v40
			v40 = v44
			v44 = v63
			v41 = v42
			v42 = v43
			v43 = v45
			v45 = v62
		end

		local v46 = v13 + v31
		v13 = v46 % 4294967296
		v21 = (v21 + v30 + (v46 - v13) / 4294967296) % 4294967296
		local v47 = v14 + v33
		v14 = v47 % 4294967296
		v22 = (v22 + v32 + (v47 - v14) / 4294967296) % 4294967296
		local v48 = v15 + v35
		v15 = v48 % 4294967296
		v23 = (v23 + v34 + (v48 - v15) / 4294967296) % 4294967296
		local v49 = v16 + v37
		v16 = v49 % 4294967296
		v24 = (v24 + v36 + (v49 - v16) / 4294967296) % 4294967296
		local v50 = v17 + v45
		v17 = v50 % 4294967296
		v25 = (v25 + v44 + (v50 - v17) / 4294967296) % 4294967296
		local v51 = v18 + v43
		v18 = v51 % 4294967296
		v26 = (v26 + v40 + (v51 - v18) / 4294967296) % 4294967296
		local v52 = v19 + v42
		v19 = v52 % 4294967296
		v27 = (v27 + v39 + (v52 - v19) / 4294967296) % 4294967296
		local v53 = v20 + v41
		v20 = v53 % 4294967296
		v28 = (v28 + v38 + (v53 - v20) / 4294967296) % 4294967296
	end

	list[1] = v13
	list[2] = v14
	list[3] = v15
	list[4] = v16
	list[5] = v17
	list[6] = v18
	list[7] = v19
	list[8] = v20
	list2[1] = v21
	list2[2] = v22
	list2[3] = v23
	list2[4] = v24
	list2[5] = v25
	list2[6] = v26
	list2[7] = v27
	list2[8] = v28
end

local function md5_feed_64(list, value, p, p2)
	local v10 = v9
	local v11 = v7
	local v12 = v8
	local v13 = list[1]
	local v14 = list[2]
	local v15 = list[3]
	local v16 = list[4]

	for i = p, p + p2 - 1, 64 do
		local v17 = i

		for j = 1, 16 do
			v17 += 4
			local v18, v19, v20, v21 = string.byte(value, v17 - 3, v17)
			v10[j] = ((v21 * 256 + v20) * 256 + v19) * 256 + v18
		end

		local v18 = v13
		local v19 = v16
		local v20 = v15
		local v21 = v14
		local v22 = 25

		for j = 1, 16 do
			local v23 = rrotate(band(v21, v20) + band(-1 - v21, v19) + v18 + v11[j] + v10[j], v22) + v21
			v22 = v12[v22]
			v18 = v19
			v19 = v20
			v20 = v21
			v21 = v23
		end

		local v23 = 27

		for j = 17, 32 do
			local v24 = rrotate(band(v19, v21) + band(-1 - v19, v20) + v18 + v11[j] + v10[(j * 5 - 4) % 16 + 1], v23) + v21
			v23 = v12[v23]
			v18 = v19
			v19 = v20
			v20 = v21
			v21 = v24
		end

		local v24 = 28

		for j = 33, 48 do
			local v25 = rrotate(bxor(bxor(v21, v20), v19) + v18 + v11[j] + v10[(j * 3 + 2) % 16 + 1], v24) + v21
			v24 = v12[v24]
			v18 = v19
			v19 = v20
			v20 = v21
			v21 = v25
		end

		local v25 = 26

		for j = 49, 64 do
			local v26 = rrotate(bxor(v20, (bor(v21, -1 - v19))) + v18 + v11[j] + v10[(j * 7 - 7) % 16 + 1], v25) + v21
			v25 = v12[v25]
			v18 = v19
			v19 = v20
			v20 = v21
			v21 = v26
		end

		v13 = (v18 + v13) % 4294967296
		v14 = (v21 + v14) % 4294967296
		v15 = (v20 + v15) % 4294967296
		v16 = (v19 + v16) % 4294967296
	end

	list[1] = v13
	list[2] = v14
	list[3] = v15
	list[4] = v16
end

local function sha1_feed_64(joined, value, p, p2)
	local v10 = v9
	local v11 = joined[1]
	local v12 = joined[2]
	local v13 = joined[3]
	local v14 = joined[4]
	local v15 = joined[5]

	for i = p, p + p2 - 1, 64 do
		local v16 = i

		for j = 1, 16 do
			v16 += 4
			local v17, v18, v19, v20 = string.byte(value, v16 - 3, v16)
			v10[j] = ((v17 * 256 + v18) * 256 + v19) * 256 + v20
		end

		for j = 17, 80 do
			v10[j] = lrotate(bxor(v10[j - 3], v10[j - 8], v10[j - 14], v10[j - 16]), 1)
		end

		local v17 = v15
		local v18 = v14
		local v19 = v13
		local v20 = v12
		local v21 = v11

		for j = 1, 20 do
			local v22 = lrotate(v21, 5) + band(v20, v19) + band(-1 - v20, v18) + 1518500249 + v10[j] + v17
			v17 = v18
			v18 = v19
			v19 = rrotate(v20, 2)
			v20 = v21
			v21 = v22
		end

		for j = 21, 40 do
			local v22 = lrotate(v21, 5) + bxor(v20, v19, v18) + 1859775393 + v10[j] + v17
			v17 = v18
			v18 = v19
			v19 = rrotate(v20, 2)
			v20 = v21
			v21 = v22
		end

		for j = 41, 60 do
			local v22 = lrotate(v21, 5) + band(v18, v19) + band(v20, (bxor(v18, v19))) + 2400959708 + v10[j] + v17
			v17 = v18
			v18 = v19
			v19 = rrotate(v20, 2)
			v20 = v21
			v21 = v22
		end

		for j = 61, 80 do
			local v22 = lrotate(v21, 5) + bxor(v20, v19, v18) + 3395469782 + v10[j] + v17
			v17 = v18
			v18 = v19
			v19 = rrotate(v20, 2)
			v20 = v21
			v21 = v22
		end

		v11 = (v21 + v11) % 4294967296
		v12 = (v20 + v12) % 4294967296
		v13 = (v19 + v13) % 4294967296
		v14 = (v18 + v14) % 4294967296
		v15 = (v17 + v15) % 4294967296
	end

	joined[1] = v11
	joined[2] = v12
	joined[3] = v13
	joined[4] = v14
	joined[5] = v15
end

local function keccak_feed(list, list2, value, p, p2, p3)
	local v10 = v5
	local v11 = v6
	local v12 = p3 / 8

	for i = p, p + p2 - 1, p3 do
		local v13 = i

		for j = 1, v12 do
			local v14, v15, v16, v17 = string.byte(value, v13 + 1, v13 + 4)
			local v18 = list[j]
			list[j] = bxor(v18, ((v17 * 256 + v16) * 256 + v15) * 256 + v14)
			v13 += 8
			v14, v15, v16, v17 = string.byte(value, v13 - 3, v13)
			v18 = list2[j]
			list2[j] = bxor(v18, ((v17 * 256 + v16) * 256 + v15) * 256 + v14)
		end

		local v14 = list[1]
		local v15 = list2[1]
		local v16 = list[2]
		local v17 = list2[2]
		local v18 = list[3]
		local v19 = list2[3]
		local v20 = list[4]
		local v21 = list2[4]
		local v22 = list[5]
		local v23 = list2[5]
		local v24 = list[6]
		local v25 = list2[6]
		local v26 = list[7]
		local v27 = list2[7]
		local v28 = list[8]
		local v29 = list2[8]
		local v30 = list[9]
		local v31 = list2[9]
		local v32 = list[10]
		local v33 = list2[10]
		local v34 = list[11]
		local v35 = list2[11]
		local v36 = list[12]
		local v37 = list2[12]
		local v38 = list[13]
		local v39 = list2[13]
		local v40 = list[14]
		local v41 = list2[14]
		local v42 = list[15]
		local v43 = list2[15]
		local v44 = list[16]
		local v45 = list2[16]
		local v46 = list[17]
		local v47 = list2[17]
		local v48 = list[18]
		local v49 = list2[18]
		local v50 = list[19]
		local v51 = list2[19]
		local v52 = list[20]
		local v53 = list2[20]
		local v54 = list[21]
		local v55 = list2[21]
		local v56 = list[22]
		local v57 = list2[22]
		local v58 = list[23]
		local v59 = list2[23]
		local v60 = list[24]
		local v61 = list2[24]
		local v62 = list[25]
		local v63 = list2[25]

		for j = 1, 24 do
			local v64 = bxor(v14, v24, v34, v44, v54)
			local v65 = bxor(v15, v25, v35, v45, v55)
			local v66 = bxor(v16, v26, v36, v46, v56)
			local v67 = bxor(v17, v27, v37, v47, v57)
			local v68 = bxor(v18, v28, v38, v48, v58)
			local v69 = bxor(v19, v29, v39, v49, v59)
			local v70 = bxor(v20, v30, v40, v50, v60)
			local v71 = bxor(v21, v31, v41, v51, v61)
			local v72 = bxor(v22, v32, v42, v52, v62)
			local v73 = bxor(v23, v33, v43, v53, v63)
			local v75 = bxor(v64, v68 * 2 + (v69 % 4294967296 - v69 % 2147483648) / 2147483648)
			local v77 = bxor(v65, v69 * 2 + (v68 % 4294967296 - v68 % 2147483648) / 2147483648)
			local v78 = bxor(v75, v16)
			local v79 = bxor(v77, v17)
			local v80 = bxor(v75, v26)
			local v81 = bxor(v77, v27)
			local v82 = bxor(v75, v36)
			local v83 = bxor(v77, v37)
			local v84 = bxor(v75, v46)
			local v85 = bxor(v77, v47)
			local v86 = bxor(v75, v56)
			v75 = bxor(v77, v57)
			v77 = (v80 % 4294967296 - v80 % 1048576) / 1048576 + v81 * 4096
			local v87 = (v81 % 4294967296 - v81 % 1048576) / 1048576 + v80 * 4096
			v80 = (v84 % 4294967296 - v84 % 524288) / 524288 + v85 * 8192
			v81 = (v85 % 4294967296 - v85 % 524288) / 524288 + v84 * 8192
			v84 = v78 * 2 + (v79 % 4294967296 - v79 % 2147483648) / 2147483648
			v85 = v79 * 2 + (v78 % 4294967296 - v78 % 2147483648) / 2147483648
			v78 = v82 * 1024 + (v83 % 4294967296 - v83 % 4194304) / 4194304
			v79 = v83 * 1024 + (v82 % 4294967296 - v82 % 4194304) / 4194304
			v82 = v86 * 4 + (v75 % 4294967296 - v75 % 1073741824) / 1073741824
			v83 = v75 * 4 + (v86 % 4294967296 - v86 % 1073741824) / 1073741824
			v75 = bxor(v66, v70 * 2 + (v71 % 4294967296 - v71 % 2147483648) / 2147483648)
			v86 = bxor(v67, v71 * 2 + (v70 % 4294967296 - v70 % 2147483648) / 2147483648)
			local v90 = bxor(v75, v18)
			local v91 = bxor(v86, v19)
			local v92 = bxor(v75, v28)
			local v93 = bxor(v86, v29)
			local v94 = bxor(v75, v38)
			local v95 = bxor(v86, v39)
			local v96 = bxor(v75, v48)
			local v97 = bxor(v86, v49)
			local v98 = bxor(v75, v58)
			v75 = bxor(v86, v59)
			v86 = (v94 % 4294967296 - v94 % 2097152) / 2097152 + v95 * 2048
			local v99 = (v95 % 4294967296 - v95 % 2097152) / 2097152 + v94 * 2048
			v94 = (v98 % 4294967296 - v98 % 8) / 8 + v75 * 536870912 % 4294967296
			v95 = (v75 % 4294967296 - v75 % 8) / 8 + v98 * 536870912 % 4294967296
			v75 = v92 * 64 + (v93 % 4294967296 - v93 % 67108864) / 67108864
			v98 = v93 * 64 + (v92 % 4294967296 - v92 % 67108864) / 67108864
			v92 = v96 * 32768 + (v97 % 4294967296 - v97 % 131072) / 131072
			v93 = v97 * 32768 + (v96 % 4294967296 - v96 % 131072) / 131072
			v96 = (v90 % 4294967296 - v90 % 4) / 4 + v91 * 1073741824 % 4294967296
			v97 = (v91 % 4294967296 - v91 % 4) / 4 + v90 * 1073741824 % 4294967296
			v90 = bxor(v68, v72 * 2 + (v73 % 4294967296 - v73 % 2147483648) / 2147483648)
			v68 = bxor(v69, v73 * 2 + (v72 % 4294967296 - v72 % 2147483648) / 2147483648)
			v69 = bxor(v90, v20)
			v91 = bxor(v68, v21)
			local v102 = bxor(v90, v30)
			local v103 = bxor(v68, v31)
			local v104 = bxor(v90, v40)
			local v105 = bxor(v68, v41)
			local v106 = bxor(v90, v50)
			local v107 = bxor(v68, v51)
			local v108 = bxor(v90, v60)
			v90 = bxor(v68, v61)
			v68 = v106 * 2097152 % 4294967296 + (v107 % 4294967296 - v107 % 2048) / 2048
			local v109 = v107 * 2097152 % 4294967296 + (v106 % 4294967296 - v106 % 2048) / 2048
			v106 = v69 * 268435456 % 4294967296 + (v91 % 4294967296 - v91 % 16) / 16
			v107 = v91 * 268435456 % 4294967296 + (v69 % 4294967296 - v69 % 16) / 16
			v69 = v104 * 33554432 % 4294967296 + (v105 % 4294967296 - v105 % 128) / 128
			v91 = v105 * 33554432 % 4294967296 + (v104 % 4294967296 - v104 % 128) / 128
			v104 = (v108 % 4294967296 - v108 % 256) / 256 + v90 * 16777216 % 4294967296
			v105 = (v90 % 4294967296 - v90 % 256) / 256 + v108 * 16777216 % 4294967296
			v90 = (v102 % 4294967296 - v102 % 512) / 512 + v103 * 8388608 % 4294967296
			v108 = (v103 % 4294967296 - v103 % 512) / 512 + v102 * 8388608 % 4294967296
			v102 = bxor(v70, v64 * 2 + (v65 % 4294967296 - v65 % 2147483648) / 2147483648)
			v64 = bxor(v71, v65 * 2 + (v64 % 4294967296 - v64 % 2147483648) / 2147483648)
			v65 = bxor(v102, v22)
			v70 = bxor(v64, v23)
			v71 = bxor(v102, v32)
			v103 = bxor(v64, v33)
			local v112 = bxor(v102, v42)
			local v113 = bxor(v64, v43)
			local v114 = bxor(v102, v52)
			local v115 = bxor(v64, v53)
			local v116 = bxor(v102, v62)
			v102 = bxor(v64, v63)
			v64 = v116 * 16384 + (v102 % 4294967296 - v102 % 262144) / 262144
			local v117 = v102 * 16384 + (v116 % 4294967296 - v116 % 262144) / 262144
			v102 = v71 * 1048576 % 4294967296 + (v103 % 4294967296 - v103 % 4096) / 4096
			v116 = v103 * 1048576 % 4294967296 + (v71 % 4294967296 - v71 % 4096) / 4096
			v71 = v114 * 256 + (v115 % 4294967296 - v115 % 16777216) / 16777216
			v103 = v115 * 256 + (v114 % 4294967296 - v114 % 16777216) / 16777216
			v114 = v65 * 134217728 % 4294967296 + (v70 % 4294967296 - v70 % 32) / 32
			v115 = v70 * 134217728 % 4294967296 + (v65 % 4294967296 - v65 % 32) / 32
			v65 = (v112 % 4294967296 - v112 % 33554432) / 33554432 + v113 * 128
			v70 = (v113 % 4294967296 - v113 % 33554432) / 33554432 + v112 * 128
			v112 = bxor(v72, v66 * 2 + (v67 % 4294967296 - v67 % 2147483648) / 2147483648)
			v66 = bxor(v73, v67 * 2 + (v66 % 4294967296 - v66 % 2147483648) / 2147483648)
			v67 = bxor(v112, v24)
			v72 = bxor(v66, v25)
			v73 = bxor(v112, v34)
			v113 = bxor(v66, v35)
			local v120 = bxor(v112, v44)
			local v121 = bxor(v66, v45)
			local v122 = bxor(v112, v54)
			local v123 = bxor(v66, v55)
			local v124 = v73 * 8 + (v113 % 4294967296 - v113 % 536870912) / 536870912
			local v125 = v113 * 8 + (v73 % 4294967296 - v73 % 536870912) / 536870912
			v73 = v122 * 262144 + (v123 % 4294967296 - v123 % 16384) / 16384
			v113 = v123 * 262144 + (v122 % 4294967296 - v122 % 16384) / 16384
			v122 = (v67 % 4294967296 - v67 % 268435456) / 268435456 + v72 * 16
			v123 = (v72 % 4294967296 - v72 % 268435456) / 268435456 + v67 * 16
			v67 = (v120 % 4294967296 - v120 % 8388608) / 8388608 + v121 * 512
			v72 = (v121 % 4294967296 - v121 % 8388608) / 8388608 + v120 * 512
			v120 = bxor(v112, v14)
			v112 = bxor(v66, v15)
			v66 = bxor(v120, (band(-1 - v77, v86)))
			v16 = bxor(v77, (band(-1 - v86, v68)))
			v18 = bxor(v86, (band(-1 - v68, v64)))
			v20 = bxor(v68, (band(-1 - v64, v120)))
			v22 = bxor(v64, (band(-1 - v120, v77)))
			v64 = bxor(v112, (band(-1 - v87, v99)))
			v17 = bxor(v87, (band(-1 - v99, v109)))
			v19 = bxor(v99, (band(-1 - v109, v117)))
			v21 = bxor(v109, (band(-1 - v117, v112)))
			v23 = bxor(v117, (band(-1 - v112, v87)))
			v24 = bxor(v106, (band(-1 - v102, v124)))
			v26 = bxor(v102, (band(-1 - v124, v80)))
			v28 = bxor(v124, (band(-1 - v80, v94)))
			v30 = bxor(v80, (band(-1 - v94, v106)))
			v32 = bxor(v94, (band(-1 - v106, v102)))
			v25 = bxor(v107, (band(-1 - v116, v125)))
			v27 = bxor(v116, (band(-1 - v125, v81)))
			v29 = bxor(v125, (band(-1 - v81, v95)))
			v31 = bxor(v81, (band(-1 - v95, v107)))
			v33 = bxor(v95, (band(-1 - v107, v116)))
			v34 = bxor(v84, (band(-1 - v75, v69)))
			v36 = bxor(v75, (band(-1 - v69, v71)))
			v38 = bxor(v69, (band(-1 - v71, v73)))
			v40 = bxor(v71, (band(-1 - v73, v84)))
			v42 = bxor(v73, (band(-1 - v84, v75)))
			v35 = bxor(v85, (band(-1 - v98, v91)))
			v37 = bxor(v98, (band(-1 - v91, v103)))
			v39 = bxor(v91, (band(-1 - v103, v113)))
			v41 = bxor(v103, (band(-1 - v113, v85)))
			v43 = bxor(v113, (band(-1 - v85, v98)))
			v44 = bxor(v114, (band(-1 - v122, v78)))
			v46 = bxor(v122, (band(-1 - v78, v92)))
			v48 = bxor(v78, (band(-1 - v92, v104)))
			v50 = bxor(v92, (band(-1 - v104, v114)))
			v52 = bxor(v104, (band(-1 - v114, v122)))
			v45 = bxor(v115, (band(-1 - v123, v79)))
			v47 = bxor(v123, (band(-1 - v79, v93)))
			v49 = bxor(v79, (band(-1 - v93, v105)))
			v51 = bxor(v93, (band(-1 - v105, v115)))
			v53 = bxor(v105, (band(-1 - v115, v123)))
			v54 = bxor(v96, (band(-1 - v90, v65)))
			v56 = bxor(v90, (band(-1 - v65, v67)))
			v58 = bxor(v65, (band(-1 - v67, v82)))
			v60 = bxor(v67, (band(-1 - v82, v96)))
			v62 = bxor(v82, (band(-1 - v96, v90)))
			v55 = bxor(v97, (band(-1 - v108, v70)))
			v57 = bxor(v108, (band(-1 - v70, v72)))
			v59 = bxor(v70, (band(-1 - v72, v83)))
			v61 = bxor(v72, (band(-1 - v83, v97)))
			v63 = bxor(v83, (band(-1 - v97, v108)))
			v14 = bxor(v66, v10[j])
			v15 = v64 + v11[j]
		end

		list[1] = v14
		list2[1] = v15
		list[2] = v16
		list2[2] = v17
		list[3] = v18
		list2[3] = v19
		list[4] = v20
		list2[4] = v21
		list[5] = v22
		list2[5] = v23
		list[6] = v24
		list2[6] = v25
		list[7] = v26
		list2[7] = v27
		list[8] = v28
		list2[8] = v29
		list[9] = v30
		list2[9] = v31
		list[10] = v32
		list2[10] = v33
		list[11] = v34
		list2[11] = v35
		list[12] = v36
		list2[12] = v37
		list[13] = v38
		list2[13] = v39
		list[14] = v40
		list2[14] = v41
		list[15] = v42
		list2[15] = v43
		list[16] = v44
		list2[16] = v45
		list[17] = v46
		list2[17] = v47
		list[18] = v48
		list2[18] = v49
		list[19] = v50
		list2[19] = v51
		list[20] = v52
		list2[20] = v53
		list[21] = v54
		list2[21] = v55
		list[22] = v56
		list2[22] = v57
		list[23] = v58
		list2[23] = v59
		list[24] = v60
		list2[24] = v61
		list[25] = v62
		list2[25] = v63
	end
end

local function mul(list, list2, p, p2)
	local result = table.create(p2)
	local v10 = 0
	local v11 = 1
	local total = 0

	for i = 1, p2 do
		for j = math.max(1, i + 1 - #list2), math.min(i, #list) do
			v10 += p * list[j] * list2[i + 1 - j]
		end

		local v12 = v10 % 16777216
		result[i] = math.floor(v12)
		v10 = (v10 - v12) / 16777216
		total += v12 * v11
		v11 *= 16777216
	end

	return result, total
end

local v10 = v3
local v11 = v4
local total = 4
local v12 = { 4, 1, 2, -2, 2 }
local v13 = { 1 }
local count = 0
local v14 = { [224] = {}, [256] = v4 }
local v15 = { [384] = {}, [512] = v4 }
local v16 = { [384] = {}, [512] = v3 }
local v17 = { 1732584193, 4023233417, 2562383102, 271733878, 3285377520 }

repeat
	total += v12[total % 6]
	local total2 = 1
	local flag = true

	while true do
		total2 += v12[total2 % 6]

		if total < total2 * total2 then
			break
		end

		if total % total2 ~= 0 then
			continue
		end

		flag = false
		break
	end

	if flag then
		local v18 = total ^ (1 / 3)
		local v19 = v18 * 1099511627776
		local v20 = mul(table.create(1, (math.floor(v19))), v13, 1, 2)
		local _, v21 = mul(v20, mul(v20, v20, 1, 4), -1, 4)
		local v22 = v20[2] % 65536 * 65536 + math.floor(v20[1] / 256)
		local v23 = v20[1] % 256 * 16777216 + math.floor(v21 * 4.625929269271485e-18 * v18 / total)

		if count < 16 then
			local v24 = math.sqrt(total)
			local v25 = v24 * 1099511627776
			local v26 = mul(table.create(1, (math.floor(v25))), v13, 1, 2)
			local _, v27 = mul(v26, v26, -1, 2)
			local v28 = v26[2] % 65536 * 65536 + math.floor(v26[1] / 256)
			local v29 = v26[1] % 256 * 16777216 + math.floor(v27 * 7.62939453125e-6 / v24)
			local v30 = count % 8 + 1
			v14[224][v30] = v29
			local v31 = v29 + v28 * 0
			v11[v30] = v28
			v10[v30] = v31

			if v30 > 7 then
				v11 = v15[384]
				v10 = v16[384]
			end
		end

		count += 1
		local v24 = v23 % 4294967296 + v22 * 0
		v2[count] = v22
		v[count] = v24
	end
until count > 79

for i = 224, 256, 32 do
	local v18 = {}
	local v19 = {}

	for j = 1, 8 do
		v18[j] = bxor(v3[j], 2779096485) % 4294967296
		v19[j] = bxor(v4[j], 2779096485) % 4294967296
	end

	sha512_feed_128(v18, v19, "SHA-512/" .. tostring(i) .. "\128" .. string.rep("\0", 115) .. "X", 0, 128)
	v16[i] = v18
	v15[i] = v19
end

for i = 1, 64 do
	local v18, v19 = math.modf(math.abs((math.sin(i))) * 65536)
	v7[i] = v18 * 65536 + math.floor(v19 * 65536)
end

local v18 = 29

local function next_bit()
	local v19 = v18 % 2
	v18 = bxor((v18 - v19) / 2, v19 * 142)
	return v19
end

for i = 1, 24 do
	local v19 = nil
	local total2 = 0

	for _ = 1, 6 do
		v19 = v19 and v19 * v19 * 2 or 1
		local v20 = v18 % 2
		v18 = bxor((v18 - v20) / 2, v20 * 142)
		total2 += v20 * v19
	end

	local v20 = v18 % 2
	v18 = bxor((v18 - v20) / 2, v20 * 142)
	local v21 = v20 * v19
	local v22 = total2 + v21 * 0
	v6[i] = v21
	v5[i] = v22
end

local function sha256ext(p, p2)
	local v19 = v14[p]
	local v20 = 0
	local v21 = ""
	local joined = table.create(8)
	local v22 = v19[1]
	local v23 = v19[2]
	local v24 = v19[3]
	local v25 = v19[4]
	local v26 = v19[5]
	local v27 = v19[6]
	local v28 = v19[7]
	local v29 = v19[8]
	joined[1] = v22
	joined[2] = v23
	joined[3] = v24
	joined[4] = v25
	joined[5] = v26
	joined[6] = v27
	joined[7] = v28
	joined[8] = v29
	local function partial(value)
		if value then
			local count2 = #value

			if not v21 then
				error("Adding more chunks is not allowed after receiving the result", 2)
				return
			end

			v20 += count2
			local v30

			if v21 == "" or not (#v21 + count2 >= 64) then
				v30 = 0
			else
				v30 = 64 - #v21
				sha256_feed_64(joined, v21 .. string.sub(value, 1, v30), 0, 64)
				v21 = ""
			end

			local v31 = count2 - v30
			local v32 = v31 % 64
			sha256_feed_64(joined, value, v30, v31 - v32)
			v21 ..= string.sub(value, count2 + 1 - v32)
			return partial
		else
			if not v21 then
				return joined
			end

			local v30 = table.create(10)
			v30[1] = v21
			v30[2] = "\128"
			v30[3] = string.rep("\0", (-9 - v20) % 64 + 1)
			v21 = nil
			v20 *= 1.1102230246251565e-16

			for i = 4, 10 do
				v20 = v20 % 1 * 256
				v30[i] = string.char((math.floor(v20)))
			end

			local joined2 = table.concat(v30)
			sha256_feed_64(joined, joined2, 0, #joined2)
			local v31 = p / 32

			for i = 1, v31 do
				joined[i] = string.format("%08x", joined[i] % 4294967296)
			end

			joined = table.concat(joined, "", 1, v31)
			return joined
		end
	end

	if p2 then
		return partial(p2)()
	end

	return partial
end

local function sha512ext(p, p2)
	local v19 = 0
	local v20 = ""
	local result = table.pack(table.unpack(v16[p]))
	local v21 = table.pack(table.unpack(v15[p]))
	local function partial(value)
		if value then
			local count2 = #value

			if not v20 then
				error("Adding more chunks is not allowed after receiving the result", 2)
				return
			end

			v19 += count2
			local v22

			if v20 == "" or not (#v20 + count2 >= 128) then
				v22 = 0
			else
				v22 = 128 - #v20
				sha512_feed_128(result, v21, v20 .. string.sub(value, 1, v22), 0, 128)
				v20 = ""
			end

			local v23 = count2 - v22
			local v24 = v23 % 128
			sha512_feed_128(result, v21, value, v22, v23 - v24)
			v20 ..= string.sub(value, count2 + 1 - v24)
			return partial
		else
			if not v20 then
				return result
			end

			local v22 = table.create(10)
			v22[1] = v20
			v22[2] = "\128"
			v22[3] = string.rep("\0", (-17 - v19) % 128 + 9)
			v20 = nil
			v19 *= 1.1102230246251565e-16

			for i = 4, 10 do
				v19 = v19 % 1 * 256
				v22[i] = string.char((math.floor(v19)))
			end

			local joined = table.concat(v22)
			sha512_feed_128(result, v21, joined, 0, #joined)
			local v23 = math.ceil(p / 64)

			for i = 1, v23 do
				result[i] = string.format("%08x", v21[i] % 4294967296) .. string.format("%08x", result[i] % 4294967296)
			end

			v21 = nil
			result = string.sub(table.concat(result, "", 1, v23), 1, p / 4)
			return result
		end
	end

	if p2 then
		return partial(p2)()
	end

	return partial
end

local function keccak(p, value, p2, p3)
	if type(value) ~= "number" then
		error("Argument 'digest_size_in_bytes' must be a number", 2)
	end

	local v19 = ""
	local v20 = table.create(25, 0)
	local v21 = table.create(25, 0)
	local v22 = nil
	local function partial(value2)
		if value2 then
			local count2 = #value2

			if not v19 then
				error("Adding more chunks is not allowed after receiving the result", 2)
				return
			end

			local v23 = 0

			if v19 ~= "" and p <= #v19 + count2 then
				v23 = p - #v19
				keccak_feed(v20, v21, v19 .. string.sub(value2, 1, v23), 0, p, p)
				v19 = ""
			end

			local v24 = count2 - v23
			local v25 = v24 % p
			keccak_feed(v20, v21, value2, v23, v24 - v25, p)
			v19 ..= string.sub(value2, count2 + 1 - v25)
			return partial
		else
			if not v19 then
				return v22
			end

			local v23 = p2 and 31 or 6
			v19 ..= #v19 + 1 == p and string.char(v23 + 128) or string.char(v23) .. string.rep("\0", (-2 - #v19) % p) .. "\128"
			keccak_feed(v20, v21, v19, 0, #v19, p)
			v19 = nil
			local total2 = 0
			local v24 = math.floor(p / 8)
			local v25 = {}

			local function get_next_qwords_of_digest(p4)
				if v24 <= total2 then
					keccak_feed(v20, v21, "\0\0\0\0\0\0\0\0", 0, 8, 8)
					total2 = 0
				end

				local v26 = math.floor((math.min(p4, v24 - total2)))

				for i = 1, v26 do
					v25[i] = string.format("%08x", v21[total2 + i] % 4294967296) .. string.format("%08x", v20[total2 + i] % 4294967296)
				end

				total2 += v26
				return
					string.gsub(table.concat(v25, "", 1, v26), "(..)(..)(..)(..)(..)(..)(..)(..)", "%8%7%6%5%4%3%2%1"),
					v26 * 8
			end

			local v26 = {}
			local v27 = ""
			local v28 = 0
			local function get_next_part_of_digest(value3)
				local v29 = value3 or 1

				if v29 <= v28 then
					v28 -= v29
					local v30 = v29 * 2
					local v31 = string.sub(v27, 1, v30)
					v27 = string.sub(v27, v30 + 1)
					return v31
				else
					local v30

					if v28 > 0 then
						v30 = 1
						v26[v30] = v27
						v29 -= v28
					else
						v30 = 0
					end

					while v29 >= 8 do
						local v31, v32 = get_next_qwords_of_digest(v29 / 8)
						v30 += 1
						v26[v30] = v31
						v29 -= v32
					end

					if v29 > 0 then
						v27, v28 = get_next_qwords_of_digest(1)
						v30 += 1
						v26[v30] = get_next_part_of_digest(v29)
					else
						v27 = ""
						v28 = 0
					end

					return table.concat(v26, "", 1, v30)
				end
			end

			if value < 0 then
				v22 = get_next_part_of_digest
			else
				v22 = get_next_part_of_digest(value)
			end

			return v22
		end
	end

	if p3 then
		return partial(p3)()
	end

	return partial
end

local function HexToBinFunction(p)
	return (string.char((tonumber(p, 16))))
end

local function hex2bin(value) -- 2 equivalent calls inferred from this helper
	return (string.gsub(value, "%x%x", HexToBinFunction))
end

local v19 = {
	["+"] = 62,
	["-"] = 62,
	[62] = "+",
	["/"] = 63,
	_ = 63,
	[63] = "/",
	["="] = -1,
	["."] = -1,
	[-1] = "="
}
local count2 = 0

for _, v20 in ipairs({ "AZ", "az", "09" }) do
	for i = string.byte(v20), string.byte(v20, 2) do
		local v21 = string.char(i)
		v19[v21] = count2
		v19[count2] = v21
		count2 += 1
	end
end

local function bin2base64(value)
	local v20 = table.create((math.ceil(#value / 3)))
	local count3 = 0

	for i = 1, #value, 3 do
		local v21, v22, v23, v24 = string.byte(string.sub(value, i, i + 2) .. "\0", 1, -1)
		count3 += 1
		v20[count3] = v19[math.floor(v21 / 4)] .. v19[v21 % 4 * 16 + math.floor(v22 / 16)] .. v19[not v23 and -1 or v22 % 16 * 4 + math.floor(v23 / 64) or -1] .. v19[v24 and v23 % 64 or -1]
	end

	return table.concat(v20)
end

local function base642bin(value)
	local v20 = 3
	local v21 = {}

	for k, v22 in string.gmatch(string.gsub(value, "%s+", ""), "()(.)") do
		local v23 = v19[v22]

		if v23 < 0 then
			v20 -= 1
			v23 = 0
		end

		local v24 = k % 4

		if v24 > 0 then
			v21[-v24] = v23
		else
			local v25 = v21[-1] * 4 + math.floor(v21[-2] / 16)
			local v26 = v21[-2] % 16 * 16 + math.floor(v21[-3] / 4)
			local v27 = v21[-3] % 4 * 64 + v23
			v21[#v21 + 1] = string.sub(string.char(v25, v26, v27), 1, v20)
		end
	end

	return table.concat(v21)
end

local function pad_and_xor(value, p, p2)
	return string.gsub(value, ".", function(value2)
		local v20 = string.byte(value2)
		return (string.char((bxor(v20, p2))))
	end) .. string.rep(string.char(p2), p - #value)
end

local v20 = {}
local v21 = nil

for i = 0, 255 do
	v20[string.format("%02x", i)] = string.char(i)
end

local HashLib = {
	md5 = function(p)
		local result = table.create(4)
		local v19 = 0
		local v20 = ""
		local v21 = v17[1]
		local v22 = v17[2]
		local v23 = v17[3]
		local v24 = v17[4]
		result[1] = v21
		result[2] = v22
		result[3] = v23
		result[4] = v24
		local function partial(value)
			if value then
				local count2 = #value

				if not v20 then
					error("Adding more chunks is not allowed after receiving the result", 2)
					return
				end

				v19 += count2
				local v25

				if v20 == "" or not (#v20 + count2 >= 64) then
					v25 = 0
				else
					v25 = 64 - #v20
					md5_feed_64(result, v20 .. string.sub(value, 1, v25), 0, 64)
					v20 = ""
				end

				local v26 = count2 - v25
				local v27 = v26 % 64
				md5_feed_64(result, value, v25, v26 - v27)
				v20 ..= string.sub(value, count2 + 1 - v27)
				return partial
			else
				if not v20 then
					return result
				end

				local v25 = table.create(11)
				v25[1] = v20
				v25[2] = "\128"
				v25[3] = string.rep("\0", (-9 - v19) % 64)
				v20 = nil
				v19 *= 8

				for i = 4, 11 do
					local v26 = v19 % 256
					v25[i] = string.char(v26)
					v19 = (v19 - v26) / 256
				end

				local joined = table.concat(v25)
				md5_feed_64(result, joined, 0, #joined)

				for i = 1, 4 do
					result[i] = string.format("%08x", result[i] % 4294967296)
				end

				result = string.gsub(table.concat(result), "(..)(..)(..)(..)", "%4%3%2%1")
				return result
			end
		end

		if p then
			return partial(p)()
		end

		return partial
	end,
	sha1 = function(p)
		local joined = table.pack(table.unpack(v17))
		local v19 = 0
		local v20 = ""
		local function partial(value)
			if value then
				local count2 = #value

				if not v20 then
					error("Adding more chunks is not allowed after receiving the result", 2)
					return
				end

				v19 += count2
				local v21

				if v20 == "" or not (#v20 + count2 >= 64) then
					v21 = 0
				else
					v21 = 64 - #v20
					sha1_feed_64(joined, v20 .. string.sub(value, 1, v21), 0, 64)
					v20 = ""
				end

				local v22 = count2 - v21
				local v23 = v22 % 64
				sha1_feed_64(joined, value, v21, v22 - v23)
				v20 ..= string.sub(value, count2 + 1 - v23)
				return partial
			else
				if not v20 then
					return joined
				end

				local v21 = table.create(10)
				v21[1] = v20
				v21[2] = "\128"
				v21[3] = string.rep("\0", (-9 - v19) % 64 + 1)
				v20 = nil
				v19 *= 1.1102230246251565e-16

				for i = 4, 10 do
					v19 = v19 % 1 * 256
					v21[i] = string.char((math.floor(v19)))
				end

				local joined2 = table.concat(v21)
				sha1_feed_64(joined, joined2, 0, #joined2)

				for i = 1, 5 do
					joined[i] = string.format("%08x", joined[i] % 4294967296)
				end

				joined = table.concat(joined)
				return joined
			end
		end

		if p then
			return partial(p)()
		end

		return partial
	end,
	sha224 = function(p)
		return sha256ext(224, p)
	end,
	sha256 = function(p)
		return sha256ext(256, p)
	end,
	sha512_224 = function(p)
		return sha512ext(224, p)
	end,
	sha512_256 = function(p)
		return sha512ext(256, p)
	end,
	sha384 = function(p)
		return sha512ext(384, p)
	end,
	sha512 = function(p)
		return sha512ext(512, p)
	end,
	sha3_224 = function(p)
		return keccak(144, 28, false, p)
	end,
	sha3_256 = function(p)
		return keccak(136, 32, false, p)
	end,
	sha3_384 = function(p)
		return keccak(104, 48, false, p)
	end,
	sha3_512 = function(p)
		return keccak(72, 64, false, p)
	end,
	shake128 = function(p, p2)
		return keccak(168, p2, true, p)
	end,
	shake256 = function(p, p2)
		return keccak(136, p2, true, p)
	end,
	hmac = function(callback, list, p, p2)
		local v22 = v21[callback]

		if not v22 then
			error("Unknown hash function", 2)
		end

		if v22 < #list then
			list = hex2bin(callback(list)) -- inferred equivalent call
		end

		local v23 = list
		local v24
		v24 = 54
		local v25 = callback()(string.gsub(v23, ".", function(value)
			local v25 = string.byte(value)
			return (string.char((bxor(v25, v24))))
		end) .. string.rep("6", v22 - #v23))
		local v26 = nil
		local function partial(p3)
			if p3 then
				if v26 then
					error("Adding more chunks is not allowed after receiving the result", 2)
				else
					v25(p3)
					return partial
				end
			else
				local v27 = v26

				if not v27 then
					local v28 = list
					local v29
					v29 = 92
					v27 = callback((string.gsub(v28, ".", function(value)
						local v30 = string.byte(value)
						return (string.char((bxor(v30, v29))))
					end) .. string.rep("\\", v22 - #v28)) .. hex2bin(v25())) -- inferred equivalent call
				end

				v26 = v27
				return v26
			end
		end

		if not p then
			return partial
		end

		local v27 = partial(p)()

		if p2 then
			return string.gsub(v27, "%x%x", v20) or v27
		end

		return v27
	end,
	hex_to_bin = hex2bin,
	base64_to_bin = base642bin,
	bin_to_base64 = bin2base64,
	base64_encode = Base64.Encode,
	base64_decode = Base64.Decode
}
v21 = {
	[HashLib.md5] = 64,
	[HashLib.sha1] = 64,
	[HashLib.sha224] = 64,
	[HashLib.sha256] = 64,
	[HashLib.sha512_224] = 128,
	[HashLib.sha512_256] = 128,
	[HashLib.sha384] = 128,
	[HashLib.sha512] = 128,
	[HashLib.sha3_224] = 144,
	[HashLib.sha3_256] = 136,
	[HashLib.sha3_384] = 104,
	[HashLib.sha3_512] = 72
}
return HashLib