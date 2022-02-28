name = "k_path_large-epochbest-k5"

flag = False
d = {}

with open(f"output/{name}.out") as f:
    line = f.readline()
    while line:
        if line[0].isdigit():
            if flag:
                break
            else:
                line = f.readline()
                continue
        flag = True
        src = line.strip().split('\t')[1]
        ref = f.readline().strip().split('\t')[1]
        score = float(f.readline().strip().split('\t')[1])
        sys = f.readline().strip().split('\t')[2]
        
        xs = src.split(";")
        x = xs[0].strip()
        y = xs[-1].split(":")[-1].strip()
        
        p = (x,y)
        if p not in d:
            d[p] = {"src": src, "ref": ref, "sys": sys, "score": score, "count": 1}
        else:
            if score > d[p]["score"]:
                d[p]["src"] = src
                d[p]["sys"] = sys
                d[p]["score"] = score
                d[p]["count"] += 1
        
        f.readline()
        line = f.readline()
            

with open("input/shortest_path/test.src") as f, open(f"output/{name}.out.ref", 'w') as f1, open(f"output/{name}.out.sys", 'w') as f2:
    for line in f:
        xs = line.strip().split(';')
        x = xs[0].strip()
        y = xs[-1].split(":")[-1].strip()
        d_ = d[(x,y)]
        print(d_["ref"], file=f1)
        print(d_["sys"], file=f2)
        
        
    
        