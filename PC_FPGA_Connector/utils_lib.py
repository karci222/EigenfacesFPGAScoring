def byte_to_int(data):
    res = data[0]
    loc1 = data[1] << 8
    loc2 = data[2] << 16
    loc3 = data[3] << 24
    res = res + loc1 + loc2 + loc3
    return res
def process_data(data):
    res_new = [0 for i in range(len(data))]
    j = 0 
    for i in data:
        res_new[j] = byte_to_int(i)
        j = j + 1
    return res_new
def find_min(data):
    j = 0
    min_index = 0
    min_value = sys.maxsize
    for i in data:
        if i < min_value:
            min_value = i
            min_index = j
        j = j + 1
    return min_index + 1